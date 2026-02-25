"""Model training session router."""
from fastapi import APIRouter, Depends

from app.core.deps import get_current_user
from app.models.student import Student
from app.schemas.training import TrainingSession
from app.services import training_service

router = APIRouter(prefix="/models/training", tags=["模型训练"])


@router.get("/session", response_model=TrainingSession)
async def get_session(user: Student = Depends(get_current_user)):
    return await training_service.get_session()
