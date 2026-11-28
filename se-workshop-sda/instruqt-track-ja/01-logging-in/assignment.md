---
slug: logging-in
id: x2ifzi2eh7em
type: challenge
title: "\U0001F44B ようこそ: ログイン"
teaser: 自分専用の Harness プロジェクトにログインします
notes:
- type: text
  contents: "<div style=\"max-width: min(92%, 960px); margin: 3vh auto; text-align:
    left; line-height: 1.5;\">\n  <div style=\"display: flex; align-items: center;
    gap: 10px; font-weight: 700; font-size: 1.2em;\">\n    <img src=\"https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/modules/harness.png\"
    width=\"35\"> harness\n  </div>\n  <h1 style=\"font-size: clamp(1.4em, 3.2vw,
    1.8em); line-height: 1.15; margin: .3em 0 .6em;\">Software Delivery Agent ワークショップ</h1>\n
    \ <p style=\"margin: 0 0 .4em;\">これからの 2 時間で、次のことを体験します。</p>\n  <ul style=\"list-style:
    none; padding: 0; margin: 0 0 1em; line-height: 1.7;\">\n    <li>\U0001F3A8 アプリをブランディングし、プルリクエストでリリース</li>\n
    \   <li>\U0001F916 エージェントに CI を構築させ、失敗したビルドを AI で修正</li>\n    <li>\U0001F680 エージェントにアプリを
    Kubernetes へデプロイさせる</li>\n    <li>\U0001F424 リリースをカナリアデプロイし、問題のあるリリースのロールバックを確認</li>\n
    \   <li>\U0001F6E1️ ポリシーに引っかかったパイプラインを、エージェントに修正させる</li>\n  </ul>\n  <p><strong>サンドボックスの準備には数分かかります。しばらくお待ちください。</strong></p>\n</div>"
tabs:
- id: w3q3f4lygx0j
  title: Harness
  type: browser
  hostname: harness
- id: axsjcvpea7kx
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: ezf7zvagrzze
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 300
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ようこそ</h2>
<hr class="cyan">
<br>

あなた専用の Harness プロジェクトを用意しました。アプリが入った Git リポジトリ、アーティファクトレジストリ、専用の Kubernetes クラスターが含まれています。次の認証情報でログインしてください。

| | |
| ----- | ----- |
| **ユーザー名** |<pre>`[[ Instruqt-Var key="HARNESS_USER" hostname="sandbox" ]]`</pre>|
| **パスワード** |<pre>`[[ Instruqt-Var key="HARNESS_PWD" hostname="sandbox" ]]`</pre>|

> [!NOTE]
> 認証情報はいつでも [button label="ラボ認証情報" variant="success"](tab-1) タブで確認できます。
> 埋め込みブラウザの動作がおかしい場合は、[button label="Harness（新しいウィンドウ）" variant="success"](tab-2) を開いてください。
> 「not authorized」と表示される場合は、すでに別のユーザーで Harness にサインインしています。リンクをシークレットウィンドウ（プライベートウィンドウ）に貼り付けて、そこでサインインしてください。

> [!IMPORTANT]
> **日本語の入力について:** **Harness** タブは、ブラウザ画面をリモートから表示する仕組みです。そのため、日本語入力（IME）が使えない場合があります。日本語を入力したいときは、[button label="Harness（新しいウィンドウ）" variant="success"](tab-2) から通常のブラウザで操作してください。

サインイン
===

1) **Harness** タブで **Single sign-on** をクリックし、上記の認証情報でログインします \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/sso_login.png)
2) **Select a Project** をクリックし、`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]` を選択します \
   ![](https://raw.githubusercontent.com/harness-community/field-workshops/harness-se/assets/images/platform_project_selection.png)

**Check** をクリックして次に進みます。
