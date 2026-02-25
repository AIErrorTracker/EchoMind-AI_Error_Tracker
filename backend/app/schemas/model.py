"""Model (解题模型) schemas."""
from pydantic import BaseModel, Field


class ModelItem(BaseModel):
    id: str = Field(description="解题模型唯一 ID")
    name: str = Field(description="解题模型名称")
    description: str | None = Field(default=None, description="模型描述")

    model_config = {"from_attributes": True}


class ModelSectionNode(BaseModel):
    section: str = Field(description="节名称")
    items: list[ModelItem] = Field(description="该节下的解题模型列表")


class ModelChapterNode(BaseModel):
    chapter: str = Field(description="章名称")
    sections: list[ModelSectionNode] = Field(description="该章下的节列表")


class ModelDetail(ModelItem):
    chapter: str = Field(description="所属章名称")
    section: str = Field(description="所属节名称")
    prerequisite_kp_ids: list[str] | None = Field(default=None, description="前置知识点 ID 列表")
    confusion_group_ids: list[str] | None = Field(default=None, description="易混淆模型组 ID 列表")
    mastery_level: int | None = Field(default=None, description="掌握等级：0=未学习 1=薄弱 2=一般 3=掌握 4=精通")
    mastery_value: float | None = Field(default=None, description="掌握度数值 (0.0-1.0)")
    error_count: int = Field(default=0, description="该模型关联的错题数量")
    correct_count: int = Field(default=0, description="该模型关联的正确题数量")
