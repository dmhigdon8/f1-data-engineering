"""
Extract F1 data from the Jolpica (Ergast-compatible) API and write raw JSON
files to ./raw/ (one file per endpoint+season pull).

Jolpica API docs:  https://github.com/jolpica/jolpica-f1
This uses the /ergast/f1 compatibility layer so any Ergast tutorial works.

Example:
    python -m ingest.extract --seasons 2023 2024 --endpoint results
    python -m ingest.extract --seasons 2024 --endpoint all
"""
from __future__ import annotations

import json
import logging
import sys
from pathlib import Path
from typing import Iterable

import click
import requests
from tenacity import retry, stop_after_attempt, wait_exponential

from ingest.config import settings

log = logging.getLogger("extract")
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s | %(message)s",
)

# Endpoints we care about. Jolpica returns JSON with an outer MRData envelope.
# Path template is interpolated with {season} (and sometimes {round}).
ENDPOINTS: dict[str, str] = {
    "races":     "/{season}/races.json?limit=100",
    "drivers":   "/{season}/drivers.json?limit=1000",
    "results":   "/{season}/results.json?limit=1000",
    "qualifying":"/{season}/qualifying.json?limit=1000",
    "sprint":    "/{season}/sprint.json?limit=1000",
    "standings": "/{season}/driverStandings.json?limit=100",
}

# Endpoints that don't exist for all seasons. Jolpica returns 200 with empty
# RaceTable for these when there's no data, so no special-casing is needed
# at the HTTP layer — but we log it so dry years aren't mysterious.
HISTORICALLY_PARTIAL: dict[str, int] = {
    "sprint": 2021,  # first F1 sprint race: Silverstone 2021
}

session = requests.Session()
session.headers.update({"User-Agent": "f1-data-engineering/0.1 (learning project)"})


@retry(stop=stop_after_attempt(5), wait=wait_exponential(multiplier=1, min=2, max=30))
def _get(url: str) -> dict:
    log.info("GET %s", url)
    r = session.get(url, timeout=30)
    r.raise_for_status()
    return r.json()


def _fetch_paginated(endpoint_path: str) -> list[dict]:
    """Walk Jolpica pagination via offset/limit. Returns list of raw JSON pages."""
    pages: list[dict] = []
    offset = 0
    while True:
        sep = "&" if "?" in endpoint_path else "?"
        url = f"{settings.jolpica_base_url}{endpoint_path}{sep}offset={offset}"
        payload = _get(url)
        pages.append(payload)

        mrdata = payload.get("MRData", {})
        total = int(mrdata.get("total", 0))
        limit = int(mrdata.get("limit", 0))
        offset += limit
        if offset >= total or limit == 0:
            break
    return pages


def _write_raw(name: str, season: int, pages: list[dict]) -> Path:
    settings.raw_dir.mkdir(parents=True, exist_ok=True)
    out = settings.raw_dir / f"{name}_{season}.json"
    with out.open("w", encoding="utf-8") as f:
        json.dump({"endpoint": name, "season": season, "pages": pages}, f, indent=2)
    log.info("wrote %s (%d pages)", out, len(pages))
    return out


def extract_season(season: int, which: Iterable[str]) -> list[Path]:
    written: list[Path] = []
    for name in which:
        if name in HISTORICALLY_PARTIAL and season < HISTORICALLY_PARTIAL[name]:
            log.info(
                "skipping %s for season %s (no data before %s)",
                name, season, HISTORICALLY_PARTIAL[name],
            )
            continue
        template = ENDPOINTS[name]
        path = template.format(season=season)
        pages = _fetch_paginated(path)
        written.append(_write_raw(name, season, pages))
    return written


@click.command()
@click.option(
    "--seasons",
    multiple=True,
    type=int,
    help="One or more seasons to pull, e.g. --seasons 2023 --seasons 2024",
)
@click.option(
    "--endpoint",
    type=click.Choice(list(ENDPOINTS.keys()) + ["all"]),
    default="all",
    show_default=True,
)
def main(seasons: tuple[int, ...], endpoint: str) -> None:
    seasons = seasons or tuple(range(settings.season_start, settings.season_end + 1))
    which = list(ENDPOINTS.keys()) if endpoint == "all" else [endpoint]

    log.info("Extracting %s for seasons %s", which, list(seasons))
    for season in seasons:
        extract_season(season, which)
    log.info("Done. Raw files in %s", settings.raw_dir)


if __name__ == "__main__":
    main()
