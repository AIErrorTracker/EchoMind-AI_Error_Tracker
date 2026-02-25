"""Knowledge point schemas."""
from pydantic import BaseModel, Field


class KnowledgePointItem(BaseModel):
    id: str = Field(description="知识点唯一 ID")
    name: str = Field(description="知识点名称")
    conclusion_level: int = Field(description="归纳层级：1=一级知识点 2=二级 3=三级")
    description: str | None = Field(default=None, description="知识点描述")

    model_config = {"from_attributes": True}


class SectionNode(BaseModel):
    section: str = Field(description="章节名称")
    items: list[KnowledgePointItem] = Field(description="该章节下的知识点列表")


class ChapterNode(BaseModel):
    chapter: str = Field(description="章名称")
    sections: list[SectionNode] = Field(description="该章下的节列表")


class KnowledgePointDetail(KnowledgePointItem):
    chapter: str = Field(description="所属章名称")
    section: str = Field(description="所属节名称")
    related_model_ids: list[str] | None = Field(default=None, description="关联的解题模型 ID 列表")
    mastery_level: int | None = Field(default=None, description="掌握等级：0=未学习 1=薄弱 2=一般 3=掌握 4=精通")
    mastery_value: float | None = Field(default=None, description="掌握度数值 (0.0-1.0)")
    error_count: int = Field(default=0, description="该知识点关联的错题数量")
    correct_count: int = Field(default=0, description="该知识点关联的正确题数量")
