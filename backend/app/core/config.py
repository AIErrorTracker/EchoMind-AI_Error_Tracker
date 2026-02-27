import os
import secrets

from pydantic_settings import BaseSettings


def _default_secret_key() -> str:
    """优先从环境变量读取，否则生成随机密钥（开发环境自动生成，生产环境必须显式设置）。"""
    env_key = os.environ.get("SECRET_KEY", "")
    if env_key:
        return env_key
    # 开发环境：自动生成随机密钥，每次重启不同
    return secrets.token_urlsafe(32)


class Settings(BaseSettings):
    database_url: str = "postgresql+asyncpg://postgres:postgres@db:5432/echomind"
    secret_key: str = _default_secret_key()
    access_token_expire_minutes: int = 1440
    algorithm: str = "HS256"

    # LLM 配置
    llm_provider: str = "gemini"
    llm_api_key: str = ""
    llm_model: str = "gemini-3.0-flash"
    llm_max_tokens: int = 1024
    llm_temperature: float = 0.7
    llm_proxy: str = ""  # HTTP 代理地址，如 http://127.0.0.1:7890

    model_config = {"env_file": ".env", "extra": "ignore"}


settings = Settings()
