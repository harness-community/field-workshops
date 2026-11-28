---
slug: bonus
id: ac4cwxuy0dxh
type: challenge
title: "\U0001F381 ボーナス: さらに試してみる"
teaser: 構築したものについて、エージェントに説明、監査、拡張を依頼します
tabs:
- id: y1yaj37n89ko
  title: Harness
  type: browser
  hostname: harness
- id: 910q4z6sie1x
  title: あなたのアプリ
  type: service
  hostname: sandbox
  port: 30080
- id: qyj5xsupzevy
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: cwbuxm1st1c8
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ボーナス: さらに試してみる</h2>
<hr class="cyan">
<br>

パイプラインエディターを一度も開かずに、パイプラインを構築してリリースしました。さらにアウターループにも取り組みました。不良なリリースを検知し、人の介入なしにロールバックしたカナリアデプロイ。そして、誰が（あるいは何が）書いたかにかかわらず、すべての変更に同じルールを適用したポリシーです。

サンドボックスはタイマーが切れるまで自由に使えます。以下をいくつか試してみてください。

監査証跡を確認する
===

**Project Settings** → **Audit Trail** に移動します。今日エージェントが行ったすべての変更が記録されています。何が、いつ、誰の代理で変更されたのかがわかります。各変更は **あなた** によるものとして記録されています。変更を受け入れたのがあなただからです。

エージェントに説明させる
===

**Ask AI** で、次のように試してみてください:

```
showcase パイプラインの最新の実行で何が行われたかをステップごとに説明し、各ステージにかかった時間も教えてください。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Explain what the latest run of the showcase pipeline did, step by step, and how long each stage took.
```
</details>

```
showcase パイプラインで直近に失敗した実行は、なぜ失敗したのですか？また、不良なリリースがすべての Pod に届くのを防いだのは何ですか？
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Why did the most recent failed run of the showcase pipeline fail, and what stopped the bad release from reaching every pod?
```
</details>

エージェントに拡張させる
===

```
"har" コネクターを使用していない Build and Push ステップをすべて拒否する、パイプライン向けの OPA ポリシーを作成してください。まだポリシーセットには追加しないでください。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Write an OPA policy for pipelines that denies any Build and Push step that doesn't use the "har" connector. Don't add it to a policy set yet.
```
</details>

```
showcase パイプラインで、"Unit tests" の後に "Vet" という名前の Run ステップを追加してください。イメージには golang:1.27-alpine を使用し、次のコマンドを実行します: go vet ./...
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
In the showcase pipeline, add a Run step after "Unit tests" named "Vet" that uses golang:1.27-alpine and runs: go vet ./...
```
</details>

もう一度アプリをカスタマイズする
===

`showcase.yaml` の `flavor` を `ticker` と `billboard` の間で切り替え、バージョンを上げてリリースします。承認、カナリアデプロイ、ヘルスチェックはすべて、追加の作業なしでそのまま適用されます。

完了したら **Check** をクリックして、ワークショップを終了します。Harness でのビルドにご参加いただき、ありがとうございました！
