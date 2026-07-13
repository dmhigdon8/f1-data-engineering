"""Environment-driven configuration for the F1 ingestion pipeline."""
from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path

from dotenv import load_dotenv

# Load .env from repo root if present (safe no-op in Docker where env_file already set)
load_dotenv(dotenv_path=Path(__file__).resolve().parent.parent / ".env")


@dataclass(frozen=True)
class Settings:
    # Jolpica
    jolpica_base_url: str = os.getenv(
        "JOLPICA_BASE_URL", "https://api.jolpi.ca/ergast/f1"
    )

    # Postgres
    pg_host: str = os.getenv("POSTGRES_HOST", "localhost")
    pg_port: int = int(os.getenv("POSTGRES_PORT", "5432"))
    pg_user: str = os.getenv("POSTGRES_USER", "f1")
    pg_password: str = os.getenv("POSTGRES_PASSWORD", "f1pass")
    pg_database: str = os.getenv("POSTGRES_DB", "f1")

    # AWS
    aws_region: str = os.getenv("AWS_REGION", "us-east-1")
    aws_s3_bucket: str | None = os.getenv("AWS_S3_BUCKET") or None

    # Pipeline
    season_start: int = int(os.getenv("SEASON_START", "2020"))
    season_end: int = int(os.getenv("SEASON_END", "2024"))

    # Paths
    raw_dir: Path = Path(os.getenv("RAW_DIR", "/app/raw"))

    @property
    def pg_dsn(self) -> str:
        return (
            f"postgresql://{self.pg_user}:{self.pg_password}"
            f"@{self.pg_host}:{self.pg_port}/{self.pg_database}"
        )


settings = Settings()
