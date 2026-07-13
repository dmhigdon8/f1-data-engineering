"""
Load raw JSON files from ./raw/ into the raw.jolpica_payloads landing table.
dbt takes it from there.

Example:
    python -m ingest.load
"""
from __future__ import annotations

import json
import logging
from pathlib import Path

import psycopg
from psycopg.types.json import Json

from ingest.config import settings
from ingest.s3_client import FILE_RE

log = logging.getLogger("load")
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s | %(message)s",
)

INSERT_SQL = """
INSERT INTO raw.jolpica_payloads (endpoint, season, round_num, payload)
VALUES (%s, %s, %s, %s)
"""


def load_all() -> None:
    files = sorted(Path(settings.raw_dir).glob("*.json"))
    if not files:
        log.warning("No raw files to load in %s", settings.raw_dir)
        return

    with psycopg.connect(settings.pg_dsn, autocommit=False) as conn:
        with conn.cursor() as cur:
            for path in files:
                m = FILE_RE.match(path.name)
                if not m:
                    log.warning("skip %s", path.name)
                    continue
                with path.open(encoding="utf-8") as f:
                    blob = json.load(f)
                cur.execute(
                    INSERT_SQL,
                    (blob["endpoint"], int(blob["season"]), None, Json(blob)),
                )
                log.info("loaded %s", path.name)
        conn.commit()
    log.info("All files loaded into raw.jolpica_payloads.")


if __name__ == "__main__":
    load_all()
