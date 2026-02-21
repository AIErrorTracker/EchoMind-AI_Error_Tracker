import asyncio
import json
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Tuple

from playwright.async_api import async_playwright

ROOT = Path(__file__).resolve().parents[1]
PAGES_DIR = ROOT / "pages"
OUT_DIR = ROOT / "artifacts" / "layout-validation"
SCREENSHOT_DIR = OUT_DIR / "screenshots"
REPORT_DIR = OUT_DIR / "report"
BASE_URL = os.getenv("MOCK_TEST_BASE_URL", "http://localhost:5500")
SEED = int(os.getenv("MOCK_TEST_SEED", "20260220"))

MODES = ["baseline", "stress", "edge"]
VIEWPORTS = [
    {"name": "320x568", "width": 320, "height": 568},
    {"name": "375x812", "width": 375, "height": 812},
    {"name": "390x844", "width": 390, "height": 844},
    {"name": "412x915", "width": 412, "height": 915},
    {"name": "430x932", "width": 430, "height": 932},
    {"name": "768x1024", "width": 768, "height": 1024},
    {"name": "834x1194", "width": 834, "height": 1194},
]

TARGET_PAGES = [
    "ai-diagnosis",
    "community",
    "flashcard-review",
    "global-exam",
    "global-knowledge",
    "global-model",
    "index",
    "knowledge-detail",
    "knowledge-learning",
    "memory",
    "model-detail",
    "model-training",
    "prediction-center",
    "profile",
    "question-aggregate",
    "question-detail",
    "upload-history",
    "weekly-review",
]


@dataclass
class CaseResult:
    page: str
    mode: str
    viewport: str
    screenshot: str
    passed: bool
    failures: List[str]
    metrics: Dict


def list_pages() -> List[str]:
    existing = {
        p.name
        for p in PAGES_DIR.iterdir()
        if p.is_dir() and (p / "index.html").exists()
    }
    return [page for page in TARGET_PAGES if page in existing]


async def evaluate_layout(page) -> Dict:
    js = r'''
() => {
  const viewportH = window.innerHeight || document.documentElement.clientHeight || 0;
  const out = {
    horizontalOverflowPx: 0,
    overlapIssues: [],
    bottomOverlapIssues: [],
    routeIssues: [],
    inlineNavigateToCount: 0,
    regions: [],
    listRegions: [],
    textGuardCount: document.querySelectorAll('.u-ellipsis-1, .u-clamp-2, .u-wrap-break').length
  };

  const frame = document.querySelector('.phone-frame');
  const html = document.documentElement;
  const body = document.body;

  const docOverflow = Math.max(0, html.scrollWidth - html.clientWidth, body ? body.scrollWidth - body.clientWidth : 0);
  const frameOverflow = frame ? Math.max(0, frame.scrollWidth - frame.clientWidth) : 0;
  out.horizontalOverflowPx = Math.max(docOverflow, frameOverflow);

  const regionNodes = Array.from(document.querySelectorAll('[data-region]')).filter((el) => {
    const ancestor = el.parentElement ? el.parentElement.closest('[data-region]') : null;
    return !ancestor;
  }).map((el) => {
    const st = window.getComputedStyle(el);
    const r = el.getBoundingClientRect();
    const isBottomOverlay = (
      (st.position === 'fixed' || st.position === 'absolute')
      && viewportH > 0
      && (viewportH - r.bottom) <= 140
      && r.height > 0
      && r.height <= viewportH * 0.45
      && r.top >= viewportH * 0.35
    );
    return {
      name: el.getAttribute('data-region') || '',
      top: r.top,
      bottom: r.bottom,
      left: r.left,
      right: r.right,
      width: r.width,
      height: r.height,
      visible: st.display !== 'none' && st.visibility !== 'hidden' && r.width > 0 && r.height > 0,
      position: st.position,
      isBottomOverlay,
    };
  }).filter((x) => x.visible);

  regionNodes.sort((a, b) => (a.top - b.top) || (a.left - b.left));
  out.regions = regionNodes;

  for (let i = 0; i < regionNodes.length - 1; i++) {
    const a = regionNodes[i];
    const b = regionNodes[i + 1];
    if (
      (a.name && a.name.indexOf('action-overlay') >= 0)
      || (b.name && b.name.indexOf('action-overlay') >= 0)
    ) {
      continue;
    }
    if (a.isBottomOverlay || b.isBottomOverlay) {
      continue;
    }
    const horizontalIntersect = Math.min(a.right, b.right) - Math.max(a.left, b.left) > 0;
    if (horizontalIntersect && b.top < a.bottom - 1) {
      out.overlapIssues.push(`${a.name} -> ${b.name}`);
    }
  }

  const listNodes = Array.from(document.querySelectorAll('[data-list-region]'));
  out.listRegions = listNodes.map((el) => {
    const name = el.getAttribute('data-list-region') || 'unnamed-list';
    const directChildren = Array.from(el.children || []);
    const directListItems = directChildren.filter((node) => node.classList && node.classList.contains('list-item'));
    const count = directListItems.length > 0 ? directListItems.length : directChildren.length;

    const r = el.getBoundingClientRect();
    let nextTop = null;
    const region = regionNodes.find((x) => x.name === (el.getAttribute('data-region') || ''));
    if (region) {
      const idx = regionNodes.findIndex((x) => x.name === region.name && Math.abs(x.top - region.top) < 1);
      if (idx >= 0 && idx + 1 < regionNodes.length) {
        nextTop = regionNodes[idx + 1].top;
      }
    }

    return {
      name,
      top: r.top,
      bottom: r.bottom,
      count,
      nextTop,
    };
  });

  const overlays = [
    ...Array.from(document.querySelectorAll('.chat-input-bar, .tab-bar')),
    ...Array.from(document.querySelectorAll('.fab')),
  ].filter((el) => {
    const st = getComputedStyle(el);
    const r = el.getBoundingClientRect();
    return (
      st.display !== 'none'
      && st.visibility !== 'hidden'
      && r.width > 0
      && r.height > 0
      && r.bottom > 0
      && r.top < viewportH
    );
  });

  const actions = Array.from(document.querySelectorAll('[data-primary-action], .btn.btn-primary, .chat-send, .fc-btn.easy'))
    .filter((el) => {
      const st = getComputedStyle(el);
      const r = el.getBoundingClientRect();
      return (
        st.display !== 'none'
        && st.visibility !== 'hidden'
        && r.width > 0
        && r.height > 0
        && r.bottom > 0
        && r.top < viewportH
      );
    });

  overlays.forEach((overlay) => {
    const o = overlay.getBoundingClientRect();
    actions.forEach((action) => {
      const a = action.getBoundingClientRect();
      const overlapW = Math.min(o.right, a.right) - Math.max(o.left, a.left);
      const overlapH = Math.min(o.bottom, a.bottom) - Math.max(o.top, a.top);
      const horizontalIntersect = overlapW > 0;
      const verticalIntersect = overlapH > 0;
      if (overlay.contains(action) || action.contains(overlay)) {
        return;
      }
      if (horizontalIntersect && verticalIntersect) {
        const actionStyle = getComputedStyle(action);
        const isFlowAction = actionStyle.position !== 'fixed' && actionStyle.position !== 'absolute';
        if (
          isFlowAction
          && (
            overlay.classList.contains('tab-bar')
            || overlay.classList.contains('fab')
            || overlay.classList.contains('chat-input-bar')
          )
        ) {
          return;
        }

        const overlapArea = overlapW * overlapH;
        const actionArea = Math.max(1, a.width * a.height);
        const overlayArea = Math.max(1, o.width * o.height);
        const actionOverlapRatio = overlapArea / actionArea;
        const overlayOverlapRatio = overlapArea / overlayArea;
        if (actionOverlapRatio < 0.22 && overlayOverlapRatio < 0.65) {
          return;
        }
        out.bottomOverlapIssues.push({
          overlay: overlay.className || overlay.tagName,
          action: action.className || action.tagName,
        });
      }
    });
  });

  out.inlineNavigateToCount = document.querySelectorAll('[onclick*=\"navigateTo\"]').length;
  const routeNodes = Array.from(document.querySelectorAll('[data-route]'));
  out.routeIssues = routeNodes.map((node) => {
    const routeValue = node.getAttribute('data-route') || '';
    const valid = typeof window.hasRouteId === 'function' ? window.hasRouteId(routeValue) : true;
    if (!valid) return routeValue || '(empty)';
    return null;
  }).filter(Boolean);

  return out;
}
'''
    return await page.evaluate(js)


def compare_list_pushdown(
    baseline_metrics: Dict[str, Dict],
    current_metrics: Dict,
    page_name: str,
    viewport_name: str,
) -> List[str]:
    failures: List[str] = []
    base = baseline_metrics.get(f"{page_name}::{viewport_name}")
    if not base:
        return failures

    base_lists = {item["name"]: item for item in base.get("listRegions", [])}
    for item in current_metrics.get("listRegions", []):
        name = item.get("name")
        if name not in base_lists:
            continue
        b = base_lists[name]
        if item.get("count", 0) > b.get("count", 0):
            next_top = item.get("nextTop")
            base_next_top = b.get("nextTop")
            if next_top is not None and base_next_top is not None and next_top + 1 < base_next_top:
                failures.append(
                    f"list '{name}' count increased ({b.get('count')} -> {item.get('count')}) but next region did not move down"
                )
    return failures


async def run() -> Tuple[List[CaseResult], Dict]:
    SCREENSHOT_DIR.mkdir(parents=True, exist_ok=True)
    REPORT_DIR.mkdir(parents=True, exist_ok=True)

    pages = list_pages()
    results: List[CaseResult] = []
    baseline_metrics: Dict[str, Dict] = {}

    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True)

        for viewport in VIEWPORTS:
            context = await browser.new_context(viewport={"width": viewport["width"], "height": viewport["height"]})
            page = await context.new_page()

            for page_name in pages:
                for mode in MODES:
                    url = f"{BASE_URL}/pages/{page_name}/index.html?mock={mode}&seed={SEED}"
                    await page.goto(url, wait_until="domcontentloaded")
                    await page.wait_for_timeout(450)

                    shot_dir = SCREENSHOT_DIR / page_name / mode
                    shot_dir.mkdir(parents=True, exist_ok=True)
                    shot_path = shot_dir / f"{viewport['name']}.png"
                    await page.screenshot(path=str(shot_path), full_page=False)

                    metrics = await evaluate_layout(page)
                    failures: List[str] = []

                    if metrics.get("horizontalOverflowPx", 0) > 1:
                        failures.append(f"horizontal overflow {metrics['horizontalOverflowPx']}px")

                    overlap_issues = metrics.get("overlapIssues", [])
                    if overlap_issues:
                        failures.append(f"region overlap: {', '.join(overlap_issues[:6])}")

                    if mode != "baseline":
                        failures.extend(compare_list_pushdown(baseline_metrics, metrics, page_name, viewport["name"]))
                        if metrics.get("textGuardCount", 0) < 1:
                            failures.append("text guard classes are too few (<1)")

                    bottom_overlaps = metrics.get("bottomOverlapIssues", [])
                    if bottom_overlaps:
                        failures.append(f"bottom overlay overlap count={len(bottom_overlaps)}")

                    route_issues = metrics.get("routeIssues", [])
                    if route_issues:
                        failures.append(f"invalid data-route ids: {', '.join(route_issues[:10])}")

                    inline_navigate = metrics.get("inlineNavigateToCount", 0)
                    if inline_navigate > 0:
                        failures.append(f"inline navigateTo usage count={inline_navigate}")

                    case = CaseResult(
                        page=page_name,
                        mode=mode,
                        viewport=viewport["name"],
                        screenshot=str(shot_path.relative_to(ROOT)),
                        passed=len(failures) == 0,
                        failures=failures,
                        metrics=metrics,
                    )
                    results.append(case)

                    if mode == "baseline":
                        baseline_metrics[f"{page_name}::{viewport['name']}"] = metrics

            await context.close()

        await browser.close()

    summary = {
        "total": len(results),
        "passed": sum(1 for r in results if r.passed),
        "failed": sum(1 for r in results if not r.passed),
        "pages": pages,
        "modes": MODES,
        "viewports": [v["name"] for v in VIEWPORTS],
    }

    return results, summary


def write_reports(results: List[CaseResult], summary: Dict) -> None:
    json_path = REPORT_DIR / "layout-report.json"
    md_path = REPORT_DIR / "layout-report.md"

    payload = {
        "summary": summary,
        "results": [
            {
                "page": r.page,
                "mode": r.mode,
                "viewport": r.viewport,
                "screenshot": r.screenshot,
                "passed": r.passed,
                "failures": r.failures,
                "metrics": r.metrics,
            }
            for r in results
        ],
    }
    json_path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")

    lines: List[str] = []
    lines.append("# Mock Layout Validation Report")
    lines.append("")
    lines.append(f"- Total cases: **{summary['total']}**")
    lines.append(f"- Passed: **{summary['passed']}**")
    lines.append(f"- Failed: **{summary['failed']}**")
    lines.append("")

    failed_cases = [r for r in results if not r.passed]
    if not failed_cases:
        lines.append("All cases passed.")
    else:
        lines.append("## Failed Cases")
        lines.append("")
        for item in failed_cases:
            lines.append(f"### {item.page} / {item.mode} / {item.viewport}")
            lines.append(f"- Screenshot: `{item.screenshot}`")
            for reason in item.failures:
                lines.append(f"- {reason}")
            lines.append("")

    md_path.write_text("\n".join(lines), encoding="utf-8")


async def main() -> None:
    results, summary = await run()
    write_reports(results, summary)
    print(json.dumps(summary, ensure_ascii=False))


if __name__ == "__main__":
    asyncio.run(main())
