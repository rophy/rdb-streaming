# rdb-streaming

A PoC for streaming architecture with fluentd as source and kafka as bus

## Getting started

```bash
docker compose up -d

# start to populate data
make add-data

# with another terminal
docker compose logs -f fluentd
```

