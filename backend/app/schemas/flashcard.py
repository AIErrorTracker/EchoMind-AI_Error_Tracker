"""Flashcard schemas."""
from pydantic import BaseModel, Field


class FlashcardItem(BaseModel):
    id: str = Field(description="Mastery 记录 ID (UUID)")
    target_type: str = Field(description="目标类型：model=解题模型 knowledge=知识点")
    target_id: str = Field(description="目标 ID（模型 ID 或知识点 ID）")
    target_name: str = Field(description="目标名称")
    mastery_value: float = Field(description="掌握度（0.0-1.0）")
    due: bool = Field(description="是否到期需要复习，true=需要复习")


class FlashcardReviewRequest(BaseModel):
    quality: int = Field(description="SM-2 算法质量评分（0-5），0=完全忘记 5=完美记忆")
