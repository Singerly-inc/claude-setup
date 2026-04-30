# Singerly Claude Code Setup

Singerly株式会社のメンバー向け Claude Code 共通設定パッケージ。

## インストール

```bash
git clone https://github.com/Singerly-inc/claude-setup.git
cd claude-setup
bash install.sh
```

## 含まれるもの

| カテゴリ | 内容 |
|---|---|
| `hooks/` | セキュリティ・安全性フック（破壊的操作ブロック・シークレット検出・通知） |
| `rules/` | 業務別ルール（コンサル・コンテンツ・オペレーション） |
| `prompts/` | 共通プロンプト集（SNS投稿・note記事生成・組織トレンド分析） |
| `CLAUDE.md.template` | 個人設定テンプレート |
| `settings_template.json` | セキュリティ設定テンプレート（29種の deny ルール + hooks 設定） |

## インストール後の個人設定

1. `~/.claude/CLAUDE.md` を開いて自分の名前・X・noteを記入
2. `~/.claude/settings.json` の `env` セクションにAPIキーを追加
3. Claude Code を再起動

## 更新

毎月1日に奥田のMacから自動更新されます。手動で最新版を取得する場合：

```bash
cd claude-setup
git pull
bash install.sh
```
