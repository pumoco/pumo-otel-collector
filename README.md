# OpenTelemetry Collector — Pumo observability plane

Single lightweight Go binary that receives OTLP traces/metrics/logs from all services and forwards to the backend (SigNoz Cloud or self-hosted).

## Runflare deployment

| Field | Value |
|---|---|
| Repo | `pumoco/pumo-otel-collector` |
| Branch | `main` |
| Dockerfile | `Dockerfile` |
| Port | `4318` (HTTP) / `4317` (gRPC) |
| Health check | `/health` on port `13133` |

## Required env vars

| Var | Purpose |
|---|---|
| `SIGNOZ_ACCESS_TOKEN` | SigNoz Cloud ingestion token |
| `OTEL_EXPORTER_OTLP_ENDPOINT` | Override exporter target (default: `https://ingest.signoz.cloud:443`) |

## Architecture

```
All services (Python/Node.js)
        |
        | OTLP (HTTP/gRPC) port 4318
        v
  [OTel Collector]  ← 1 Runflare node
        |
        | OTLP (gRPC, compressed)
        v
  SigNoz Cloud (or custom backend)
```

## Service env vars to add

Every service needs these in Runflare:

```
OTEL_ENABLED=true
OTEL_EXPORTER_OTLP_ENDPOINT=http://pumo-otel-collector:4318
OTEL_SERVICE_NAME=<service-name>
OTEL_SERVICE_NAMESPACE=pumo
```