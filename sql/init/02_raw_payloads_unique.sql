-- Enforces one row per (endpoint, season) so re-running the loader is idempotent.
ALTER TABLE raw.jolpica_payloads
    ADD CONSTRAINT uq_jolpica_payloads_endpoint_season UNIQUE (endpoint, season);
