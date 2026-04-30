#!/bin/bash
# Claude Code Stop hook: macOS デスクトップ通知
INPUT=$(cat)
osascript -e 'display notification "作業完了しました" with title "Claude Code" sound name "Glass"' 2>/dev/null || true
echo "$INPUT"
