# 任务 18：profile 我的（已完成 — 验证与补齐）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

我的页面已基本实现，本任务为验证与补齐。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/18_profile_我的.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/profile/full/profile__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/profile/components/`

## 目标文件

- `echomind_app/lib/features/profile/profile_page.dart`
- `echomind_app/lib/features/profile/widgets/` 下所有组件

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 页面标题 | 无 |
| user-info-card | 用户基础信息 | 无 |
| target-score-card | 目标分与策略摘要 | 无 |
| three-row-navigation | 核心业务入口 | registerStrategy, uploadHistory, weeklyReview |
| two-row-navigation | 设置类入口 | 无 |
| learning-stats | 累计学习统计 | 无 |

## 页面结构

```
PageShell(tabIndex: 4) → ListView [TopFrame, UserInfoCard, TargetScoreCard, ThreeRowNav, TwoRowNav, LearningStats]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/18_profile_我的_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/18_profile_我的_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **最终收尾**：本任务为最后一个页面，完成后输出"全部18个页面任务已完成"

---

# 附录：页面说明文档（profile 我的）

## 设计目的

个人中心与常用入口聚合。

## 路由标识

`profile`

## 组件树

```text
profile
├─ top-frame
├─ user-info-card
├─ target-score-card
├─ three-row-navigation
├─ two-row-navigation
└─ learning-stats
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 去向: `weekly-review` / `upload-history` / `register-strategy` (three-row-navigation)

## 页面截图

- 视口 `390x844`
![profile-390x844](../../第一阶段_html细化/html截图验证/profile/full/profile__390x844__full.png)

- 视口 `430x932`
![profile-430x932](../../第一阶段_html细化/html截图验证/profile/full/profile__430x932__full.png)

- 视口 `834x1194`
![profile-834x1194](../../第一阶段_html细化/html截图验证/profile/full/profile__834x1194__full.png)

---

## 组件详情

### top-frame

![profile-top-frame](../../第一阶段_html细化/html截图验证/profile/components/top-frame__390x844.png)

- 功能说明: 页面标题。
- 布局契约: 位于页面上方固定区域，不与正文内容重叠。

### user-info-card

![profile-user-info-card](../../第一阶段_html细化/html截图验证/profile/components/user-info-card__390x844.png)

- 功能说明: 用户基础信息。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。

### target-score-card

![profile-target-score-card](../../第一阶段_html细化/html截图验证/profile/components/target-score-card__390x844.png)

- 功能说明: 目标分与策略摘要。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。

### three-row-navigation

![profile-three-row-navigation](../../第一阶段_html细化/html截图验证/profile/components/three-row-navigation__390x844.png)

- 功能说明: 核心业务入口（上传历史/周复盘/卷面策略）。
- 输入/输出: 输出: 可触发路由跳转: registerStrategy、uploadHistory、weeklyReview。

### two-row-navigation

![profile-two-row-navigation](../../第一阶段_html细化/html截图验证/profile/components/two-row-navigation__390x844.png)

- 功能说明: 设置类入口。

### learning-stats

![profile-learning-stats](../../第一阶段_html细化/html截图验证/profile/components/learning-stats__390x844.png)

- 功能说明: 累计学习统计。
