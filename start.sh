#!/bin/bash
touch .env
touch .claude.json
mkdir -p .claude
docker compose up -d
