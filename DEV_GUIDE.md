# EchoMind AI Error Tracker — 开发指南

> 最后更新: 2026-02-22

## 1. 项目概述

EchoMind 是一个面向中国高中物理/数学的 **AI 错题追踪与诊断系统**。学生拍照上传错题，系统通过 AI 诊断错误根因（知识点缺失、计算失误、审题偏差等），追踪掌握度变化，并提供个性化复习推荐。

### 技术栈

| 层级 | 技术 |
|------|------|
| 后端 | Python 3.12 · FastAPI · SQLAlchemy 2.0 (async) · PostgreSQL 16 · Alembic |
| 前端 | Flutter 3.27+ · Dart 3.6+ · Riverpod · Dio · go_router |
| 认证 | JWT (python-jose + passlib/bcrypt) |
| 部署 | Docker Compose (PostgreSQL + FastAPI) |

## 2. 项目结构

```
EchoMind-AI_Error_Tracker/
├── backend/                    # FastAPI 后端
│   ├── app/
│   │   ├── main.py             # 应用入口，路由注册
│   │   ├── core/
│   │   │   ├── config.py       # Settings (pydantic-settings, 读 .env)
│   │   │   ├── database.py     # AsyncSession 工厂
│   │   │   ├── deps.py         # get_db, get_current_user 依赖
│   │   │   └── security.py     # JWT 创建/验证, 密码哈希
│   │   ├── models/             # SQLAlchemy ORM 模型
│   │   │   ├── student.py
│   │   │   ├── question.py
│   │   │   ├── knowledge_point.py
│   │   │   ├── model.py
│   │   │   ├── student_mastery.py
│   │   │   ├── upload_batch.py
│   │   │   ├── confusion_group.py
│   │   │   └── regional_template.py
│   │   ├── schemas/            # Pydantic 请求/响应 schema
│   │   │   ├── auth.py         # RegisterRequest, LoginRequest, AuthResponse, UserResponse
│   │   │   ├── knowledge.py    # ChapterNode > SectionNode > KnowledgePointItem
│   │   │   ├── model.py        # ModelChapterNode > ModelSectionNode > ModelItem
│   │   │   ├── question.py     # QuestionUploadRequest, QuestionResponse, HistoryDateGroup
│   │   │   ├── dashboard.py    # DashboardResponse
│   │   │   └── recommendation.py # RecommendationItem
│   │   ├── routers/            # API 路由
│   │   │   ├── auth.py         # /api/auth/*
│   │   │   ├── knowledge.py    # /api/knowledge/*
│   │   │   ├── models.py       # /api/models/*
│   │   │   ├── questions.py    # /api/questions/*
│   │   │   ├── dashboard.py    # /api/dashboard
│   │   │   └── recommendations.py # /api/recommendations
│   │   └── services/           # 业务逻辑层 (待实现)
│   ├── alembic/                # 数据库迁移
│   ├── alembic.ini
│   ├── seed.py                 # 种子数据脚本
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .env.example
├── echomind_app/               # Flutter 前端
│   ├── lib/
│   │   ├── main.dart           # 应用入口 (ProviderScope + MaterialApp.router)
│   │   ├── core/
│   │   │   └── api_client.dart # Dio 单例 + Token/Error 拦截器
│   │   ├── app/
│   │   │   ├── app_router.dart # GoRouter 路由配置
│   │   │   └── app_routes.dart # 路由路径常量
│   │   ├── models/             # 数据模型 (json_serializable)
│   │   │   ├── student.dart    # Student (id, phone, regionId, subject...)
│   │   │   ├── knowledge_point.dart # ChapterNode > SectionNode > KnowledgePointItem
│   │   │   ├── model_item.dart # ModelChapterNode > ModelSectionNode > ModelItem
│   │   │   └── question.dart   # Question, HistoryDateGroup
│   │   ├── providers/          # Riverpod 状态管理
│   │   │   ├── auth_provider.dart
│   │   │   ├── dashboard_provider.dart
│   │   │   ├── recommendations_provider.dart
│   │   │   ├── knowledge_tree_provider.dart
│   │   │   └── model_tree_provider.dart
│   │   ├── features/           # 页面模块 (按功能拆分)
│   │   │   ├── home/           # 首页仪表盘
│   │   │   ├── global_knowledge/ # 知识点总览
│   │   │   ├── global_model/   # 题型模型总览
│   │   │   ├── global_exam/    # 考试总览
│   │   │   ├── upload_menu/    # 上传入口
│   │   │   ├── upload_history/ # 上传历史
│   │   │   ├── ai_diagnosis/   # AI 诊断
│   │   │   ├── question_detail/ # 题目详情
│   │   │   ├── knowledge_detail/ # 知识点详情
│   │   │   ├── model_detail/   # 模型详情
│   │   │   ├── knowledge_learning/ # 知识点学习 (5步流程)
│   │   │   ├── flashcard_review/ # 闪卡复习
│   │   │   ├── prediction_center/ # 预测中心
│   │   │   ├── profile/        # 个人中心
│   │   │   └── ...
│   │   └── shared/             # 共享组件
│   │       ├── theme/app_theme.dart
│   │       └── widgets/
│   └── pubspec.yaml
├── docker-compose.yml          # PostgreSQL + API 容器编排
└── docs/                       # 需求与架构文档
    ├── 2_22新文档/
    │   ├── architecture.md     # 三层架构 (Engine/ContentPack/Config)
    │   ├── v1.0.md             # 完整产品规格
    │   └── v1.1part.md         # 物理9步框架 + E/R/S 编码体系
    └── ...
```

## 3. 环境搭建

### 3.1 后端 (Docker 方式 — 推荐)

```bash
# 1. 启动 PostgreSQL + API
docker compose up -d

# 2. 运行数据库迁移
docker compose exec api alembic upgrade head

# 3. (可选) 导入种子数据
docker compose exec api python seed.py

# 4. 验证
curl http://localhost:8000/health
# => {"status": "ok"}
```

### 3.2 后端 (本地开发)

```bash
cd backend

# 创建虚拟环境
python3.12 -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# 安装依赖
pip install -r requirements.txt

# 配置环境变量
cp .env.example .env
# 编辑 .env，确保 DATABASE_URL 指向可用的 PostgreSQL 实例

# 数据库迁移
alembic upgrade head

# 启动开发服务器
uvicorn app.main:app --reload --port 8000
```

环境变量 (`.env`):

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `DATABASE_URL` | `postgresql+asyncpg://postgres:postgres@localhost:5432/echomind` | 数据库连接串 |
| `SECRET_KEY` | `change-me-in-production` | JWT 签名密钥，**生产环境必须更换** |
| `ACCESS_TOKEN_EXPIRE_MINUTES` | `1440` | Token 有效期 (分钟) |

### 3.3 前端 (Flutter)

```bash
cd echomind_app

# 确保 Flutter SDK 已安装 (>=3.27.0)
flutter --version

# 获取依赖
flutter pub get

# 生成序列化代码 (修改 model 后需重新运行)
dart run build_runner build --delete-conflicting-outputs

# 运行 (Android)
flutter run

# 构建 APK
flutter build apk --release
```

> **注意**: API 地址硬编码在 `lib/core/api_client.dart` 的 `_baseUrl` 常量中，默认为 `http://localhost:8000/api`。真机调试时需改为电脑局域网 IP。

## 4. API 端点一览

Base URL: `http://localhost:8000/api`

### 4.1 认证 (`/auth`)

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| POST | `/auth/register` | 注册 (phone, password, region_id, subject, target_score) | 否 |
| POST | `/auth/login` | 登录 (phone, password) → AuthResponse | 否 |
| GET | `/auth/me` | 获取当前用户信息 | Bearer Token |

### 4.2 知识点 (`/knowledge`)

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | `/knowledge/tree` | 知识点树 (章→节→知识点) | Bearer Token |
| GET | `/knowledge/{kp_id}` | 知识点详情 | Bearer Token |

### 4.3 题型模型 (`/models`)

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | `/models/tree` | 模型树 (章→节→模型) | Bearer Token |
| GET | `/models/{model_id}` | 模型详情 | Bearer Token |

### 4.4 题目 (`/questions`)

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| POST | `/questions/upload` | 上传题目 (image_url, source, is_correct) | Bearer Token |
| GET | `/questions/history` | 历史记录 (按日期分组) | Bearer Token |

### 4.5 仪表盘与推荐

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | `/dashboard` | 仪表盘数据 (统计+能力雷达) | Bearer Token |
| GET | `/recommendations` | 推荐复习列表 | Bearer Token |

## 5. 数据库迁移

```bash
cd backend

# 创建新迁移
alembic revision --autogenerate -m "描述变更"

# 执行迁移
alembic upgrade head

# 回滚一步
alembic downgrade -1

# 查看当前版本
alembic current
```

ORM 模型位于 `backend/app/models/`，修改后需生成迁移文件。

## 6. 开发规范

### 6.1 后端

- **路由**: `routers/` 下按资源拆分，统一 `/api` 前缀
- **Schema**: 请求/响应模型放 `schemas/`，字段用 snake_case
- **ORM**: 模型放 `models/`，表名用复数 (students, questions)
- **业务逻辑**: 复杂逻辑放 `services/`，路由层保持薄
- **认证**: 需要登录的端点加 `Depends(get_current_user)`

### 6.2 前端

- **Model**: `lib/models/` 下，使用 `@JsonSerializable()` + `@JsonKey(name: 'snake_case')` 映射后端字段
- **Provider**: `lib/providers/` 下，使用 Riverpod `FutureProvider` / `StateNotifierProvider`
- **页面**: `lib/features/{功能名}/` 下，每个功能一个目录
- **API 基址**: `lib/core/api_client.dart` 中的 `_baseUrl`

### 6.3 前后端字段映射

后端 snake_case → 前端 camelCase，通过 `@JsonKey(name:)` 注解：

```dart
@JsonKey(name: 'region_id')
final String regionId;
```

## 7. 当前进度 (2026-02-22)

### 已完成

- ✅ 后端骨架：FastAPI + PostgreSQL + JWT 认证 + 6 组 API 路由
- ✅ 数据库 ORM 模型：8 张表 (students, questions, knowledge_points, models, student_mastery, upload_batches, confusion_groups, regional_templates)
- ✅ Flutter 前端框架：go_router 路由 + 20+ 页面骨架 (90+ dart 文件)
- ✅ Flutter 网络层：Dio 单例 + Riverpod providers + Token 拦截器
- ✅ 前后端数据模型对齐：Student, KnowledgePoint, ModelItem, Question, Dashboard, Recommendation
- ✅ 后端 `services/` 业务逻辑层：5 个 service 文件，路由层 mock 数据已替换为真实 DB 查询
- ✅ Flutter 登录/注册页面 + 路由守卫 + 上传页面改造
- ✅ seed.py 种子数据（覆盖 6/8 表，merge 幂等设计）
- ✅ 15 个冒烟测试覆盖全部 API 端点
- ✅ docker-compose.yml 修复（env_file 读取 SECRET_KEY）

### 进行中

- 🔄 mastery_value 0-100 连续掌握度计算 (T007)
- 🔄 Flutter 首页/知识树/模型树接入真实 API (T006)
- 🔄 Alembic 迁移验证 + Student 字段默认值修复 (T008)

### 待开发

- ⬜ 图片上传 + OCR/AI 诊断流程
- ⬜ Atom/Episode 交互模型（参见 `docs/2_22新文档/architecture.md`）
- ⬜ E/R/S 错误编码体系（参见 `docs/2_22新文档/v1.1part.md`）
- ⬜ 闪卡复习 SM-2 算法
- ⬜ 成绩预测模型
- ⬜ Flutter UI 美化（响应式布局、字体、边框优化）
- ⬜ Flutter 环境配置 + Android APK 构建

## 8. 服务器部署

### 最小部署 (单机 Docker Compose)

```bash
# 1. 克隆代码
git clone <repo-url> && cd EchoMind-AI_Error_Tracker

# 2. 配置生产环境变量
cp backend/.env.example backend/.env
# 编辑 backend/.env:
#   SECRET_KEY=<随机生成的强密钥>
#   DATABASE_URL=postgresql+asyncpg://postgres:<强密码>@db:5432/echomind

# 3. 同步修改 docker-compose.yml 中的 POSTGRES_PASSWORD

# 4. 启动
docker compose up -d

# 5. 迁移
docker compose exec api alembic upgrade head
```

API 默认监听 `0.0.0.0:8000`，可通过 Nginx 反向代理添加 HTTPS。

## 9. 测试

```bash
cd backend

# 安装测试依赖
pip install httpx pytest

# 运行冒烟测试 (需先启动 API + PostgreSQL)
pytest tests/test_smoke.py -v
```

> 注意：pydantic-settings 会自动将环境变量名做大小写转换，`DATABASE_URL` 和 `database_url` 等价。
