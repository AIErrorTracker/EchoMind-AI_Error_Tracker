"""Recommendation schemas."""
from pydantic import BaseModel, Field


class RecommendationItem(BaseModel):
    target_type: str = Field(description="推荐目标类型：model=解题模型 knowledge=知识点")
    target_id: str = Field(description="推荐目标 ID")
    target_name: str = Field(description="推荐目标名称")
    current_level: int = Field(description="当前掌握等级（0-5）")
    error_count: int = Field(description="累计错题数量")
    is_unstable: bool = Field(description="掌握度是否不稳定，true=近期正确率波动大")
