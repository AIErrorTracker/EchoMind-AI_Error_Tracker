"""Dashboard schemas."""
from pydantic import BaseModel, Field


class DashboardResponse(BaseModel):
    total_questions: int = Field(description="题目总数")
    error_count: int = Field(description="错题总数")
    mastery_count: int = Field(description="已掌握的知识点/模型数量")
    weak_count: int = Field(description="薄弱的知识点/模型数量")
    predicted_score: float | None = Field(description="AI 预测分数，无数据时为 null")
    formula_memory_rate: float = Field(description="公式记忆准确率 (0.0-1.0)")
    model_identify_rate: float = Field(description="模型识别准确率 (0.0-1.0)")
    calculation_accuracy: float = Field(description="计算准确率 (0.0-1.0)")
    reading_accuracy: float = Field(description="审题准确率 (0.0-1.0)")
