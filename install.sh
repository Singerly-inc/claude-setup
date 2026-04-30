#!/bin/bash
# Singerly Claude Code セットアップインストーラー
# 使い方: bash install.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
RULES_DIR="$CLAUDE_DIR/rules"
PROMPTS_DIR="$HOME/work/ops/claude-prompts"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

echo ""
echo "=== Singerly Claude Code セットアップ ==="
echo ""

# macOS チェック
if [[ "$(uname)" != "Darwin" ]]; then
  echo "❌ このスクリプトは macOS 専用です"
  exit 1
fi

# jq チェック
if ! command -v jq &> /dev/null; then
  echo "❌ jq が見つかりません。先に brew install jq を実行してください"
  exit 1
fi

# ディレクトリ作成
mkdir -p "$HOOKS_DIR" "$RULES_DIR" "$PROMPTS_DIR"
echo "✅ ディレクトリ確認: $HOOKS_DIR, $RULES_DIR, $PROMPTS_DIR"

# hooks インストール
echo ""
echo "--- hooks をインストール中..."
for hook in "$REPO_DIR/hooks/"*.sh; do
  name="$(basename "$hook")"
  cp "$hook" "$HOOKS_DIR/$name"
  chmod +x "$HOOKS_DIR/$name"
  echo "   → $name"
done
echo "✅ hooks インストール完了"

# rules インストール
echo ""
echo "--- rules をインストール中..."
for rule in "$REPO_DIR/rules/"*.md; do
  name="$(basename "$rule")"
  cp "$rule" "$RULES_DIR/$name"
  echo "   → $name"
done
echo "✅ rules インストール完了"

# prompts インストール
echo ""
echo "--- prompts をインストール中..."
for prompt in "$REPO_DIR/prompts/"*; do
  name="$(basename "$prompt")"
  cp "$prompt" "$PROMPTS_DIR/$name"
  echo "   → $name"
done
echo "✅ prompts インストール完了"

# settings.json マージ
echo ""
echo "--- settings.json をマージ中..."
TEMPLATE="$REPO_DIR/settings_template.json"

if [[ ! -f "$SETTINGS_FILE" ]]; then
  # 既存設定なし → テンプレートをそのままコピー
  cp "$TEMPLATE" "$SETTINGS_FILE"
  echo "✅ settings.json を新規作成しました"
else
  # 既存設定あり → deny ルールと hooks をマージ
  BACKUP="$SETTINGS_FILE.backup.$(date +%Y%m%d%H%M%S)"
  cp "$SETTINGS_FILE" "$BACKUP"
  echo "   バックアップ: $BACKUP"

  # テンプレートの deny ルールを既存の deny に追記（重複除去）
  MERGED=$(jq -s '
    .[0] as $existing |
    .[1] as $template |
    $existing * {
      "permissions": {
        "deny": (
          (($existing.permissions.deny // []) + ($template.permissions.deny // []))
          | unique
        )
      },
      "hooks": ($template.hooks)
    }
  ' "$SETTINGS_FILE" "$TEMPLATE")

  echo "$MERGED" > "$SETTINGS_FILE"
  echo "✅ settings.json をマージしました（既存設定を保持）"
fi

# CLAUDE.md セットアップ
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
echo ""
echo "--- CLAUDE.md の設定..."
if [[ -f "$CLAUDE_MD" ]]; then
  echo "⚠️  $CLAUDE_MD は既に存在します。上書きしません。"
  echo "   テンプレートは $REPO_DIR/CLAUDE.md.template を参照してください"
else
  cp "$REPO_DIR/CLAUDE.md.template" "$CLAUDE_MD"
  echo "✅ $CLAUDE_MD を作成しました"
  echo ""
  echo "次のステップ："
  echo "  1. $CLAUDE_MD を開いて【Identity】セクションに自分の名前・SNSを記入してください"
  echo "  2. APIキー等は ~/.claude/settings.json の env セクションに追加してください"
fi

echo ""
echo "======================================"
echo "✅ Singerly Claude Code セットアップ完了"
echo "======================================"
echo ""
echo "Claude Code を再起動すると設定が反映されます。"
