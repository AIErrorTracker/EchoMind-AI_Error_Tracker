# Flutter Migration Contract (HTML Pre-Migration)

## Purpose
This document defines the constraints for converting `html前端——component纯净组件拆解版` to Flutter without semantic drift.

## Locked Decisions
- Responsive policy: full-width adaptive single column (phone + tablet).
- Routing policy: semantic route IDs only.
- Scope: 18 core pages fully covered, plus 2 placeholder pages (`upload-menu`, `register-strategy`).
- Event policy: `data-route` + central delegation.
- Top area policy: remove fake status bar; keep top spacer.

## Layout Contract
- Each page uses a shell concept:
  - `TopSpacer`
  - `TopRegion`
  - `ContentRegion`
  - `BottomRegion` (optional)
- Only these overlays can be fixed/absolute:
  - Bottom tab bar
  - Chat input bar
  - FAB and modal sheet
- Content should stay in natural document flow.

## Routing Contract
- Source of truth: `shared/router.js`.
- Route IDs (camelCase) map to page slugs.
- UI elements should use `data-route="<routeId>"`.
- `navigateTo('xxx.html')` is backward-compatible only.

## Flutter Mapping Contract
- `TopSpacer` -> `SafeArea(top: true)`/padding area.
- `TopRegion` -> AppBar/custom top widgets.
- `ContentRegion` -> scrollable body (`CustomScrollView`/`ListView`).
- `BottomRegion` -> `bottomNavigationBar`/bottom input.
- `FAB` -> `floatingActionButton`.

## Compatibility Notes
- Visual language should remain near current 390x844 baseline.
- Pixel-perfect phone-shell visuals are intentionally removed.
- Business flow and page semantics must remain unchanged.

## Acceptance Baseline
- 18 pages pass mock stress matrix.
- No invalid `data-route` values.
- No inline `onclick="navigateTo(...)"` in target pages.
- No horizontal overflow in defined viewports.
