#!/bin/bash
# PreToolUse hook: 破壊的コマンドをブロック
# 友人事例（Claude Code によるデータ消失）の再発防止

INPUT=$(cat)

# Bash ツール以外はスキップ
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""')
if [[ "$TOOL_NAME" != "Bash" ]]; then
  echo "$INPUT"
  exit 0
fi

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# 破壊的パターン一覧
BLOCKED=0
REASON=""

# rm 系（-rf, -fr, 単体 rm）
if echo "$CMD" | grep -qE '\brm\b'; then
  BLOCKED=1; REASON="rm コマンド（ファイル削除）"
fi

# unlink / rmdir
if echo "$CMD" | grep -qE '\b(unlink|rmdir)\b'; then
  BLOCKED=1; REASON="${REASON:+$REASON / }unlink または rmdir"
fi

# find -delete / find -exec rm
if echo "$CMD" | grep -qE 'find[[:space:]].*(-delete|-exec[[:space:]]+rm)'; then
  BLOCKED=1; REASON="${REASON:+$REASON / }find による一括削除"
fi

# git 破壊的操作
if echo "$CMD" | grep -qE 'git[[:space:]]+(clean[[:space:]]+-[a-zA-Z]*f|reset[[:space:]]+--hard|checkout[[:space:]]+--[[:space:]])'; then
  BLOCKED=1; REASON="${REASON:+$REASON / }git 破壊的操作（clean -f / reset --hard / checkout --）"
fi

# ファイル内容の破壊
if echo "$CMD" | grep -qE '\b(truncate|shred)\b'; then
  BLOCKED=1; REASON="${REASON:+$REASON / }truncate または shred"
fi

if [[ "$BLOCKED" -eq 1 ]]; then
  echo "" >&2
  echo "🚨 [danger-check] 破壊的コマンドをブロックしました" >&2
  echo "   検出: $REASON" >&2
  echo "   コマンド: $CMD" >&2
  echo "" >&2
  echo "対象ファイル・パスをユーザーに明示し、削除の許可を得てから再実行してください。" >&2
  echo "ファイル移動の場合は「cp → 移動先確認 → rm」の手順で行い、各ステップを報告してください。" >&2
  exit 2
fi

echo "$INPUT"
