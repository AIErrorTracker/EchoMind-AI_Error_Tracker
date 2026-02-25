"""Question schemas."""
from datetime import datetime
from pydantic import BaseModel, Field


class QuestionUploadRequest(BaseModel):
    image_url: str | None = Field(default=None, description="题目图片 URL，通过 /api/upload/image 上传后获得")
    is_correct: bool | None = Field(default=None, description="作答是否正确，true=正确 false=错误 null=未判定")
    source: str = Field(default="manual", description="题目来源，manual=手动录入 photo=拍照上传")
    primary_model_id: str | None = Field(default=None, description="主要关联的解题模型 ID")
    related_kp_ids: list[str] | None = Field(default=None, description="关联的知识点 ID 列表")


class QuestionResponse(BaseModel):
    id: str = Field(description="题目唯一 ID (UUID)")
    image_url: str | None = Field(description="题目图片 URL")
    is_correct: bool | None = Field(description="作答是否正确")
    source: str = Field(description="题目来源 (manual/photo)")
    diagnosis_status: str = Field(description="诊断状态：pending=待诊断 done=已诊断 none=无需诊断")
    created_at: datetime = Field(description="上传时间 (ISO 8601)")

    model_config = {"from_attributes": True}


class QuestionDetailResponse(BaseModel):
    id: str = Field(description="题目唯一 ID (UUID)")
    image_url: str | None = Field(default=None, description="题目图片 URL")
    is_correct: bool | None = Field(default=None, description="作答是否正确")
    source: str = Field(description="题目来源 (manual/photo)")
    diagnosis_status: str = Field(description="诊断状态：pending/done/none")
    diagnosis_result: dict | None = Field(default=None, description="AI 诊断结果 JSON，包含错因分析等")
    created_at: datetime = Field(description="上传时间 (ISO 8601)")
    primary_model_id: str | None = Field(default=None, description="主要关联的解题模型 ID")
    related_kp_ids: list[str] | None = Field(default=None, description="关联的知识点 ID 列表")

    model_config = {"from_attributes": True}


class HistoryDateGroup(BaseModel):
    date: str = Field(description="日期分组键，格式 YYYY-MM-DD")
    questions: list[QuestionResponse] = Field(description="该日期下的题目列表")


class AggregateItem(BaseModel):
    target_id: str = Field(description="聚合目标 ID（模型 ID 或知识点 ID）")
    target_name: str = Field(description="聚合目标名称")
    total: int = Field(description="该目标下的题目总数")
    error_count: int = Field(description="该目标下的错题数量")
