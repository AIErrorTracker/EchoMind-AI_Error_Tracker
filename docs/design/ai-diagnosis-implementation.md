# AI 诊断功能实现设计文档

> 创建日期：2026-02-25
> 状态：设计阶段，待用户审批
> 作者：claude-1 (foreman)
> 依据：v1.0.md（产品核心框架）、v1.1part.md（错误分析大框架）、architecture.md

---

## 一、概述

### 1.1 功能定位

AI 诊断是 EchoMind 的核心功能。学生上传错题照片后，系统通过 LLM 驱动的多轮对话（最多 5 轮），判断错误根源属于三大类之一：

| 错误根源 | 判断依据 | 后续引导 |
|---------|---------|---------|
| 粗心/计算错误 | 学生自述"算错/看错" | 记录 → 周末粗心消杀 |
| 知识点缺口 | 不理解基础概念/公式 | → 知识点学习流程 |
| 模型应用缺口 | 概念懂但不会解题 | → 模型六步专项训练 |

模型应用缺口细分 5 个子类：
- **识别错**（不知道用哪个模型）
- **决策错**（模型对但公式选错）
- **步骤错**（公式对但执行出错）
- **主语错**（公式对但对错了对象/过程）
- **代入错**（公式结构对但物理量代入错）

### 1.2 诊断输出格式

每次诊断完成后输出两部分：

**A. 学生可见 — 三段式话术 + 四层定位**
```
四层诊断：建模✅ 列式✅ 执行❌（代入错）
1. 【定位问题】你的问题出在代入值时搞混了V₀和V
2. 【说明可解决】前面建模和列式都对了，检查一遍"这个字母是谁的"就能解决
3. 【关联目标分数】解决后大题第一道12分你稳拿
```

**B. 后端存储 — 5W 证据 JSON**
```json
{
  "what_description": "选了整体法公式，应该对两个物体分别列式",
  "when_stage": "decide",
  "root_cause_id": "confuse_formula_holistic_isolation",
  "ai_explanation": "学生以为两个物体加速度相同，忽略了接触面有滑动",
  "confidence": "confirmed"
}
```

### 1.3 设计约束（来自产品规格）

- 只做 AI 提示词拼接，不做 AI 模型训练
- 最多 5 轮对话（快检→追问→深挖→确认→收敛）
- 5 轮后仍无法定位则输出最佳猜测
- 正向引导原则：永远不说"你不行"，只说"你还差一步"
- 诊断结果中的 5W JSON 在最后一轮一起输出，不额外增加 API 调用

---

## 二、系统架构设计

### 2.1 整体数据流

```
┌─────────────┐     POST /diagnosis/start      ┌──────────────┐
│  Flutter App │ ──────────────────────────────→ │  FastAPI      │
│  (Riverpod)  │     {question_id}              │  Router       │
│              │                                 │  /diagnosis   │
│              │     POST /diagnosis/chat        │               │
│              │ ──────────────────────────────→ │               │
│              │     {session_id, message}       │               │
│              │                                 └───────┬───────┘
│              │                                         │
│              │     SSE stream / JSON response           │
│              │ ←──────────────────────────────          │
│              │     {role, content, metadata}    ┌───────▼───────┐
└─────────────┘                                  │ DiagnosisService│
                                                 │               │
                                                 │ 1. 加载上下文  │
                                                 │ 2. 拼接提示词  │
                                                 │ 3. 调用 LLM   │
                                                 │ 4. 解析输出    │
                                                 │ 5. 更新状态    │
                                                 └───────┬───────┘
                                                         │
                                          ┌──────────────┼──────────────┐
                                          ▼              ▼              ▼
                                   ┌───────────┐  ┌───────────┐  ┌──────────┐
                                   │ PostgreSQL │  │ LLM API   │  │ Question │
                                   │ sessions   │  │ (外部)     │  │ 表/Mastery│
                                   └───────────┘  └───────────┘  └──────────┘
```

### 2.2 核心组件

| 组件 | 职责 | 位置 |
|------|------|------|
| DiagnosisRouter | HTTP 端点，请求校验，JWT 鉴权 | `app/routers/diagnosis.py` |
| DiagnosisService | 业务逻辑：会话管理、上下文组装、LLM 调用 | `app/services/diagnosis_service.py` |
| LLMClient | LLM API 封装（支持多供应商切换） | `app/core/llm_client.py`（新建） |
| PromptBuilder | 提示词模板拼接引擎 | `app/services/prompt_builder.py`（新建） |
| DiagnosisSession (ORM) | 会话持久化模型 | `app/models/diagnosis_session.py`（新建） |
| DiagnosisMessage (ORM) | 消息持久化模型 | `app/models/diagnosis_message.py`（新建） |

### 2.3 LLM 供应商选型

| 供应商 | 模型 | 优势 | 劣势 | 推荐场景 |
|--------|------|------|------|---------|
| Google Gemini | gemini-3.0-flash | 免费额度大，推理能力好，API 稳定 | 需代理（国内） | **MVP 首选** |
| OpenAI | gpt-4o-mini | 性价比高，中文能力好 | 需翻墙或代理 | 海外部署 |
| 阿里云百炼 | qwen-plus / qwen-max | 国内直连，中文优秀，价格低 | 物理推理稍弱 | 备选 |
| DeepSeek | deepseek-chat | 推理能力强，价格极低 | API 稳定性待验证 | 备选 |
| Anthropic | claude-3.5-sonnet | 推理能力最强 | 价格较高，需代理 | 高精度场景 |

**MVP 推荐：Google Gemini gemini-3.0-flash**（用户确认）
- 免费额度充足，适合 MVP 阶段验证
- 推理能力好，适合物理错题诊断场景
- API 稳定，文档完善
- 单次诊断（5 轮）预估成本：免费额度内 $0

---

## 三、API 端点设计

### 3.1 端点总览

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| POST | `/api/diagnosis/start` | 创建诊断会话（绑定 question_id） | JWT |
| POST | `/api/diagnosis/chat` | 发送消息并获取 AI 回复 | JWT |
| GET | `/api/diagnosis/session/{session_id}` | 获取会话详情（含历史消息） | JWT |
| GET | `/api/diagnosis/session` | 获取当前活跃会话（兼容现有前端） | JWT |
| POST | `/api/diagnosis/complete` | 手动结束会话 | JWT |

### 3.2 端点详细定义

#### POST `/api/diagnosis/start`

创建新的诊断会话，绑定到一道错题。

**请求体：**
```json
{
  "question_id": "uuid-of-the-question"
}
```

**响应（201）：**
```json
{
  "session_id": "uuid",
  "status": "active",
  "question_id": "uuid",
  "round": 0,
  "max_rounds": 5,
  "messages": [
    {
      "id": "uuid",
      "role": "assistant",
      "content": "我看到你这道题做错了，我们来一起分析一下...",
      "round": 1,
      "created_at": "2026-02-25T06:00:00Z"
    }
  ]
}
```

**逻辑：**
1. 校验 question_id 属于当前用户
2. 检查该题是否已有活跃会话（有则返回已有会话）
3. 加载题目信息 + 学生掌握度 + 历史错因
4. 拼接 system prompt
5. 调用 LLM 生成第一轮开场白
6. 持久化会话 + 首条消息

#### POST `/api/diagnosis/chat`

学生发送消息，获取 AI 回复。

**请求体：**
```json
{
  "session_id": "uuid",
  "content": "我觉得应该用动量守恒来做"
}
```

**响应（200）：**
```json
{
  "message": {
    "id": "uuid",
    "role": "assistant",
    "content": "你说用动量守恒，那我问你：这道题有没有外力作用？...",
    "round": 2,
    "created_at": "2026-02-25T06:01:00Z"
  },
  "session": {
    "session_id": "uuid",
    "status": "active",
    "round": 2,
    "max_rounds": 5
  }
}
```

**当最后一轮（第 5 轮或 AI 判断可收敛时），响应额外包含：**
```json
{
  "message": { "..." },
  "session": {
    "status": "completed",
    "round": 3
  },
  "diagnosis_result": {
    "four_layer": {
      "modeling": "pass",
      "equation": "pass",
      "execution": "fail",
      "bottleneck_layer": "execution",
      "bottleneck_detail": "代入错 — 搞混V₀和V"
    },
    "root_category": "model_application",
    "root_subcategory": "substitution_error",
    "evidence_5w": {
      "what_description": "选了整体法公式，应该分别列式",
      "when_stage": "decide",
      "root_cause_id": "confuse_formula_holistic_isolation",
      "ai_explanation": "学生以为两物体加速度相同",
      "confidence": "confirmed"
    },
    "next_action": {
      "type": "model_training",
      "target_id": "model_coulomb_balance",
      "message": "建议进入模型训练"
    }
  }
}
```

**逻辑：**
1. 校验 session 属于当前用户且状态为 active
2. 校验轮次未超限（round < max_rounds）
3. 持久化用户消息
4. 组装完整对话历史 → 调用 LLM
5. 解析 LLM 输出（普通回复 or 诊断结论）
6. 如果是诊断结论：解析 5W JSON，更新 Question.diagnosis_result，更新会话状态为 completed
7. 持久化 AI 消息

#### GET `/api/diagnosis/session/{session_id}`

获取指定会话详情（含完整消息历史）。

**响应（200）：**
```json
{
  "session_id": "uuid",
  "question_id": "uuid",
  "status": "active | completed | expired",
  "round": 3,
  "max_rounds": 5,
  "diagnosis_result": null,
  "messages": [
    {"id": "uuid", "role": "assistant", "content": "...", "round": 1, "created_at": "..."},
    {"id": "uuid", "role": "user", "content": "...", "round": 1, "created_at": "..."},
    {"id": "uuid", "role": "assistant", "content": "...", "round": 2, "created_at": "..."}
  ],
  "created_at": "2026-02-25T06:00:00Z"
}
```

#### GET `/api/diagnosis/session`

获取当前用户最近的活跃会话（兼容现有前端 `aiDiagnosisProvider`）。无活跃会话时返回 `null`。

#### POST `/api/diagnosis/complete`

手动结束会话（学生主动退出诊断时调用）。

**请求体：**
```json
{
  "session_id": "uuid"
}
```

**逻辑：** 将会话状态设为 `expired`，不生成诊断结论。

---

## 四、数据库 Schema 变更

### 4.1 新增表：`diagnosis_sessions`

```sql
CREATE TABLE diagnosis_sessions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id      UUID NOT NULL REFERENCES students(id),
    question_id     UUID NOT NULL REFERENCES questions(id),
    status          VARCHAR(20) NOT NULL DEFAULT 'active',
        -- active / completed / expired
    current_round   SMALLINT NOT NULL DEFAULT 0,
    max_rounds      SMALLINT NOT NULL DEFAULT 5,
    system_prompt   TEXT,           -- 本次会话使用的完整 system prompt（快照）
    diagnosis_result JSONB,         -- 诊断结论（5W JSON + 四层定位）
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_diag_session_student ON diagnosis_sessions(student_id);
CREATE INDEX idx_diag_session_question ON diagnosis_sessions(question_id);
CREATE UNIQUE INDEX idx_diag_session_active
    ON diagnosis_sessions(student_id, question_id)
    WHERE status = 'active';
    -- 同一题同一时间只能有一个活跃会话
```

### 4.2 新增表：`diagnosis_messages`

```sql
CREATE TABLE diagnosis_messages (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id      UUID NOT NULL REFERENCES diagnosis_sessions(id) ON DELETE CASCADE,
    role            VARCHAR(10) NOT NULL,  -- 'user' / 'assistant' / 'system'
    content         TEXT NOT NULL,
    round           SMALLINT NOT NULL,
    token_count     INTEGER,               -- 该消息的 token 数（用于成本统计）
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_diag_msg_session ON diagnosis_messages(session_id, created_at);
```

### 4.3 现有表变更

**`questions` 表** — 无需改动，已有 `diagnosis_status` 和 `diagnosis_result` 字段：
- `diagnosis_status`: pending → diagnosing → diagnosed
- `diagnosis_result`: JSONB，存储最终 5W 证据 JSON

### 4.4 ORM 模型

```python
# app/models/diagnosis_session.py
class DiagnosisSessionModel(Base):
    __tablename__ = "diagnosis_sessions"
    id: Mapped[uuid.UUID]           # PK
    student_id: Mapped[uuid.UUID]   # FK → students
    question_id: Mapped[uuid.UUID]  # FK → questions
    status: Mapped[str]             # active/completed/expired
    current_round: Mapped[int]
    max_rounds: Mapped[int]
    system_prompt: Mapped[str | None]
    diagnosis_result: Mapped[dict | None]  # JSONB
    created_at: Mapped[datetime]
    updated_at: Mapped[datetime]

# app/models/diagnosis_message.py
class DiagnosisMessageModel(Base):
    __tablename__ = "diagnosis_messages"
    id: Mapped[uuid.UUID]           # PK
    session_id: Mapped[uuid.UUID]   # FK → diagnosis_sessions
    role: Mapped[str]               # user/assistant/system
    content: Mapped[str]
    round: Mapped[int]
    token_count: Mapped[int | None]
    created_at: Mapped[datetime]
```

### 4.5 Alembic 迁移

新增一个迁移文件创建上述两张表，命名：`add_diagnosis_session_tables`

---

## 五、提示词工程

### 5.1 System Prompt 结构

System prompt 在会话创建时一次性拼接，后续轮次不再修改。

```
[角色定义]
你是 EchoMind AI 诊断助手，专门帮助高中生分析物理错题的错误根源。

[行为准则]
- 正向引导：永远不说"你不行"，只说"你还差一步"
- 最多进行 {max_rounds} 轮对话
- 对话节奏：快检→追问→深挖→确认→收敛
- 用高中生能理解的语言，避免学术术语

[题目信息]
学生做错了这道题：{question_summary}
涉及知识点：{related_knowledge_points}
涉及模型：{related_models}

[学生画像]
- 目标分数：{target_score}
- 卷面策略：{exam_strategy}
- 知识点掌握情况：{knowledge_mastery}
- 模型掌握情况：{model_mastery}
- 常见错误类型：{common_errors}

[诊断任务]
通过对话判断错误根源属于以下哪类：
1. 粗心/计算错误
2. 知识点不理解（基础概念/公式/条件不清楚）
3. 模型应用问题，子类：
   a. 识别错（不知道用哪个模型）
   b. 决策错（模型对但公式选错）
   c. 步骤错（公式对但执行出错）
   d. 主语错（公式对但对错了对象/过程）
   e. 代入错（公式结构对但物理量代入错）

额外检查维度：
- 学生这个式子对谁列的？对哪个过程列的？
- 这个字母代的是哪个物理量？是哪个过程的？

[输出格式]
诊断完成时，在最后一条回复中同时输出：

A. 学生可见的三段式话术（自然语言）
B. 以 ```json 代码块包裹的 5W 证据 JSON：
{
  "four_layer": {
    "modeling": "pass|fail|unreached",
    "equation": "pass|fail|unreached",
    "execution": "pass|fail|unreached",
    "bottleneck_layer": "modeling|equation|execution",
    "bottleneck_detail": "具体描述"
  },
  "root_category": "careless|knowledge_gap|model_application",
  "root_subcategory": "null|identify|decide|step|subject|substitution",
  "evidence_5w": {
    "what_description": "...",
    "when_stage": "read|split|identify|select|target|equation|substitute|solve|check",
    "root_cause_id": "...",
    "ai_explanation": "...",
    "confidence": "confirmed|probable|guess"
  },
  "next_action": {
    "type": "knowledge_learning|model_training|careless_drill",
    "target_id": "kp_xxx 或 model_xxx",
    "message": "给学生的引导语"
  }
}
```

### 5.2 PromptBuilder 实现

```python
# app/services/prompt_builder.py
class DiagnosisPromptBuilder:
    """诊断提示词拼接引擎"""

    async def build_system_prompt(
        self,
        question: Question,
        student: Student,
        mastery_records: list[StudentMastery],
    ) -> str:
        """拼接完整 system prompt"""
        # 1. 从 question 提取题目摘要
        # 2. 从 mastery_records 提取知识点/模型掌握度
        # 3. 从 student 提取目标分数、卷面策略
        # 4. 查询该学生的历史常见错因
        # 5. 填充模板并返回
```

### 5.3 上下文数据来源

| 模板变量 | 数据来源 | 说明 |
|---------|---------|------|
| `question_summary` | `questions.image_url` + OCR 或手动输入 | MVP 阶段先用手动文本 |
| `related_knowledge_points` | `questions.related_kp_ids` → `knowledge_points` 表 | 需教研数据 |
| `related_models` | `questions.primary_model_id` → `models` 表 | 需教研数据 |
| `knowledge_mastery` | `student_mastery` WHERE target_type='kp' | 已有数据 |
| `model_mastery` | `student_mastery` WHERE target_type='model' | 已有数据 |
| `common_errors` | `questions.diagnosis_result` 历史聚合 | 需积累 |
| `target_score` | `students.target_score` | 已有数据 |
| `exam_strategy` | `students.exam_strategy` | 已有数据 |

---

## 六、LLM Client 设计

### 6.1 抽象接口

```python
# app/core/llm_client.py
from abc import ABC, abstractmethod

class LLMClient(ABC):
    """LLM 供应商抽象接口，支持热切换"""

    @abstractmethod
    async def chat(
        self,
        messages: list[dict],  # [{"role": "system"|"user"|"assistant", "content": "..."}]
        temperature: float = 0.7,
        max_tokens: int = 1024,
    ) -> dict:
        """返回 {"content": str, "usage": {"input_tokens": int, "output_tokens": int}}"""
        ...
```

### 6.2 阿里云百炼实现（备选）

```python
# app/core/llm_dashscope.py
import httpx
from app.core.llm_client import LLMClient

class DashScopeClient(LLMClient):
    """阿里云百炼 DashScope OpenAI 兼容接口"""

    BASE_URL = "https://dashscope.aliyuncs.com/compatible-mode/v1"

    def __init__(self, api_key: str, model: str = "qwen-plus"):
        self.api_key = api_key
        self.model = model

    async def chat(self, messages, temperature=0.7, max_tokens=1024):
        async with httpx.AsyncClient(timeout=60) as client:
            resp = await client.post(
                f"{self.BASE_URL}/chat/completions",
                headers={"Authorization": f"Bearer {self.api_key}"},
                json={
                    "model": self.model,
                    "messages": messages,
                    "temperature": temperature,
                    "max_tokens": max_tokens,
                },
            )
            data = resp.json()
            return {
                "content": data["choices"][0]["message"]["content"],
                "usage": data.get("usage", {}),
            }
```

### 6.3 环境配置变更

`backend/.env` 新增：
```env
# LLM 配置
LLM_PROVIDER=gemini             # gemini / dashscope / openai / deepseek
LLM_API_KEY=AIzaXXXXXXXXXXXX   # Google Gemini API Key
LLM_MODEL=gemini-3.0-flash      # 模型名称
LLM_MAX_TOKENS=1024             # 单次最大输出 token
LLM_TEMPERATURE=0.7             # 温度参数
```

`app/core/config.py` 新增字段：
```python
class Settings(BaseSettings):
    # ... 现有字段 ...
    llm_provider: str = "gemini"
    llm_api_key: str = ""
    llm_model: str = "gemini-3.0-flash"
    llm_max_tokens: int = 1024
    llm_temperature: float = 0.7
```

### 6.4 LLM 工厂函数

```python
# app/core/llm_factory.py
from app.core.config import settings
from app.core.llm_client import LLMClient

def create_llm_client() -> LLMClient:
    """根据配置创建 LLM 客户端实例"""
    provider = settings.llm_provider.lower()
    if provider == "gemini":
        from app.core.llm_gemini import GeminiClient
        return GeminiClient(api_key=settings.llm_api_key, model=settings.llm_model)
    elif provider == "dashscope":
        from app.core.llm_dashscope import DashScopeClient
        return DashScopeClient(api_key=settings.llm_api_key, model=settings.llm_model)
    else:
        raise ValueError(f"Unsupported LLM provider: {provider}")
```

使用方式（在 DiagnosisService 中）：
```python
from app.core.llm_factory import create_llm_client

llm = create_llm_client()  # 根据 .env 配置自动选择供应商
response = await llm.chat(messages=[...])
```

---

## 七、前端对接改造

### 7.1 当前状态（claude-3 报告摘要）

| 组件 | 现状 | 需改造 |
|------|------|--------|
| `AiDiagnosisPage` | data 分支始终走 demo | ✅ 接入真实数据渲染 |
| `ActionOverlayWidget` | 输入栏是空壳 Container | ✅ 改为 TextField + 发送逻辑 |
| `MainContentWidget` | 硬编码 mock 气泡 | ✅ 改为 ListView.builder 动态渲染 |
| `aiDiagnosisProvider` | FutureProvider 只调 GET | ✅ 改为 StateNotifier 管理会话状态 |
| 诊断结论卡 | 静态"开始训练"按钮 | ✅ 根据 next_action 动态跳转 |

### 7.2 Provider 改造

现有 `aiDiagnosisProvider` 是 `FutureProvider<DiagnosisSession?>`，只支持一次性 GET。

改造为 `StateNotifierProvider`：

```dart
// providers/ai_diagnosis_provider.dart（改造后）

class DiagnosisState {
  final String? sessionId;
  final String status;        // idle / active / completed
  final int round;
  final int maxRounds;
  final List<DiagnosisMsg> messages;
  final DiagnosisResult? result;
  final bool isSending;       // 发送中状态
}

class DiagnosisNotifier extends StateNotifier<DiagnosisState> {
  final ApiClient _api;

  /// 创建诊断会话
  Future<void> startSession(String questionId) async {
    // POST /diagnosis/start → 更新 state
  }

  /// 发送消息
  Future<void> sendMessage(String content) async {
    // 1. 添加用户消息到 state.messages
    // 2. state.isSending = true
    // 3. POST /diagnosis/chat
    // 4. 添加 AI 回复到 state.messages
    // 5. 如果 status == completed，解析 result
  }
}
```

### 7.3 用户交互流程

```
学生从错题详情页点击「AI 诊断」
    ↓
AiDiagnosisPage 加载
    ↓ startSession(questionId)
显示 AI 开场白（第 1 轮）
    ↓
学生输入回答 → 点击发送
    ↓ sendMessage(content)
显示 loading → AI 回复（第 2 轮）
    ↓ 重复...
第 N 轮 AI 输出诊断结论
    ↓
显示诊断结论卡（四层定位 + 三段式话术）
    ↓
「开始训练」按钮 → 跳转到对应模块
```

---

## 八、实施阶段规划

### Phase 1：后端核心（优先级最高）

| 步骤 | 内容 | 产出文件 |
|------|------|---------|
| 1.1 | 新增 LLM Client 抽象 + DashScope 实现 | `app/core/llm_client.py`, `app/core/llm_dashscope.py` |
| 1.2 | config.py 新增 LLM 配置字段 | `app/core/config.py` |
| 1.3 | 新增 ORM 模型 + Alembic 迁移 | `app/models/diagnosis_*.py`, `alembic/versions/` |
| 1.4 | 新增 Pydantic Schema | `app/schemas/diagnosis.py`（改造） |
| 1.5 | 实现 PromptBuilder | `app/services/prompt_builder.py` |
| 1.6 | 实现 DiagnosisService 核心逻辑 | `app/services/diagnosis_service.py`（改造） |
| 1.7 | 改造 DiagnosisRouter（5 个端点） | `app/routers/diagnosis.py`（改造） |

**验收标准：** 通过 curl/httpie 手动调用 API，完成一次完整 5 轮诊断对话

### Phase 2：前端对接

| 步骤 | 内容 | 产出文件 |
|------|------|---------|
| 2.1 | 改造 DiagnosisState + DiagnosisNotifier | `providers/ai_diagnosis_provider.dart`（改造） |
| 2.2 | ActionOverlayWidget 改为真实 TextField + 发送 | `widgets/action_overlay_widget.dart`（改造） |
| 2.3 | MainContentWidget 改为动态 ListView.builder | `widgets/main_content_widget.dart`（改造） |
| 2.4 | 诊断结论卡根据 next_action 动态跳转 | `widgets/main_content_widget.dart` |
| 2.5 | AiDiagnosisPage data 分支接入真实渲染 | `ai_diagnosis_page.dart`（改造） |

**验收标准：** Flutter App 中完成一次完整诊断对话，结论卡正确跳转

### Phase 3：质量保障与优化

| 步骤 | 内容 |
|------|------|
| 3.1 | 后端单元测试（mock LLM 响应） |
| 3.2 | 提示词 A/B 测试（用真实错题验证诊断准确率） |
| 3.3 | 异常处理：LLM 超时/限流/格式错误的降级策略 |
| 3.4 | Token 用量统计 + 成本监控 |
| 3.5 | 会话过期清理（cron 或 startup hook） |

**验收标准：** 诊断准确率 ≥ 80%（教研复核），异常场景有优雅降级

---

## 九、Gemini API 集成（用户确认方案）

### 9.1 Gemini Client 实现

```python
# app/core/llm_gemini.py
import httpx
from app.core.llm_client import LLMClient

class GeminiClient(LLMClient):
    """Google Gemini API（OpenAI 兼容模式）"""

    BASE_URL = "https://generativelanguage.googleapis.com/v1beta"

    def __init__(self, api_key: str, model: str = "gemini-3.0-flash"):
        self.api_key = api_key
        self.model = model

    async def chat(self, messages, temperature=0.7, max_tokens=1024):
        # Gemini 原生 API 格式
        contents = self._convert_messages(messages)
        async with httpx.AsyncClient(timeout=60) as client:
            resp = await client.post(
                f"{self.BASE_URL}/models/{self.model}:generateContent",
                params={"key": self.api_key},
                json={
                    "contents": contents,
                    "generationConfig": {
                        "temperature": temperature,
                        "maxOutputTokens": max_tokens,
                    },
                },
            )
            data = resp.json()
            text = data["candidates"][0]["content"]["parts"][0]["text"]
            usage = data.get("usageMetadata", {})
            return {
                "content": text,
                "usage": {
                    "input_tokens": usage.get("promptTokenCount", 0),
                    "output_tokens": usage.get("candidatesTokenCount", 0),
                },
            }

    def _convert_messages(self, messages: list[dict]) -> list[dict]:
        """OpenAI 格式 → Gemini contents 格式"""
        contents = []
        system_text = ""
        for msg in messages:
            if msg["role"] == "system":
                system_text = msg["content"]
            elif msg["role"] == "user":
                text = f"{system_text}\n\n{msg['content']}" if system_text else msg["content"]
                contents.append({"role": "user", "parts": [{"text": text}]})
                system_text = ""  # system 只拼接一次
            elif msg["role"] == "assistant":
                contents.append({"role": "model", "parts": [{"text": msg["content"]}]})
        return contents
```
