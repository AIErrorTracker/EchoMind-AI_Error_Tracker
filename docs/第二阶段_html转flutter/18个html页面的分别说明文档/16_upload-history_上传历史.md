# upload-history（上传历史）

## 设计目的

查看并筛选历史上传记录。

## 路由标识

`uploadHistory`

## 组件树

```text
upload-history
├─ top-frame
├─ history-panel
├─ history-filter
├─ history-date-scroll
└─ history-record-list
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `index` / `profile` (three-row-navigation)
- 去向: `question-detail` (history-record-list)

## 页面截图

- 视口 `390x844`
![upload-history-390x844](../../第一阶段_html细化/html截图验证/upload-history/full/upload-history__390x844__full.png)

- 视口 `430x932`
![upload-history-430x932](../../第一阶段_html细化/html截图验证/upload-history/full/upload-history__430x932__full.png)

- 视口 `834x1194`
![upload-history-834x1194](../../第一阶段_html细化/html截图验证/upload-history/full/upload-history__834x1194__full.png)

---

## 组件详情

### top-frame

![upload-history-top-frame](../../第一阶段_html细化/html截图验证/upload-history/components/top-frame__390x844.png)

- 功能说明: 返回与标题。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: home。

### history-panel

![upload-history-history-panel](../../第一阶段_html细化/html截图验证/upload-history/components/history-panel__390x844.png)

- 功能说明: 历史主容器（L1）。
- 布局契约: 列表区采用自然文档流纵向扩展。

### history-filter

![upload-history-history-filter](../../第一阶段_html细化/html截图验证/upload-history/components/history-filter__390x844.png)

- 功能说明: 状态/类型筛选。
- 输入/输出: 输入: `pageData.history-filter`。输出: 无跨页跳转。

### history-date-scroll

![upload-history-history-date-scroll](../../第一阶段_html细化/html截图验证/upload-history/components/history-date-scroll__390x844.png)

- 功能说明: 按日期分组滚动。
- 输入/输出: 输入: `pageData.history-date-scroll`。输出: 无跨页跳转。

### history-record-list

![upload-history-history-record-list](../../第一阶段_html细化/html截图验证/upload-history/components/history-record-list__390x844.png)

- 功能说明: 历史记录列表（支持下拉刷新语义）。
- 布局契约: 列表区采用自然文档流纵向扩展。
- 输入/输出: 输入: `pageData.history-record-list`。输出: 可触发路由跳转: questionDetail。
