"""Model training session service — stub."""
from app.schemas.training import TrainingSession


async def get_session() -> TrainingSession:
    return TrainingSession()
