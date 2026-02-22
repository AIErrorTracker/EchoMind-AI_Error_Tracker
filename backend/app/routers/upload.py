"""Image upload router."""
import uuid
from pathlib import Path

from fastapi import APIRouter, Depends, HTTPException, UploadFile

from app.core.deps import get_current_user

router = APIRouter(prefix="/upload", tags=["upload"])

UPLOAD_DIR = Path(__file__).resolve().parents[2] / "uploads"
ALLOWED_TYPES = {"image/jpeg", "image/png"}
MAX_SIZE = 10 * 1024 * 1024  # 10MB


@router.post("/image")
async def upload_image(file: UploadFile, _=Depends(get_current_user)):
    if file.content_type not in ALLOWED_TYPES:
        raise HTTPException(400, "Only jpg/png allowed")

    data = await file.read()
    if len(data) > MAX_SIZE:
        raise HTTPException(400, "File exceeds 10MB limit")

    ext = Path(file.filename or "img.jpg").suffix or ".jpg"
    image_id = str(uuid.uuid4())
    filename = f"{image_id}{ext}"

    UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
    (UPLOAD_DIR / filename).write_bytes(data)

    return {"image_url": f"/uploads/{filename}", "image_id": image_id}
