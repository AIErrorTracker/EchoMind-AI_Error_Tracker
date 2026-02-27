"""Image upload router."""
import logging
import uuid
from pathlib import Path

from fastapi import APIRouter, Depends, HTTPException, UploadFile

from app.core.deps import get_current_user

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/upload", tags=["图片上传"])

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

    # 防路径遍历：只取文件名的后缀，忽略原始文件名
    raw_name = Path(file.filename or "img.jpg").name  # strip directory components
    ext = Path(raw_name).suffix.lower()
    if ext not in (".jpg", ".jpeg", ".png"):
        ext = ".jpg"
    image_id = str(uuid.uuid4())
    filename = f"{image_id}{ext}"

    try:
        UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
        (UPLOAD_DIR / filename).write_bytes(data)
    except OSError as e:
        logger.error("文件写入失败: %s", e)
        raise HTTPException(500, "文件保存失败，请稍后重试")

    return {"image_url": f"/uploads/{filename}", "image_id": image_id}
