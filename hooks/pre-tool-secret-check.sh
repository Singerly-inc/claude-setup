#!/bin/bash
# PreToolUse hook: シークレット検出
# Writeツール使用前にAPIキー等が含まれていないか確認

INPUT=$(cat)

# チェック対象パターン（OpenAI/Slack/GitHub/Google/AWS/汎用パスワード）
if echo "$INPUT" | grep -qiE '(sk-[a-zA-Z0-9]{20,}|xoxb-[a-zA-Z0-9-]+|ghp_[a-zA-Z0-9]+|AIza[a-zA-Z0-9_-]{35}|AKIA[A-Z0-9]{16})'; then
  echo "WARNING: APIキーらしき文字列が含まれています。書き込みを確認してください。" >&2
  exit 2
fi

echo "$INPUT"
