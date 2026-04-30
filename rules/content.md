---
name: コンテンツ制作
description: X・note・YouTube等のコンテンツ制作ルール
paths:
  - work/content/**
  - work/ops/claude-prompts/**
  - work/ops/logs/**
---

# コンテンツ制作ルール

## 奥田真広の文体・発信スタイル
- アニメ・スポーツ・映画キャラの引用を必ず1つ入れる（ワンピース、スラムダンク、鬼滅、ハイキュー、進撃、カイジ等）
- 数字・データは箇条書き羅列せず、文章の流れに自然に織り込む
- 「はたらいて泣こう」コンセプトを軸に
- エンゲージメント2倍・採用効率20倍の具体エピソードを優先

## 媒体別ルール

### X（@SingerlyCEO）
- X Premiumのため最大25,000文字投稿可
- 組織マネジメントナレッジ軸のシリーズ投稿を優先
- 分析ログ: `~/work/ops/logs/sns_improvement_packet.yaml`

### note
- Xトレンド起点で下書き生成
- 保存先: `~/work/content/note/`

### YouTube
- 20代ビジネスマン向け
- 組織行動×国際ニュース軸
- 保存先: `~/work/content/youtube/`

## テーマ重複チェック
- 直近3ヶ月に扱ったテーマは再掲しない
- チェック先: `~/work/ops/logs/digest_topic_log.md`
