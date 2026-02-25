"""Knowledge learning session service — stub."""
from app.schemas.learning import LearningSession


async def get_session() -> LearningSession:
    return LearningSession()
