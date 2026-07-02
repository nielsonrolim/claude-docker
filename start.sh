#!/bin/bash
touch .env
echo '{}' > .claude.json
mkdir -p .claude
docker compose up -d
