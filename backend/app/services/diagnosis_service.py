"""Diagnosis session service — stub."""
from app.schemas.diagnosis import DiagnosisSession


async def get_session() -> DiagnosisSession:
    return DiagnosisSession()
