-- Runs automatically the first time the Postgres container is created.
-- Creates the schemas dbt and the ingestion loader will use.

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS marts;

-- Landing table: one JSON blob per endpoint pull. dbt parses it downstream.
CREATE TABLE IF NOT EXISTS raw.jolpica_payloads (
    id            BIGSERIAL PRIMARY KEY,
    endpoint      TEXT        NOT NULL,
    season        INT,
    round_num     INT,
    fetched_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    payload       JSONB       NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_raw_jolpica_endpoint
    ON raw.jolpica_payloads (endpoint, season, round_num);
