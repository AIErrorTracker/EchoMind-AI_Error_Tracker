"""Knowledge learning session router."""
from fastapi import APIRouter, Depends

from app.core.deps import get_current_user
from app.models.student import Student
from app.schemas.learning import LearningSession
from app.services import learning_service

router = APIRouter(prefix="/knowledge/learning", tags=["知识学习"])


@router.get("/session", response_model=LearningSession)
async def get_session(user: Student = Depends(get_current_user)):
    return await learning_service.get_session()
