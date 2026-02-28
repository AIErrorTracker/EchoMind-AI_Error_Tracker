# 数据库Schema设计（PostgreSQL）

> 最后更新: 2026-02-28 — 覆盖全部 17 张表
>
> 基于 core_framework_v2.0.md 审计补充数据模型 + Section 二十九标签字段

---

## 表1：students（学生）

```sql
CREATE TABLE students (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    phone         VARCHAR(20) UNIQUE NOT NULL,
    nickname      VARCHAR(50),
    avatar_url    TEXT,

    -- 注册信息
    region_id     VARCHAR(30) NOT NULL,        -- 省份/城市，如 'tianjin'
    subject       VARCHAR(20) NOT NULL,        -- 科目，如 'physics'
    target_score  INT NOT NULL,                -- 目标裸分

    -- 卷面策略（注册时生成，目标分变更时重算）
    exam_strategy JSONB,                       -- question_strategies数组

    -- 三维画像（注册诊断初始化，日常更新）
    formula_memory_rate   FLOAT DEFAULT 0,     -- 公式记忆度 0-1
    model_identify_rate   FLOAT DEFAULT 0,     -- 模型识别力 0-1
    calculation_accuracy  FLOAT DEFAULT 0,     -- 计算准确度 0-1
    reading_accuracy      FLOAT DEFAULT 0,     -- 审题正确率 0-1

    -- 闭环统计
    total_closures_today  INT DEFAULT 0,
    total_closures_week   INT DEFAULT 0,

    -- 预测
    predicted_score       FLOAT,
    last_prediction_time  TIMESTAMPTZ,

    created_at    TIMESTAMPTZ DEFAULT now(),
    updated_at    TIMESTAMPTZ DEFAULT now()
);
```

---

## 表2：knowledge_points（知识点）

```sql
CREATE TABLE knowledge_points (
    id                VARCHAR(50) PRIMARY KEY,   -- 如 'kp_electrostatic_force'
    name              VARCHAR(100) NOT NULL,
    chapter           VARCHAR(100) NOT NULL,     -- Level 1：章
    section           VARCHAR(100) NOT NULL,     -- Level 2：节
    conclusion_level  SMALLINT DEFAULT 1,        -- 1=一级结论(需深入理解) 2=二级结论(记住即可)
    related_model_ids TEXT[],                    -- 关联模型ID数组
    description       TEXT,
    created_at        TIMESTAMPTZ DEFAULT now()
);
```

---

## 表3：models（解题模型）

```sql
CREATE TABLE models (
    id                VARCHAR(50) PRIMARY KEY,   -- 如 'model_plate_motion'
    name              VARCHAR(100) NOT NULL,
    chapter           VARCHAR(100) NOT NULL,     -- Level 1：章
    section           VARCHAR(100) NOT NULL,     -- Level 2：节
    prerequisite_kp_ids TEXT[],                  -- 前置知识点ID数组
    confusion_group_ids TEXT[],                  -- 所属易混组ID
    description       TEXT,
    created_at        TIMESTAMPTZ DEFAULT now()
);
```

---

## 表4：student_mastery（学生掌握度 — 核心状态表）

> 每个学生×每个知识点/模型 = 一行。这是域6状态引擎的核心。

```sql
CREATE TABLE student_mastery (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id      UUID NOT NULL REFERENCES students(id),
    target_type     VARCHAR(10) NOT NULL,        -- 'kp' 或 'model'
    target_id       VARCHAR(50) NOT NULL,         -- knowledge_point.id 或 model.id

    -- Section 二十九：完整标签字段集
    current_level       SMALLINT DEFAULT 0,       -- 0-5 当前掌握度
    peak_level          SMALLINT DEFAULT 0,       -- 0-5 历史最高
    last_active         TIMESTAMPTZ,              -- 最后交互时间
    error_count         INT DEFAULT 0,
    correct_count       INT DEFAULT 0,
    recent_results      BOOLEAN[] DEFAULT '{}',   -- 最近4次对错
    last_error_subtype  VARCHAR(30),              -- identify_wrong/decide_wrong/step_wrong/...
    is_unstable         BOOLEAN DEFAULT FALSE,    -- 仅model有效
    next_retest_date    TIMESTAMPTZ,              -- 仅model：L4后延时复测日期

    created_at      TIMESTAMPTZ DEFAULT now(),
    updated_at      TIMESTAMPTZ DEFAULT now(),

    UNIQUE(student_id, target_type, target_id)
);

CREATE INDEX idx_mastery_student ON student_mastery(student_id);
CREATE INDEX idx_mastery_level ON student_mastery(student_id, current_level);
```

---

## 表5：questions（题目）

```sql
CREATE TABLE questions (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id        UUID NOT NULL REFERENCES students(id),
    source            VARCHAR(20) NOT NULL,       -- homework / practice / exam
    upload_batch_id   UUID,                       -- 属于哪次上传
    image_url         TEXT,

    is_correct            BOOLEAN,                -- 学生标注的对错
    primary_model_id      VARCHAR(50),            -- 主归属模型（AI打标签）
    related_kp_ids        TEXT[],                 -- 关联知识点
    exam_question_number  INT,                    -- 高考题号（仅考试卷子）

    -- 诊断结果
    diagnosis_status      VARCHAR(20) DEFAULT 'pending',  -- pending/diagnosed/skipped
    diagnosis_result      JSONB,                  -- {error_type, error_subtype, confidence}

    created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_questions_student ON questions(student_id, created_at DESC);
CREATE INDEX idx_questions_model ON questions(primary_model_id);
```

---

## 表6：regional_templates（地区卷面模板）

```sql
CREATE TABLE regional_templates (
    id              VARCHAR(50) PRIMARY KEY,     -- 如 'tianjin_physics_70'
    region_id       VARCHAR(30) NOT NULL,
    subject         VARCHAR(20) NOT NULL,
    target_score    INT NOT NULL,
    total_score     INT NOT NULL,

    exam_structure      JSONB NOT NULL,          -- 卷面结构（题型+题号+分值+难度+关联模型）
    question_strategies JSONB NOT NULL,          -- 分数档策略（must/try/skip）
    diagnosis_path      JSONB NOT NULL,          -- 诊断路径（tier排序+测试题ID）

    created_at  TIMESTAMPTZ DEFAULT now(),

    UNIQUE(region_id, subject, target_score)
);
```

---

## 表7：upload_batches（上传批次）

```sql
CREATE TABLE upload_batches (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id  UUID NOT NULL REFERENCES students(id),
    source      VARCHAR(20) NOT NULL,   -- homework / practice / exam
    image_count INT DEFAULT 0,
    created_at  TIMESTAMPTZ DEFAULT now()
);
```

---

## 表8：confusion_groups（易混组 — 教研预设）

```sql
CREATE TABLE confusion_groups (
    id               VARCHAR(50) PRIMARY KEY,
    model_ids        TEXT[] NOT NULL,          -- 组内模型ID
    comparison_table JSONB,                    -- {headers:[], rows:[[]]}
    created_at       TIMESTAMPTZ DEFAULT now()
);
```

---

## 表9：diagnosis_sessions（AI诊断会话）

> M4 新增。每次 AI 诊断对话创建一个会话，最多 5 轮。

```sql
CREATE TABLE diagnosis_sessions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id      UUID NOT NULL REFERENCES students(id),
    question_id     UUID NOT NULL REFERENCES questions(id),
    status          VARCHAR(20) NOT NULL DEFAULT 'active',   -- active/completed
    current_round   SMALLINT NOT NULL DEFAULT 0,
    max_rounds      SMALLINT NOT NULL DEFAULT 5,
    system_prompt   TEXT,                                     -- LLM system prompt 快照
    diagnosis_result JSONB,                                   -- 诊断结论 JSON

    created_at      TIMESTAMPTZ DEFAULT now(),
    updated_at      TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_diag_session_student ON diagnosis_sessions(student_id);
CREATE INDEX idx_diag_session_question ON diagnosis_sessions(question_id);
CREATE UNIQUE INDEX idx_diag_session_active
    ON diagnosis_sessions(student_id, question_id) WHERE status = 'active';
```

---

## 表10：diagnosis_messages（诊断消息）

```sql
CREATE TABLE diagnosis_messages (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id  UUID NOT NULL REFERENCES diagnosis_sessions(id) ON DELETE CASCADE,
    role        VARCHAR(10) NOT NULL,    -- 'user' / 'assistant'
    content     TEXT NOT NULL,
    round       SMALLINT NOT NULL,       -- 第几轮对话
    token_count INT,

    created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_diag_msg_session ON diagnosis_messages(session_id, created_at);
```

---

## 表11：learning_sessions（知识学习会话）

> M5 新增。五步 AI 引导学习流程。

```sql
CREATE TABLE learning_sessions (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id          UUID NOT NULL REFERENCES students(id),
    knowledge_point_id  VARCHAR(50) NOT NULL,
    status              VARCHAR(20) NOT NULL DEFAULT 'active',  -- active/completed
    source              VARCHAR(30) NOT NULL DEFAULT 'self_study',
    current_step        INT NOT NULL DEFAULT 1,
    max_steps           INT NOT NULL DEFAULT 5,
    mastery_before      FLOAT,
    mastery_after       FLOAT,
    level_before        VARCHAR(5),
    level_after         VARCHAR(5),
    system_prompt       TEXT,

    created_at          TIMESTAMPTZ DEFAULT now(),
    updated_at          TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ls_student ON learning_sessions(student_id);
CREATE INDEX idx_ls_status ON learning_sessions(student_id, status);
```

---

## 表12：learning_messages（学习消息）

```sql
CREATE TABLE learning_messages (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id  UUID NOT NULL REFERENCES learning_sessions(id) ON DELETE CASCADE,
    role        VARCHAR(10) NOT NULL,
    content     TEXT NOT NULL,
    step        INT NOT NULL,
    token_count INT,

    created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_learn_msg_session ON learning_messages(session_id, created_at);
```

---

## 表13：training_sessions（模型训练会话）

> M5 新增。解题模型分步训练。

```sql
CREATE TABLE training_sessions (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id        UUID NOT NULL REFERENCES students(id),
    model_id          VARCHAR(50) NOT NULL,
    model_name        VARCHAR(100),
    status            VARCHAR(20) NOT NULL DEFAULT 'active',
    current_step      INT NOT NULL DEFAULT 1,
    entry_step        INT NOT NULL DEFAULT 1,
    source            VARCHAR(30) NOT NULL DEFAULT 'self_study',
    question_id       UUID REFERENCES questions(id),
    diagnosis_result  JSONB,
    system_prompt     TEXT,
    mastery_snapshot  JSONB,
    training_result   JSONB,

    created_at        TIMESTAMPTZ DEFAULT now(),
    updated_at        TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_train_session_student ON training_sessions(student_id);
CREATE INDEX idx_train_session_model ON training_sessions(model_id);
CREATE UNIQUE INDEX idx_train_session_active
    ON training_sessions(student_id, model_id) WHERE status = 'active';
```

---

## 表14：training_messages（训练消息）

```sql
CREATE TABLE training_messages (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id  UUID NOT NULL REFERENCES training_sessions(id) ON DELETE CASCADE,
    role        VARCHAR(10) NOT NULL,
    content     TEXT NOT NULL,
    step        SMALLINT NOT NULL,
    token_count INT,

    created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_train_msg_session ON training_messages(session_id, created_at);
```

---

## 表15：training_step_results（训练步骤结果）

```sql
CREATE TABLE training_step_results (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id  UUID NOT NULL REFERENCES training_sessions(id) ON DELETE CASCADE,
    step        SMALLINT NOT NULL,
    passed      BOOLEAN NOT NULL,
    ai_summary  TEXT,
    details     JSONB,

    created_at  TIMESTAMPTZ DEFAULT now(),

    UNIQUE(session_id, step)
);

CREATE INDEX idx_train_step_session ON training_step_results(session_id);
```

---

## 表16：feature_requests（社区需求）

> M6 新增。社区需求投票功能。

```sql
CREATE TABLE feature_requests (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title       VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    vote_count  INT DEFAULT 0,
    tag         VARCHAR(50),
    student_id  UUID NOT NULL REFERENCES students(id),

    created_at  TIMESTAMPTZ DEFAULT now()
);
```

---

## 表17：votes（投票记录）

```sql
CREATE TABLE votes (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id  UUID NOT NULL REFERENCES students(id),
    request_id  UUID NOT NULL REFERENCES feature_requests(id) ON DELETE CASCADE,

    created_at  TIMESTAMPTZ DEFAULT now(),

    UNIQUE(student_id, request_id)
);
```

---

## 表18：feedbacks（用户反馈）

```sql
CREATE TABLE feedbacks (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content        TEXT NOT NULL,
    feedback_type  VARCHAR(30) NOT NULL,   -- bug / suggestion / other
    student_id     UUID NOT NULL REFERENCES students(id),

    created_at     TIMESTAMPTZ DEFAULT now()
);
```

---

## 设计说明

1. **student_mastery 是系统心脏**：域6状态引擎的所有读写都在这张表。索引设计优先保证 `student_id + current_level` 的查询性能（推荐排序依赖）。

2. **JSONB 用于半结构化数据**：exam_strategy、diagnosis_result、exam_structure 等字段结构复杂且可能演化，用 JSONB 比拆表更灵活。

3. **闪卡表(flashcards)暂不建**：MVP不做闪卡功能，第二个月再加。

4. **Level含义速查**：
   - 知识点：L0=未发现, L1=记不住, L2=理解不深, L3=使用出错, L4=能用, L5=稳定
   - 模型：L0=未发现, L1=建模卡住, L2=列式卡住, L3=执行卡住, L4=做对过, L5=稳定
