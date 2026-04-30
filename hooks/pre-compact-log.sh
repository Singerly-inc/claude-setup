#!/bin/bash
# Claude Code PreCompact hook: コンテキスト圧縮前にログ記録
INPUT=$(cat)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$HOME/work/ops/logs/claude_sessions.log"
mkdir -p "$(dirname "$LOG_FILE")"
echo "[$TIMESTAMP] [PreCompact] コンテキスト圧縮が発生しました。作業状態をメモリ等に保存してください。" >> "$LOG_FILE"
osascript -e 'display notification "コンテキスト圧縮が発生しました" with title "Claude Code ⚠️" sound name "Basso"' 2>/dev/null || true
echo "$INPUT"
