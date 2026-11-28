---
slug: brand-your-app
id: npc9z9wtd38f
type: challenge
title: "\U0001F3A8 ラボ 1: アプリのブランディング"
teaser: アプリを自分仕様に変更し、AI が書いたサマリー付きのプルリクエストでリリースします
tabs:
- id: xj7hizbtgyog
  title: Harness
  type: browser
  hostname: harness
- id: 6ewmonvagfuo
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: nxihxpekumvt
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 720
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ラボ 1: アプリのブランディング</h2>
<hr class="cyan">
<br>

アプリ **sda-showcase** は、**Harness Code** の Git リポジトリにあります。アプリには 2 つのタイプがあります。

| タイプ | 内容 |
|---|---|
| `ticker` | トレーディングフロア向けのボード。FX と暗号資産のリアルタイム相場、各拠点の時計、流れるティッカーテープを表示します |
| `billboard` | チームのメッセージを流す LED 電光掲示板 |

変更できる項目はすべて `showcase.yaml` という 1 つのファイルにまとまっています。このラボでは、実際のチームと同じように、ブランチを切ってプルリクエスト経由で変更します。

showcase.yaml を編集する
===

1) 左側のナビゲーションで **Code Repository** をクリックし、**sda-showcase** を選択します
2) `showcase.yaml` をクリックし、**Edit** をクリックします
3) 自分仕様に変更します。少なくとも `name` は変更してください。例えば次のような変更ができます。
   - `flavor: billboard` にして、チーム向けの `message` を設定する
   - 自分のデスクで扱う `symbols`（最大 8 個）
   - 新しい `accent` カラー（`"#D7282F"` のように引用符で囲む）
   - `emoji` を名前で指定する: `fire`、`tada`、`unicorn`、`chart`、`trophy` など。エディターでは絵文字を入力できないため、アプリが名前を絵文字に変換します
4) `version` を `1.1.0` に上げます

> [!IMPORTANT]
> `accent` カラーの引用符は消さないでください。YAML では、引用符で囲まれていない `#` 以降はコメントとして扱われます。

> [!NOTE]
> `name` や `message` には日本語も使えます。**Harness** タブで日本語を入力できない場合は、**Harness（新しいウィンドウ）** タブから編集してください。

プルリクエストを作成する
===

1) **Commit changes** をクリックします
2) **Create a new branch and start a pull request** を選択し、ブランチ名を `brand-my-app` にします
3) プルリクエストのフォームで、説明欄の **AI** ボタンをクリックすると、AI がサマリーを書きます。内容を確認し、必要に応じて編集してください
4) **Create pull request** をクリックします
5) **Squash and merge** をクリックし、**Confirm** をクリックします

> [!NOTE]
> **AI サマリーが役立つ理由:** 誰も説明を書かなかった変更も含め、すべての変更について、レビュー担当者がわかりやすい説明を受け取れます。今日のワークショップでエージェントが最初に登場するのがここです。この先もパターンは同じで、エージェントが下書きし、あなたがレビューして判断します。

プルリクエストがマージされたら **Check** をクリックします。
