"""Diagnosis session router."""
from fastapi import APIRouter, Depends

from app.core.deps import get_current_user
from app.models.student import Student
from app.schemas.diagnosis import DiagnosisSession
from app.services import diagnosis_service

router = APIRouter(prefix="/diagnosis", tags=["AI诊断"])


@router.get("/session", response_model=DiagnosisSession)
async def get_session(user: Student = Depends(get_current_user)):
    return await diagnosis_service.get_session()
