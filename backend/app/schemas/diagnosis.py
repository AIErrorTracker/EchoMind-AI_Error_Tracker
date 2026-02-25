"""Diagnosis session schemas."""
from pydantic import BaseModel, Field


class DiagnosisMessage(BaseModel):
    role: str = Field(default="", description="消息角色，user 表示学生，assistant 表示 AI 诊断助手")
    content: str = Field(default="", description="消息文本内容")


class DiagnosisSession(BaseModel):
    session_id: str = Field(default="", description="诊断会话唯一 ID (UUID)")
    status: str = Field(default="idle", description="会话状态：idle 空闲 / active 进行中 / completed 已完成")
    messages: list[DiagnosisMessage] = Field(default=[], description="诊断对话消息列表")
