"""
Upload raw JSON files produced by extract.py to S3 under a partitioned key:
    s3://{bucket}/raw/jolpica/{endpoint}/season={YYYY}/{filename}

Example:
    python -m ingest.s3_client upload --prefix raw/jolpica
"""
from __future__ import annotations

import logging
import re
from pathlib import Path

import boto3
import click
from botocore.exceptions import BotoCoreError, ClientError

from ingest.config import settings

log = logging.getLogger("s3")
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s | %(message)s",
)

# Filenames look like:  results_2024.json
FILE_RE = re.compile(r"^(?P<endpoint>[a-z_]+)_(?P<season>\d{4})\.json$")


def _client():
    return boto3.client("s3", region_name=settings.aws_region)


@click.group()
def cli() -> None:
    pass


@cli.command()
def ensure_bucket() -> None:
    """Create the bucket if it doesn't exist (idempotent)."""
    if not settings.aws_s3_bucket:
        raise click.ClickException("AWS_S3_BUCKET is not set in .env")
    s3 = _client()
    try:
        s3.head_bucket(Bucket=settings.aws_s3_bucket)
        log.info("Bucket %s already exists", settings.aws_s3_bucket)
        return
    except ClientError:
        log.info("Creating bucket %s in %s", settings.aws_s3_bucket, settings.aws_region)
    kwargs = {"Bucket": settings.aws_s3_bucket}
    if settings.aws_region != "us-east-1":
        kwargs["CreateBucketConfiguration"] = {
            "LocationConstraint": settings.aws_region
        }
    s3.create_bucket(**kwargs)


@cli.command()
@click.option("--prefix", default="raw/jolpica", show_default=True)
def upload(prefix: str) -> None:
    """Upload every JSON file in the local raw/ dir to S3."""
    if not settings.aws_s3_bucket:
        raise click.ClickException("AWS_S3_BUCKET is not set in .env")

    s3 = _client()
    files = sorted(Path(settings.raw_dir).glob("*.json"))
    if not files:
        log.warning("No JSON files in %s — run extract.py first.", settings.raw_dir)
        return

    uploaded = 0
    for path in files:
        m = FILE_RE.match(path.name)
        if not m:
            log.warning("Skipping non-conforming filename: %s", path.name)
            continue
        key = (
            f"{prefix}/{m['endpoint']}/season={m['season']}/{path.name}"
        )
        try:
            s3.upload_file(str(path), settings.aws_s3_bucket, key)
            log.info("uploaded s3://%s/%s", settings.aws_s3_bucket, key)
            uploaded += 1
        except (BotoCoreError, ClientError) as exc:
            log.error("failed to upload %s: %s", path, exc)
    log.info("Done. %d files uploaded.", uploaded)


if __name__ == "__main__":
    cli()
