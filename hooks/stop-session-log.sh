#!/bin/bash
INPUT=$(cat)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="${HOME}/work/ops/logs/claude_sessions.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[${TIMESTAMP}] response_complete" >> "$LOG_FILE"
echo "${INPUT}"
