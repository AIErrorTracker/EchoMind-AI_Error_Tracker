"""Exam schemas."""
from datetime import datetime
from pydantic import BaseModel, Field


class ExamItem(BaseModel):
    id: str = Field(description="考试记录 ID（由 Question 按日期聚合生成）")
    name: str = Field(description="考试名称")
    score: float | None = Field(default=None, description="得分，无成绩时为 null")
    total_score: float = Field(default=150, description="总分，默认 150")
    date: str = Field(description="考试日期，格式 YYYY-MM-DD")


class HeatmapPoint(BaseModel):
    date: str = Field(description="日期，格式 YYYY-MM-DD")
    count: int = Field(description="当日做题数量")
