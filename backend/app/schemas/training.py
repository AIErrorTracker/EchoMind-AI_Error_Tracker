"""Model training session schemas."""
from pydantic import BaseModel, Field


class TrainingDialogue(BaseModel):
    role: str = Field(default="", description="对话角色，user 表示学生，assistant 表示 AI 训练助手")
    content: str = Field(default="", description="对话文本内容")


class TrainingSession(BaseModel):
    model_id: str = Field(default="", description="当前训练的解题模型 ID")
    model_name: str = Field(default="", description="解题模型名称")
    current_step: int = Field(default=0, description="当前训练进度步骤编号，从 0 开始")
    dialogues: list[TrainingDialogue] = Field(default=[], description="训练对话记录列表")
