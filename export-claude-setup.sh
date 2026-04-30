#!/bin/bash
# 奥田のClaude Code設定をsingerly-claude-setupリポジトリにエクスポート（月次）
# cron: 毎月1日 09:00 に実行
# 使い方: bash export-claude-setup.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

echo "[$TIMESTAMP] export-claude-setup 開始"

# hooks エクスポート（singerly-tools-autopush.sh は個人設定なのでスキップ）
echo "--- hooks をエクスポート中..."
for hook in \
  pre-tool-danger-check.sh \
  pre-tool-secret-check.sh \
  stop-notify.sh \
  stop-session-log.sh \
  pre-compact-log.sh; do
  src="$CLAUDE_DIR/hooks/$hook"
  if [[ -f "$src" ]]; then
    cp "$src" "$REPO_DIR/hooks/$hook"
    echo "   → $hook"
  fi
done

# rules エクスポート（moodmaker.md はOkuda固有プロジェクトのためスキップ）
echo "--- rules をエクスポート中..."
for rule in consulting.md content.md ops.md; do
  src="$CLAUDE_DIR/rules/$rule"
  if [[ -f "$src" ]]; then
    cp "$src" "$REPO_DIR/rules/$rule"
    echo "   → $rule"
  fi
done

# git commit & push
cd "$REPO_DIR"
if git diff --quiet && git diff --cached --quiet; then
  echo "✅ 変更なし。pushをスキップします"
else
  git add -A
  git commit -m "chore: monthly export from okuda $(date '+%Y-%m')"
  git push origin main
  echo "✅ GitHub にプッシュしました"
fi

echo "[$TIMESTAMP] export-claude-setup 完了"
