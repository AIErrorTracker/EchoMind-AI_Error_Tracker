import argparse
import asyncio
import json
import re
import shutil
import subprocess
import sys
import time
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple
from urllib.error import URLError
from urllib.parse import urlparse
from urllib.request import urlopen

from playwright.async_api import async_playwright


ROOT = Path(__file__).resolve().parents[1]
REPO_ROOT = ROOT.parent
PAGES_DIR = ROOT / "pages"
ROUTER_PATH = ROOT / "shared" / "router.js"

DEFAULT_BASE_URL = "http://localhost:5500"
DEFAULT_OUTPUT_ROOT = REPO_ROOT / "docs" / "第一阶段_html细化" / "html截图验证"
DEFAULT_DOC_PATH = REPO_ROOT / "docs" / "第一阶段_html细化" / "html页面组件功能截图核对手册.md"

VIEWPORTS = [
    {"name": "390x844", "width": 390, "height": 844},
    {"name": "430x932", "width": 430, "height": 932},
    {"name": "834x1194", "width": 834, "height": 1194},
]
BASE_COMPONENT_VIEWPORT = VIEWPORTS[0]

STATE_SCENARIOS = {
    "community": [
        {
            "scenario_id": "tab-0",
            "action_js": "window.switchCommTab && window.switchCommTab(0)",
            "target_components": ["board-my-requests"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "tab-1",
            "action_js": "window.switchCommTab && window.switchCommTab(1)",
            "target_components": ["board-feature-boost"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "tab-2",
            "action_js": "window.switchCommTab && window.switchCommTab(2)",
            "target_components": ["board-feedback"],
            "wait_ms": 350,
        },
    ],
    "knowledge-learning": [
        {
            "scenario_id": "step-1",
            "action_js": "window.switchKnowledgeLearningStep && window.switchKnowledgeLearningStep(1)",
            "target_components": ["step-1-concept-present"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-2",
            "action_js": "window.switchKnowledgeLearningStep && window.switchKnowledgeLearningStep(2)",
            "target_components": ["step-2-understanding-check"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-3",
            "action_js": "window.switchKnowledgeLearningStep && window.switchKnowledgeLearningStep(3)",
            "target_components": ["step-3-discrimination-training"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-4",
            "action_js": "window.switchKnowledgeLearningStep && window.switchKnowledgeLearningStep(4)",
            "target_components": ["step-4-practical-application"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-5",
            "action_js": "window.switchKnowledgeLearningStep && window.switchKnowledgeLearningStep(5)",
            "target_components": ["step-5-concept-test"],
            "wait_ms": 350,
        },
    ],
    "model-training": [
        {
            "scenario_id": "step-1",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(1)",
            "target_components": ["step-1-identification-training"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-2",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(2)",
            "target_components": ["step-2-decision-training"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-3",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(3)",
            "target_components": ["step-3-equation-training"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-4",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(4)",
            "target_components": ["step-4-trap-analysis"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-5",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(5)",
            "target_components": ["step-5-complete-solve"],
            "wait_ms": 350,
        },
        {
            "scenario_id": "step-6",
            "action_js": "window.switchModelTrainingStep && window.switchModelTrainingStep(6)",
            "target_components": ["step-6-variation-training"],
            "wait_ms": 350,
        },
    ],
}

PAGE_PURPOSES = {
    "index": "首页负责汇总学习状态、推荐下一步学习动作，并提供上传快捷入口，是错题闭环的主入口。",
    "community": "社区页承载需求反馈与版本建议，采用三选栏切换同层内容板块。",
    "global-knowledge": "全局知识点页用于浏览可折叠知识树，定位知识点并进入知识详情。",
    "global-model": "全局模型页用于浏览可折叠模型树，定位训练模型并进入模型详情。",
    "global-exam": "全局高考卷页用于卷面热力图分析和题型/卷子入口导航。",
    "memory": "记忆页展示今日复习状态与卡片分类，连接闪卡复习流程。",
    "profile": "我的页面集中展示用户信息、目标分、功能入口和学习统计。",
    "upload-history": "上传历史页按筛选与日期分组展示错题记录，支持回看与追溯。",
    "question-aggregate": "单题统计页聚焦题号层面的做题表现与考情分析。",
    "question-detail": "题目详情页展示题干、答题结果、关联模型/知识点及来源信息。",
    "ai-diagnosis": "AI诊断页基于题目上下文进行追问分析，并引导进入训练。",
    "model-detail": "模型详情页汇总掌握度、前置知识、相关题目和训练记录。",
    "model-training": "模型训练页采用多阶段导航，阶段切换与对话区解耦。",
    "knowledge-detail": "知识点详情页展示掌握度、概念检测记录和关联模型入口。",
    "knowledge-learning": "知识点学习页采用五阶段学习导航，核心是AI学习对话。",
    "flashcard-review": "闪卡复习页提供卡片翻转和记忆反馈闭环。",
    "prediction-center": "预测中心页展示预测分、趋势、提分路径和优先训练模型。",
    "weekly-review": "周复盘页总结本周学习变化并给出下周重点建议。",
    "upload-menu": "上传菜单占位页用于承接上传入口路由，保障链路完整。",
    "register-strategy": "学习策略占位页用于承接策略入口路由，保障链路完整。",
}

COMPONENT_OVERRIDES = {
    "exam-heatmap": {
        "basic_function": "卷面热力图组件，基于题号与掌握状态渲染格子，参数变化会直接影响图形结果。",
        "layout_contract": "网格区域随容器宽度自适应换列，不允许固定列宽写死导致遮挡。",
        "text_overflow_rule": "格子内题号/分值保持短文本；图例说明使用自动换行，不省略关键含义。",
        "responsive_rule": "窄屏优先保证格子可点按；宽屏增加每行列数但保持触控面积。",
    },
    "knowledge-tree": {
        "basic_function": "多层可折叠知识树组件，承载章节/节/知识点层级展开收起。",
        "layout_contract": "树节点使用自然文档流纵向展开，展开后下方模块必须被推移。",
        "text_overflow_rule": "节点标题优先两行截断；超长专业术语允许断词换行。",
        "responsive_rule": "缩窄时保持缩进层级与点击区域；平板下单列拉伸，不做双列。",
    },
    "model-tree": {
        "basic_function": "多层可折叠模型树组件，承载模型节点与子问题层级。",
        "layout_contract": "树结构展开后高度自增长，禁止固定高度裁剪内容。",
        "text_overflow_rule": "模型名称支持两行截断，必要时自动换行保留语义。",
        "responsive_rule": "不同宽度下保留层级缩进与节点间距，避免层级错位。",
    },
    "action-overlay": {
        "basic_function": "底部浮层交互组件（输入框/FAB/发送），负责关键动作入口。",
        "layout_contract": "固定贴底显示，需与主内容留出安全区，避免遮挡主操作按钮。",
        "text_overflow_rule": "输入占位文案使用单行省略；发送按钮文案保持短文本。",
        "responsive_rule": "在长屏/平板仍贴底，横向空间增大时输入框优先扩展宽度。",
    },
    "step-stage-nav": {
        "basic_function": "阶段导航组件，用于切换学习/训练步骤状态。",
        "layout_contract": "顶部粘性区域，切换步骤仅替换步骤卡，不重建对话区。",
        "text_overflow_rule": "阶段名称使用单行省略，保证导航行高度稳定。",
        "responsive_rule": "窄屏允许横向滚动或压缩间距，保持可点击性。",
    },
    "top-frame": {
        "basic_function": "页面顶栏组件，承载返回、标题和顶部导航语义。",
        "layout_contract": "位于页面上方固定区域，不与正文内容重叠。",
        "text_overflow_rule": "标题单行省略，避免顶栏高度波动。",
        "responsive_rule": "不同宽度下保持左右安全边距与点击区域。",
    },
    "top-frame-and-tabs": {
        "basic_function": "社区页顶栏与三选栏组合组件，负责板块切换入口。",
        "layout_contract": "顶部区域固定，内容区由当前tab内容承载。",
        "text_overflow_rule": "tab标题单行省略，避免挤压点击区域。",
        "responsive_rule": "宽屏下等比分配tab宽度，窄屏保持可读和可点。",
    },
}


@dataclass
class PageSpec:
    page_id: str
    route_id: str
    components_runtime: List[str]
    component_dirs: List[str]
    unmounted_components: List[str]
    state_scenarios: List[dict] = field(default_factory=list)
    component_routes: Dict[str, List[str]] = field(default_factory=dict)
    artifacts: dict = field(default_factory=dict)
    capture_errors: List[dict] = field(default_factory=list)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Export HTML verification screenshot pack and handbook.")
    parser.add_argument("--base-url", default=DEFAULT_BASE_URL, help="Static server base URL.")
    parser.add_argument("--output-root", default=str(DEFAULT_OUTPUT_ROOT), help="Output root directory.")
    parser.add_argument("--doc-path", default=str(DEFAULT_DOC_PATH), help="Handbook output markdown path.")
    parser.add_argument("--seed", default=20260220, type=int, help="Mock seed.")
    parser.add_argument("--mock", default="baseline", choices=["baseline", "stress", "edge"], help="Mock mode.")
    return parser.parse_args()


def ensure_http_server(base_url: str) -> Optional[subprocess.Popen]:
    target = f"{base_url.rstrip('/')}/pages/index/index.html"
    try:
        with urlopen(target, timeout=1.5) as resp:
            if resp.status < 400:
                return None
    except URLError:
        pass
    except Exception:
        pass

    parsed = urlparse(base_url)
    if parsed.hostname not in ("127.0.0.1", "localhost"):
        return None

    port = parsed.port or 5500
    proc = subprocess.Popen(
        [sys.executable, "-m", "http.server", str(port)],
        cwd=str(ROOT),
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    for _ in range(20):
        try:
            with urlopen(target, timeout=1.0) as resp:
                if resp.status < 400:
                    return proc
        except Exception:
            time.sleep(0.2)

    proc.terminate()
    return None


def parse_object_map(block: str) -> Dict[str, str]:
    out: Dict[str, str] = {}
    for key, value in re.findall(r"([a-zA-Z0-9_.-]+)\s*:\s*'([^']+)'", block):
        out[key.strip()] = value.strip()
    return out


def parse_router() -> Tuple[Dict[str, str], Dict[str, str]]:
    text = ROUTER_PATH.read_text(encoding="utf-8")
    routes_match = re.search(r"const\s+ROUTES\s*=\s*\{([\s\S]*?)\};", text)
    alias_match = re.search(r"const\s+FILE_TO_ROUTE\s*=\s*\{([\s\S]*?)\};", text)
    if not routes_match:
        raise RuntimeError("Cannot parse ROUTES from shared/router.js")
    routes = parse_object_map(routes_match.group(1))
    aliases = parse_object_map(alias_match.group(1) if alias_match else "")
    return routes, aliases


def parse_runtime_components(page_js_path: Path) -> List[str]:
    text = page_js_path.read_text(encoding="utf-8")
    ordered: List[str] = []

    init_match = re.search(
        r"initPageComponents\s*\(\s*[^,]+,\s*\[([\s\S]*?)\]\s*,",
        text,
    )
    if init_match:
        for c in re.findall(r"'([^']+)'", init_match.group(1)):
            if c not in ordered:
                ordered.append(c)

    for c in re.findall(r"loadComponentTemplate\(\s*'([^']+)'\s*\)", text):
        if c not in ordered:
            ordered.append(c)

    return ordered


def read_component_routes(
    page_id: str,
    component_id: str,
    route_alias: Dict[str, str],
    route_by_slug: Dict[str, str],
) -> List[str]:
    cdir = PAGES_DIR / page_id / "components" / component_id
    html_path = cdir / f"{component_id}.html"
    js_path = cdir / f"{component_id}.js"
    routes: Set[str] = set()

    if html_path.exists():
        html = html_path.read_text(encoding="utf-8")
        for route in re.findall(r'data-route="([^"]+)"', html):
            routes.add(route)
        for html_target in re.findall(r"navigateTo\(\s*'([^']+\.html)'\s*\)", html):
            route_id = route_alias.get(html_target.lower())
            if route_id:
                routes.add(route_id)

    if js_path.exists():
        js = js_path.read_text(encoding="utf-8")
        for route in re.findall(r"navigateToRoute\(\s*'([^']+)'\s*\)", js):
            routes.add(route)
        for route in re.findall(r"setRouteTarget\(\s*[^,]+,\s*'([^']+)'\s*\)", js):
            routes.add(route)
        for html_target in re.findall(r"navigateTo\(\s*'([^']+\.html)'\s*\)", js):
            route_id = route_alias.get(html_target.lower())
            if route_id:
                routes.add(route_id)

    normalized = []
    for route in sorted(routes):
        if route in route_by_slug:
            normalized.append(route_by_slug[route])
        else:
            normalized.append(route)
    return sorted(set(normalized))


def discover_specs(routes: Dict[str, str], route_alias: Dict[str, str]) -> List[PageSpec]:
    route_by_slug = {slug: route_id for route_id, slug in routes.items()}
    specs: List[PageSpec] = []

    for route_id, page_id in routes.items():
        page_dir = PAGES_DIR / page_id
        if not (page_dir / "index.html").exists():
            continue

        runtime = parse_runtime_components(page_dir / "page.js")
        comp_dir = page_dir / "components"
        component_dirs = sorted([d.name for d in comp_dir.iterdir() if d.is_dir()]) if comp_dir.exists() else []
        unmounted = sorted([c for c in component_dirs if c not in runtime])

        component_routes = {}
        for c in runtime:
            component_routes[c] = read_component_routes(page_id, c, route_alias, route_by_slug)

        specs.append(
            PageSpec(
                page_id=page_id,
                route_id=route_id,
                components_runtime=runtime,
                component_dirs=component_dirs,
                unmounted_components=unmounted,
                state_scenarios=STATE_SCENARIOS.get(page_id, []),
                component_routes=component_routes,
                artifacts={
                    "full": {},
                    "components": {"default": {}, "states": {}},
                    "captured_components": [],
                    "missing_components": [],
                },
            )
        )

    return specs


def clean_output_root(output_root: Path) -> None:
    if output_root.exists():
        for child in output_root.iterdir():
            if child.is_dir():
                shutil.rmtree(child)
            else:
                child.unlink(missing_ok=True)
    output_root.mkdir(parents=True, exist_ok=True)


def is_element_visible_expr() -> str:
    return """
        (el) => {
          if (!el) return false;
          const st = window.getComputedStyle(el);
          const r = el.getBoundingClientRect();
          return st.display !== 'none' && st.visibility !== 'hidden' && r.width > 0 && r.height > 0;
        }
    """


async def open_page(page, url: str) -> None:
    await page.goto(url, wait_until="domcontentloaded")
    await page.wait_for_timeout(450)


def rel_to_repo(path: Path) -> str:
    return str(path.resolve().relative_to(REPO_ROOT.resolve())).replace("\\", "/")


async def capture_full_pages(browser, specs: List[PageSpec], output_root: Path, base_url: str, seed: int, mock: str) -> None:
    for vp in VIEWPORTS:
        context = await browser.new_context(viewport={"width": vp["width"], "height": vp["height"]})
        page = await context.new_page()
        for spec in specs:
            url = f"{base_url.rstrip('/')}/pages/{spec.page_id}/index.html?mock={mock}&seed={seed}"
            await open_page(page, url)
            full_dir = output_root / spec.page_id / "full"
            full_dir.mkdir(parents=True, exist_ok=True)
            img_path = full_dir / f"{spec.page_id}__{vp['name']}__full.png"
            await page.screenshot(path=str(img_path), full_page=True)
            spec.artifacts["full"][vp["name"]] = rel_to_repo(img_path)
        await context.close()


def get_component_selectors(page_id: str, component_id: str) -> List[str]:
    selectors = [f'[data-component="{component_id}"]']

    if component_id == "top-frame":
        selectors.extend(['[data-region="top-frame"]', ".top-region", ".nav-bar", ".large-title"])

    if component_id == "step-stage-nav":
        selectors.extend([".kl-stage-nav", ".mt-stage-nav", '[data-region="step-stage-nav"]'])

    if page_id == "knowledge-learning" and component_id.startswith("step-"):
        selectors.append("#kl-step-card-host .card")

    if page_id == "model-training" and component_id.startswith("step-"):
        selectors.append("#mt-step-card-host .card")

    if component_id == "learning-dialogue":
        selectors.extend(['[data-region="learning-dialogue"]', "#kl-page-content"])

    if component_id == "training-dialogue":
        selectors.extend(['[data-region="training-dialogue"]', "#mt-page-content"])

    # Keep order while removing duplicates.
    seen = set()
    deduped = []
    for s in selectors:
        if s in seen:
            continue
        deduped.append(s)
        seen.add(s)
    return deduped


async def save_component_screenshot_with_fallback(
    page,
    page_id: str,
    component_id: str,
    save_path: Path,
) -> Tuple[bool, str]:
    selectors = get_component_selectors(page_id, component_id)
    attempts = 8
    last_reason = "DOM中未找到候选节点"

    for _ in range(attempts):
        found_any = False

        for selector in selectors:
            locator = page.locator(selector)
            count = await locator.count()
            if count < 1:
                continue
            found_any = True

            for idx in range(count):
                node = locator.nth(idx)
                visible = await node.evaluate(is_element_visible_expr())
                if not visible:
                    continue
                try:
                    save_path.parent.mkdir(parents=True, exist_ok=True)
                    await node.screenshot(path=str(save_path))
                    return True, f"selector={selector}"
                except Exception as ex:
                    return False, f"截图失败: {ex}"

        last_reason = "候选节点存在但当前不可见" if found_any else "DOM中未找到候选节点"
        await page.wait_for_timeout(150)

    return False, last_reason


async def capture_component_shots(browser, specs: List[PageSpec], output_root: Path, base_url: str, seed: int, mock: str) -> None:
    vp = BASE_COMPONENT_VIEWPORT
    context = await browser.new_context(viewport={"width": vp["width"], "height": vp["height"]})
    page = await context.new_page()

    for spec in specs:
        url = f"{base_url.rstrip('/')}/pages/{spec.page_id}/index.html?mock={mock}&seed={seed}"
        component_dir = output_root / spec.page_id / "components"
        component_dir.mkdir(parents=True, exist_ok=True)

        captured_any: Dict[str, str] = {}

        await open_page(page, url)
        for component_id in spec.components_runtime:
            save_path = component_dir / f"{component_id}__{vp['name']} .png"
            # keep requested naming strictly without spaces
            save_path = component_dir / f"{component_id}__{vp['name']}.png"
            ok, reason = await save_component_screenshot_with_fallback(page, spec.page_id, component_id, save_path)
            if ok:
                rel = rel_to_repo(save_path)
                spec.artifacts["components"]["default"][component_id] = rel
                captured_any[component_id] = rel
            else:
                spec.capture_errors.append(
                    {
                        "stage": "default",
                        "component_id": component_id,
                        "reason": reason,
                    }
                )

        for scenario in spec.state_scenarios:
            await open_page(page, url)
            await page.evaluate(scenario["action_js"])
            await page.wait_for_timeout(scenario.get("wait_ms", 300))
            state_id = scenario["scenario_id"]
            spec.artifacts["components"]["states"].setdefault(state_id, {})

            for component_id in scenario["target_components"]:
                save_path = component_dir / f"{component_id}__state-{state_id}__{vp['name']}.png"
                ok, reason = await save_component_screenshot_with_fallback(page, spec.page_id, component_id, save_path)
                if ok:
                    rel = rel_to_repo(save_path)
                    spec.artifacts["components"]["states"][state_id][component_id] = rel
                    captured_any[component_id] = rel
                else:
                    spec.capture_errors.append(
                        {
                            "stage": f"state:{state_id}",
                            "component_id": component_id,
                            "reason": reason,
                        }
                    )

        captured_components = sorted(captured_any.keys())
        missing_components = [c for c in spec.components_runtime if c not in captured_any]
        spec.artifacts["captured_components"] = captured_components
        spec.artifacts["missing_components"] = missing_components

    await context.close()


def component_title(component_id: str) -> str:
    return component_id.replace("-", " ").strip()


def component_contract(page_id: str, component_id: str, routes: List[str]) -> Dict[str, str]:
    if component_id in COMPONENT_OVERRIDES:
        base = COMPONENT_OVERRIDES[component_id].copy()
    else:
        fixed_bottom = component_id in {"action-overlay"} or "overlay" in component_id or component_id == "flashcard"
        sticky_top = component_id.startswith("top-frame") or component_id == "step-stage-nav" or "stage-nav" in component_id
        is_list = "list" in component_id or "history" in component_id or "progress" in component_id
        is_dashboard = "dashboard" in component_id or "score-card" in component_id or "trend-card" in component_id
        is_dialogue = "dialogue" in component_id or "main-content" in component_id and page_id == "ai-diagnosis"

        if fixed_bottom:
            layout_contract = "作为底部交互区固定贴底，主滚动内容必须避让，不得被覆盖。"
            responsive = "在窄屏优先保留输入与发送按钮可达；在宽屏单列拉伸输入区域。"
        elif sticky_top:
            layout_contract = "位于顶部导航层，负责页面识别与切换，不承载重内容列表。"
            responsive = "宽度变化时保持左右边距与点击热区稳定。"
        elif is_list:
            layout_contract = "列表区采用自然文档流纵向扩展，列表增长后应推动后续区域下移。"
            responsive = "在窄屏保持单列；在长屏增加可视条目但不改变信息层级。"
        elif is_dashboard:
            layout_contract = "统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。"
            responsive = "窄屏自动换行排列卡片，平板维持单列分组不跳层。"
        elif is_dialogue:
            layout_contract = "对话主体位于主滚动区，需与底部输入区解耦，避免输入条遮挡消息。"
            responsive = "窄屏优先消息可读；长屏扩大对话可视高度。"
        else:
            layout_contract = "功能块位于页面主内容区，跟随文档流渲染并保持上下间距一致。"
            responsive = "在不同宽度下保持单列结构，允许容器宽度自适应。"

        base = {
            "basic_function": f"{component_title(component_id)} 负责该区域的核心信息展示与交互承接。",
            "layout_contract": layout_contract,
            "text_overflow_rule": "标题建议单行省略；描述使用两行截断或自动换行；超长无空格词允许断词。",
            "responsive_rule": responsive,
        }

    outputs = "无跨页跳转，主要为页内展示/状态切换。"
    if routes:
        outputs = "可触发路由跳转: " + "、".join(sorted(set(routes))) + "。"

    base["input_output"] = f"输入: `pageData.{component_id}` 与页面状态。输出: {outputs}"
    return base


def page_layout_contract(page_id: str, component_ids: List[str]) -> str:
    has_overlay = "action-overlay" in component_ids
    has_stage = "step-stage-nav" in component_ids
    has_top = any(c.startswith("top-frame") for c in component_ids)

    lines = []
    if has_top:
        lines.append("顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。")
    if has_stage:
        lines.append("阶段导航为粘性层，切换步骤只替换步骤卡，不重建对话区。")
    if has_overlay:
        lines.append("底部浮层固定贴底，主内容预留底部安全区，避免按钮被遮挡。")
    lines.append("正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。")
    lines.append("适配策略为手机到平板单列自适应，不使用手机壳固定宽高。")
    return " ".join(lines)


def render_handbook(specs: List[PageSpec], doc_path: Path, output_root: Path) -> None:
    doc_path.parent.mkdir(parents=True, exist_ok=True)
    rel_root = Path("./html截图验证")

    lines: List[str] = []
    lines.append("# HTML页面组件功能截图核对手册（第一阶段）")
    lines.append("")
    lines.append("本手册用于人工校正 HTML 前端功能与布局规则，并作为下一阶段 Flutter 迁移输入。")
    lines.append("")
    lines.append("## 契约类型")
    lines.append("")
    lines.append("```ts")
    lines.append("type CaptureSpec = {")
    lines.append("  page_id: string;")
    lines.append("  route_id: string;")
    lines.append("  viewports: ['390x844', '430x932', '834x1194'];")
    lines.append("  component_ids: string[];")
    lines.append("  state_scenarios?: StateScenario[];")
    lines.append("};")
    lines.append("")
    lines.append("type StateScenario = {")
    lines.append("  scenario_id: string;")
    lines.append("  action_js: string;")
    lines.append("  target_components: string[];")
    lines.append("  wait_ms: number;")
    lines.append("};")
    lines.append("")
    lines.append("type ComponentDocSpec = {")
    lines.append("  component_id: string;")
    lines.append("  component_image: string;")
    lines.append("  basic_function: string;")
    lines.append("  layout_contract: string;")
    lines.append("  text_overflow_rule: string;")
    lines.append("  responsive_rule: string;")
    lines.append("  input_output: string;")
    lines.append("};")
    lines.append("```")
    lines.append("")

    for spec in specs:
        page_id = spec.page_id
        lines.append(f"# {page_id}")
        lines.append("")
        lines.append(f"- 页面目的: {PAGE_PURPOSES.get(page_id, '用于承载该页面对应的功能区块与交互流程。')}")
        lines.append(f"- 路由标识: `{spec.route_id}`")
        lines.append(f"- 组件树: `{ ' -> '.join(spec.components_runtime) }`")
        lines.append(f"- 页面格式规范: {page_layout_contract(page_id, spec.components_runtime)}")
        lines.append("")
        lines.append("## 页面截图")
        lines.append("")

        for vp in VIEWPORTS:
            vp_name = vp["name"]
            full_rel = spec.artifacts["full"].get(vp_name)
            if not full_rel:
                continue
            full_path = rel_root / Path(full_rel).relative_to(output_root.relative_to(REPO_ROOT))
            lines.append(f"- 视口 `{vp_name}`")
            lines.append(f"![{page_id}-{vp_name}]({full_path.as_posix()})")
            lines.append("")

        for component_id in spec.components_runtime:
            lines.append(f"## {component_id}")
            lines.append("")

            default_img = spec.artifacts["components"]["default"].get(component_id)
            if default_img:
                default_path = rel_root / Path(default_img).relative_to(output_root.relative_to(REPO_ROOT))
                lines.append(f"![{page_id}-{component_id}-default]({default_path.as_posix()})")
            else:
                lines.append("_默认状态未捕获到该组件截图，见状态截图或缺失清单。_")
            lines.append("")

            state_images = []
            for state_id, mapping in spec.artifacts["components"]["states"].items():
                if component_id in mapping:
                    state_images.append((state_id, mapping[component_id]))

            for state_id, state_img in state_images:
                state_path = rel_root / Path(state_img).relative_to(output_root.relative_to(REPO_ROOT))
                lines.append(f"- 状态 `{state_id}`")
                lines.append(f"![{page_id}-{component_id}-{state_id}]({state_path.as_posix()})")
                lines.append("")

            contract = component_contract(page_id, component_id, spec.component_routes.get(component_id, []))
            lines.append(f"- 功能说明: {contract['basic_function']}")
            lines.append(f"- 布局契约: {contract['layout_contract']}")
            lines.append(f"- 超长文本/数字规范: {contract['text_overflow_rule']}")
            lines.append(f"- 响应式规范: {contract['responsive_rule']}")
            lines.append(f"- 输入/输出: {contract['input_output']}")
            lines.append("")

        lines.append("## 人工修正位")
        lines.append("")
        lines.append("- 需要人工补充的业务逻辑:")
        lines.append("- 需要人工确认的交互边界:")
        lines.append("- 需要人工调整的文本与适配规则:")
        lines.append("")

    doc_path.write_text("\n".join(lines), encoding="utf-8")


def write_missing_components(specs: List[PageSpec], output_root: Path) -> None:
    md = output_root / "missing-components.md"
    lines: List[str] = []
    lines.append("# Missing Components Report")
    lines.append("")
    lines.append("## 组件目录存在但未运行时挂载（待清理/待接入）")
    lines.append("")

    has_unmounted = False
    for spec in specs:
        if not spec.unmounted_components:
            continue
        has_unmounted = True
        lines.append(f"### {spec.page_id}")
        for comp in spec.unmounted_components:
            lines.append(f"- `{comp}`")
        lines.append("")

    if not has_unmounted:
        lines.append("无。")
        lines.append("")

    lines.append("## 运行时组件截图缺失（未捕获到可见节点）")
    lines.append("")
    has_capture_missing = False
    for spec in specs:
        missing = spec.artifacts.get("missing_components", [])
        if not missing:
            continue
        has_capture_missing = True
        lines.append(f"### {spec.page_id}")
        for comp in missing:
            lines.append(f"- `{comp}`")
        lines.append("")

    if not has_capture_missing:
        lines.append("无。")
        lines.append("")

    lines.append("## 采集错误明细")
    lines.append("")
    any_errors = False
    for spec in specs:
        if not spec.capture_errors:
            continue
        any_errors = True
        lines.append(f"### {spec.page_id}")
        for err in spec.capture_errors:
            lines.append(f"- `{err['stage']}` / `{err['component_id']}`: {err['reason']}")
        lines.append("")

    if not any_errors:
        lines.append("无。")

    md.write_text("\n".join(lines), encoding="utf-8")


def write_manifest(specs: List[PageSpec], output_root: Path, base_url: str, mock: str, seed: int) -> None:
    payload = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "base_url": base_url,
        "mock": mock,
        "seed": seed,
        "viewports": VIEWPORTS,
        "capture_specs": [
            {
                "page_id": s.page_id,
                "route_id": s.route_id,
                "viewports": [v["name"] for v in VIEWPORTS],
                "component_ids": s.components_runtime,
                "state_scenarios": s.state_scenarios,
            }
            for s in specs
        ],
        "pages": [
            {
                "page_id": s.page_id,
                "route_id": s.route_id,
                "components_runtime": s.components_runtime,
                "component_dirs": s.component_dirs,
                "unmounted_components": s.unmounted_components,
                "component_routes": s.component_routes,
                "artifacts": s.artifacts,
                "capture_errors": s.capture_errors,
            }
            for s in specs
        ],
    }
    (output_root / "manifest.json").write_text(
        json.dumps(payload, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


async def run(args: argparse.Namespace) -> None:
    output_root = Path(args.output_root).resolve()
    doc_path = Path(args.doc_path).resolve()

    routes, route_alias = parse_router()
    specs = discover_specs(routes, route_alias)
    clean_output_root(output_root)

    server_proc = ensure_http_server(args.base_url)
    if server_proc is None:
        parsed = urlparse(args.base_url)
        if parsed.hostname in ("127.0.0.1", "localhost"):
            # If localhost is requested and still unreachable, fail fast.
            target = f"{args.base_url.rstrip('/')}/pages/index/index.html"
            try:
                with urlopen(target, timeout=1.5):
                    pass
            except Exception as ex:
                raise RuntimeError(f"Cannot reach {target}. Please start static server first. {ex}")

    try:
        async with async_playwright() as pw:
            browser = await pw.chromium.launch(headless=True)
            await capture_full_pages(browser, specs, output_root, args.base_url, args.seed, args.mock)
            await capture_component_shots(browser, specs, output_root, args.base_url, args.seed, args.mock)
            await browser.close()

        write_manifest(specs, output_root, args.base_url, args.mock, args.seed)
        write_missing_components(specs, output_root)
        render_handbook(specs, doc_path, output_root)

    finally:
        if server_proc is not None:
            server_proc.terminate()


def main() -> None:
    args = parse_args()
    asyncio.run(run(args))


if __name__ == "__main__":
    main()
