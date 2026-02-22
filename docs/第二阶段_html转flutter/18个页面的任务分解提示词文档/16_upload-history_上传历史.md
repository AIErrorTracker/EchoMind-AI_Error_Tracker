# 任务 16：upload-history 上传历史（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 upload-history 页面从 stub 实现为完整页面。按筛选与日期分组展示错题上传记录。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/16_upload-history_上传历史.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/upload-history/full/upload-history__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/upload-history/components/`

## 目标文件

- `echomind_app/lib/features/upload_history/upload_history_page.dart`
- `echomind_app/lib/features/upload_history/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/upload_history/widgets/history_panel_widget.dart`
- `echomind_app/lib/features/upload_history/widgets/history_filter_widget.dart`
- `echomind_app/lib/features/upload_history/widgets/history_date_scroll_widget.dart`
- `echomind_app/lib/features/upload_history/widgets/history_record_list_widget.dart`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回与标题 | home（返回） |
| history-panel | 历史主容器 | 无 |
| history-filter | 状态/类型筛选 | 无 |
| history-date-scroll | 按日期分组滚动 | 无 |
| history-record-list | 历史记录列表 | questionDetail |

## 页面结构

```
Scaffold → SafeArea → Column [
  TopFrame,
  HistoryFilter,
  HistoryDateScroll,
  Expanded(HistoryRecordList)
]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/16_upload-history_上传历史_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/16_upload-history_上传历史_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `17_weekly-review_周复盘.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（upload-history 上传历史）

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
