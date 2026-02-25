"""Knowledge learning session schemas."""
from pydantic import BaseModel, Field


class LearningDialogue(BaseModel):
    role: str = Field(default="", description="对话角色，user 表示学生，assistant 表示 AI 教学助手")
    content: str = Field(default="", description="对话文本内容")


class LearningSession(BaseModel):
    knowledge_point_id: str = Field(default="", description="当前学习的知识点 ID")
    knowledge_point_name: str = Field(default="", description="知识点名称")
    current_step: int = Field(default=0, description="当前学习进度步骤编号，从 0 开始")
    dialogues: list[LearningDialogue] = Field(default=[], description="学习对话记录列表")
