# register-strategy（学习策略）

## 设计目的

学习策略占位页用于承接策略入口路由，保障链路完整。

## 路由标识

`registerStrategy`

## 组件树

```text
register-strategy
├─ top-frame
└─ main-content
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `profile` (three-row-navigation)
- 返回: `profile`

## 页面截图

- 视口 `390x844`
![register-strategy-390x844](../../第一阶段_html细化/html截图验证/register-strategy/full/register-strategy__390x844__full.png)

- 视口 `430x932`
![register-strategy-430x932](../../第一阶段_html细化/html截图验证/register-strategy/full/register-strategy__430x932__full.png)

- 视口 `834x1194`
![register-strategy-834x1194](../../第一阶段_html细化/html截图验证/register-strategy/full/register-strategy__834x1194__full.png)

---

## 组件详情

### top-frame

![register-strategy-top-frame](../../第一阶段_html细化/html截图验证/register-strategy/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 输入/输出: 输出: 可触发路由跳转: profile。

### main-content

![register-strategy-main-content](../../第一阶段_html细化/html截图验证/register-strategy/components/main-content__390x844.png)

- 功能说明: 策略主内容区。
- 输入/输出: 输出: 可触发路由跳转: profile。
