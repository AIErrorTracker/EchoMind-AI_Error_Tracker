# 任务 17：weekly-review 周复盘（待实现）

> 开始前请先阅读 `00_总起说明_每个任务必读.md`

## 任务目标

将 weekly-review 页面从 stub 实现为完整页面。周维度复盘与下周规划。

## 参考资料

- 页面说明：`docs/第二阶段_html转flutter/18个html页面的分别说明文档/17_weekly-review_周复盘.md`
- 页面截图：`docs/第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__390x844__full.png`
- 组件截图：`docs/第一阶段_html细化/html截图验证/weekly-review/components/`

## 目标文件

- `echomind_app/lib/features/weekly_review/weekly_review_page.dart`
- `echomind_app/lib/features/weekly_review/widgets/top_frame_widget.dart`
- `echomind_app/lib/features/weekly_review/widgets/weekly_dashboard_widget.dart`
- `echomind_app/lib/features/weekly_review/widgets/score_change_widget.dart`
- `echomind_app/lib/features/weekly_review/widgets/weekly_progress_widget.dart`
- `echomind_app/lib/features/weekly_review/widgets/next_week_focus_widget.dart`

## 组件清单

| 组件 | 功能 | 跳转 |
|------|------|------|
| top-frame | 返回与周次信息 | profile（返回） |
| weekly-dashboard | 本周总览数据 | 无 |
| score-change | 分数前后对比 | 无 |
| weekly-progress | 本周进展条目 | 无 |
| next-week-focus | 下周重点建议 | 无 |

## 页面结构

```
Scaffold → SafeArea → Column [
  TopFrame,
  Expanded(ListView [WeeklyDashboard, ScoreChange, WeeklyProgress, NextWeekFocus])
]
```

## 输出要求

1. **截图留档**：保存页面效果截图到 `docs/第二阶段_html转flutter/截图验证/17_weekly-review_周复盘_完成效果.png`
2. **完成说明**：创建 `docs/第二阶段_html转flutter/18个页面的完成说明文档/17_weekly-review_周复盘_完成说明.md`，内容包括：实现的组件列表、与截图的差异说明、路由跳转验证结果、已知问题或遗留项
3. **拉起下一任务**：完成后自动读取 `18_profile_我的.md` 并开始执行下一个页面的工作流

---

# 附录：页面说明文档（weekly-review 周复盘）

## 设计目的

周维度复盘与下周规划。

## 路由标识

`weeklyReview`

## 组件树

```text
weekly-review
├─ top-frame
├─ weekly-dashboard
├─ score-change
├─ weekly-progress
└─ next-week-focus
```

## 页面格式规范

顶部导航区位于上层，正文从其下方开始排布，禁止正文上移重叠。正文列表与卡片使用自然文档流，内容增多后应推动后续模块下移。适配策略为手机到平板单列自适应，不使用手机壳固定宽高。

## 页面跳转

- 来源: `profile` (three-row-navigation)
- 返回: `profile`

## 页面截图

- 视口 `390x844`
![weekly-review-390x844](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__390x844__full.png)

- 视口 `430x932`
![weekly-review-430x932](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__430x932__full.png)

- 视口 `834x1194`
![weekly-review-834x1194](../../第一阶段_html细化/html截图验证/weekly-review/full/weekly-review__834x1194__full.png)

---

## 组件详情

### top-frame

![weekly-review-top-frame](../../第一阶段_html细化/html截图验证/weekly-review/components/top-frame__390x844.png)

- 功能说明: 返回与周次信息。
- 输入/输出: 输入: `pageData.top-frame`。输出: 可触发路由跳转: profile。

### weekly-dashboard

![weekly-review-weekly-dashboard](../../第一阶段_html细化/html截图验证/weekly-review/components/weekly-dashboard__390x844.png)

- 功能说明: 本周总览数据。
- 布局契约: 统计卡区域位于内容前段，数值与摘要信息需要稳定对齐。

### score-change

![weekly-review-score-change](../../第一阶段_html细化/html截图验证/weekly-review/components/score-change__390x844.png)

- 功能说明: 分数前后对比。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。

### weekly-progress

![weekly-review-weekly-progress](../../第一阶段_html细化/html截图验证/weekly-review/components/weekly-progress__390x844.png)

- 功能说明: 本周进展条目。
- 布局契约: 列表区采用自然文档流纵向扩展。

### next-week-focus

![weekly-review-next-week-focus](../../第一阶段_html细化/html截图验证/weekly-review/components/next-week-focus__390x844.png)

- 功能说明: 下周重点建议。
- 布局契约: 功能块位于页面主内容区，跟随文档流渲染。
