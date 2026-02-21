# Component 纯净组件拆解版（Flutter 迁移准备）

## 项目目标
1. 用功能区块组件重建错题闭环前端（20 页）。
2. 保持页面效果与跳转语义稳定。
3. 为 Flutter 迁移提供可直接映射的页面/组件/路由规范。

## 目录结构
```text
html前端——component纯净组件拆解版/
  assets/
  pages/
  shared/
  mock-data/
  tools/
  docs/
    html前端——component纯净组件拆解版.md
    appendix/
      01-页面组件总表.md
      02-路由跳转矩阵.md
      03-HTML到Flutter映射表.md
      04-组件契约与术语.md
  artifacts/
    page-annotations/
    layout-validation/
```

## 页面范围
- 核心 18 页：`index/community/global-* /memory/profile/upload-history/question-* /ai-diagnosis/model-* /knowledge-* /flashcard-review/prediction-center/weekly-review`
- 占位 2 页：`upload-menu`、`register-strategy`

## 路由规则
- 语义路由定义：`shared/router.js`
- 跳转写法：`data-route="<routeId>"`
- 兼容旧写法：`navigateTo('xxx.html')`（内部转换到 routeId）

## Mock 运行
- URL 参数：`?mock=baseline|stress|edge&seed=20260220`
- 示例：`pages/index/index.html?mock=stress&seed=20260220`

## 自动化验证
- 布局校验脚本：`tools/validate_mock_layout.py`
- 标注截图脚本：`tools/generate_page_annotations.py`
- 输出目录：
  - `artifacts/layout-validation/screenshots/<page>/<mode>/<viewport>.png`
  - `artifacts/layout-validation/report/layout-report.json`
  - `artifacts/layout-validation/report/layout-report.md`
  - `artifacts/page-annotations/`

## 本地运行
1. 启动静态服务（例如 Live Server 5500）。
2. 访问 `pages/index/index.html`。
3. 使用 URL 参数切换 Mock 模式。
