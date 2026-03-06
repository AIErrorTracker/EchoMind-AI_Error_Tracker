# EchoMind 后端实装功能与测试目标（前端联调基线）

- 文档日期: 2026-02-28
- 适用范围: `echomind_app` 前端当前已接入的后端接口
- 代码来源: `echomind_app/lib/providers/*`

## 1. 文档目的

本文件用于明确两件事:

1. 当前项目“已经实装并接入”的后端能力是什么。
2. 自动化测试和真机联调时，后端必须表现出的行为（测试目标）是什么。

说明: 当前前端已移除页面级 mock/demo 业务数据入口，不再使用伪造列表覆盖真实后端结果。接口失败或空数据会显式展示失败/空态。

## 2. 已实装后端功能清单（按模块）

### 2.1 认证与用户资料

- `POST /auth/login`
- `POST /auth/register`
- `GET /auth/me`
- `PUT /auth/profile`
- `POST /upload/image`

前端用途:
- 登录注册
- 读取用户信息
- 上传头像并更新资料

### 2.2 首页与学习概览

- `GET /dashboard`
- `GET /recommendations`

前端用途:
- 首页统计卡片
- 推荐学习项（知识点/模型）

### 2.3 题目与历史

- `GET /questions/history`
- `GET /questions/{questionId}`
- `GET /questions/aggregate`

前端用途:
- 上传历史
- 题目详情
- 题目聚合分析

### 2.4 全局考试分析

- `GET /exams/heatmap`
- `GET /exams/question-types`
- `GET /exams/recent`

前端用途:
- 热力图
- 题型分布
- 最近试卷

### 2.5 知识树与模型树

- `GET /knowledge/tree`
- `GET /knowledge/{kpId}`
- `GET /models/tree`
- `GET /models/{modelId}`

前端用途:
- 知识点树浏览
- 知识点详情
- 模型树浏览
- 模型详情

### 2.6 预测、复盘与记忆

- `GET /prediction/score`
- `GET /flashcards`
- `GET /weekly-review`

前端用途:
- 预测分中心
- 闪卡复习
- 周复盘

### 2.7 AI 诊断会话

- `GET /diagnosis/session`
- `POST /diagnosis/start`
- `POST /diagnosis/chat`
- `POST /diagnosis/complete`

前端用途:
- 启动题目诊断
- 多轮问答
- 诊断结论与下一步建议

### 2.8 知识学习会话

- `POST /knowledge/learning/start`
- `POST /knowledge/learning/chat`
- `GET /knowledge/learning/session/{sessionId}`
- `POST /knowledge/learning/complete`

前端用途:
- 知识点学习流程（会话式）

### 2.9 模型训练会话

- `GET /models/training/session`
- `GET /models/training/session/{sessionId}`
- `POST /models/training/start`
- `POST /models/training/interact`
- `POST /models/training/next-step`
- `POST /models/training/complete`

前端用途:
- 模型训练分步流程（Step）
- 阶段结果与 mastery 更新

### 2.10 策略中心

- `GET /strategy`
- `GET /strategy/templates`
- `POST /strategy/generate`
- `PUT /strategy/target-score`

前端用途:
- 获取策略
- 获取可选目标分
- 生成策略
- 调分后回传变化

### 2.11 社区

- `GET /community/requests`
- `POST /community/requests`
- `POST /community/requests/{requestId}/vote`
- `DELETE /community/requests/{requestId}/vote`
- `GET /community/feedback`
- `POST /community/feedback`

前端用途:
- 需求池浏览/提交/投票
- 反馈浏览/提交

## 3. 后端测试目标（必须验证的表现）

### 3.1 鉴权与权限

- 除登录注册外，受保护接口在无 token 时应返回明确鉴权错误（通常 401/403）。
- token 过期、伪造、缺失三种场景返回码和错误体要可区分。
- 使用同一账号并发请求时，不应出现随机鉴权失败。

### 3.2 接口契约稳定性

- 返回 JSON 的字段名、类型、可空规则与前端模型一致。
- 列表字段应稳定返回 `[]`，而不是 `null`（除契约明确允许）。
- 数值字段（分数、level、统计）不得返回字符串类型。

### 3.3 业务状态机正确性

- `diagnosis` 会话状态流转: `idle -> active -> completed/expired`。
- `model training` 步骤推进正确，`next-step` 只在可推进状态生效。
- `knowledge learning` 会话可恢复（`session/{id}`），并可正常 complete。

### 3.4 数据一致性

- `questions/history`、`questions/{id}`、`questions/aggregate` 对同一题目口径一致。
- `dashboard`、`weekly-review`、`prediction/score` 的统计逻辑前后一致。
- 策略调分后，`strategy` 与 `strategy/target-score` 返回结果一致。

### 3.5 错误处理质量

- 参数错误返回 4xx，服务错误返回 5xx，不允许统一吞成 200。
- 错误体至少包含可追踪信息（错误码/消息/请求ID其一）。
- 限流、超时、熔断场景有稳定错误语义，便于自动化断言。

### 3.6 性能与稳定性

- 关键页面接口（`dashboard`, `recommendations`, `questions/*`, `knowledge/tree`, `models/tree`）在测试环境下 p95 延迟应可接受。
- 多次连续请求不应出现明显雪崩或内存泄漏导致的随机失败。

## 4. 分模块必测点（建议 P0）

### 4.1 认证

- 登录成功返回 token，`/auth/me` 可用。
- 错误密码返回明确失败。
- 头像上传后 `auth/profile` 更新成功，刷新后可见。

### 4.2 题目链路

- 历史列表可打开详情。
- 聚合接口返回 history 时，`question_id` 可用于详情跳转。
- 题目详情缺字段时后端应按契约返回空值，不应结构缺失。

### 4.3 树与详情

- 知识树/模型树不返回假节点；空数据时返回空列表。
- 树节点 id 可用于详情查询。
- 详情中的关联 id（如 relatedModelIds）有效可跳转。

### 4.4 AI 会话链路

- start -> chat 多轮 -> complete 全链路成功。
- 会话恢复接口返回 messages 顺序正确。
- completed 后再次 chat 被正确拒绝或按契约处理。

### 4.5 策略与社区

- 策略生成和调分返回结构完整（strategy + changes）。
- 社区投票支持反向操作（POST/DELETE）且计数一致。

## 5. 自动化测试如何跑通（后端为主）

建议拆成三层:

1. API 契约测试（最快，阻断回归）
2. Flutter 集成测试（联通前后端）
3. 真机冒烟（APK）

### 5.1 API 契约自动化（推荐先做）

- 建议目录: `docs/testing/api/` + `tests/api/`
- 用例最小集:
  - 登录拿 token
  - 带 token 调 `auth/me`
  - 调 `dashboard/recommendations`
  - 调 `questions/history` + 任意 `questions/{id}`
  - 调 `knowledge/tree`、`models/tree`
  - 负例: 无 token 调受保护接口应 401/403

建议在 CI 中把这批用例设为必过门槛（P0）。

### 5.2 Flutter 集成自动化

- 目标: 验证前端在“无 mock”模式下真实消费后端。
- 关键断言:
  - 页面不出现演示数据
  - 接口失败时出现错误态
  - 列表为空时出现空态

### 5.3 真机冒烟（APK）

- 登录后按核心链路走一遍:
  - 首页 -> 推荐 -> 模型/知识详情
  - 历史 -> 题目详情
  - 策略页、周复盘页、预测页
- 记录每一步接口响应是否成功、是否有数据错位。

## 6. 通过标准（本阶段）

满足以下条件即可判定“后端联调基线可测”:

- 所有 P0 接口在有 token 下可稳定返回。
- 无 token 访问受保护接口时错误语义正确。
- 前端不再用 mock/demo 数据掩盖后端问题。
- 关键链路（登录、题目、树、训练/诊断、策略）可走通。

## 7. 执行备注

- 建议把测试账号通过环境变量注入，不要把账号密码明文提交到仓库。
- 若后端临时未实现某接口，前端应展示错误/空态，不应伪造业务数据。
