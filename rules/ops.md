---
name: オペレーション・自動化
description: Claude Codeプロンプト・GAS・自動化ツールの運用ルール
paths:
  - work/ops/**
---

# オペレーション・自動化ルール

## ディレクトリ構成
- `~/work/ops/claude-prompts/` — Claude Code実行プロンプト
- `~/work/ops/logs/` — 実行ログ・改善パケット
- `~/work/ops/gas/` — GAS（claspプロジェクト）

## プロンプト管理ルール
- 新しいプロンプトは `~/work/ops/claude-prompts/` に追加
- 用途が明確なファイル名をつける（例: `digest_prompt.md`）
- 古くなったプロンプトは削除せずアーカイブフォルダへ

## GAS（Google Apps Script）ルール
- claspでバージョン管理: `~/work/ops/gas/{プロジェクト名}/`
- `clasp push` でデプロイ前に必ずローカルテスト
- 認証情報は `.gitignore` に必ず追加

## ログ更新ルール
- ダイジェスト実行後: `digest_topic_log.md` にテーマを追記
- SNS分析後: `sns_improvement_packet.yaml` を更新
