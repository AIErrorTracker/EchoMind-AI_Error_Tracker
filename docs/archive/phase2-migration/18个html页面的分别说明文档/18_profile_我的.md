# profile（我的）

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
