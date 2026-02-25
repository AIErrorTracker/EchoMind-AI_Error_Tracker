# upload-menu（上传菜单）

## 设计目的

上传菜单占位页用于承接上传入口路由，保障链路完整。

## 路由标识

`uploadMenu`

## 组件树

```text
upload-menu
├─ top-frame
└─ main-content
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `index` (action-overlay) / `global-exam` (question-type-browser)
- 返回: `home`

## 页面截图

- 视口 `390x844`
![upload-menu-390x844](../../第一阶段_html细化/html截图验证/upload-menu/full/upload-menu__390x844__full.png)

- 视口 `430x932`
![upload-menu-430x932](../../第一阶段_html细化/html截图验证/upload-menu/full/upload-menu__430x932__full.png)

- 视口 `834x1194`
![upload-menu-834x1194](../../第一阶段_html细化/html截图验证/upload-menu/full/upload-menu__834x1194__full.png)

---

## 组件详情

### top-frame

![upload-menu-top-frame](../../第一阶段_html细化/html截图验证/upload-menu/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 输入/输出: 输出: 可触发路由跳转: home。

### main-content

![upload-menu-main-content](../../第一阶段_html细化/html截图验证/upload-menu/components/main-content__390x844.png)

- 功能说明: 上传菜单主内容区。
- 输入/输出: 输出: 可触发路由跳转: home。
