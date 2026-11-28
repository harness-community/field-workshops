---
slug: build-with-the-agent
id: pwkumkrhuxn1
type: challenge
title: "\U0001F3D7️ ラボ 2: エージェントでビルドする"
teaser: エージェントに CI パイプラインを作成させ、最初のビルドが失敗した理由を AI に説明させます
tabs:
- id: 5tb8rywjnyf5
  title: Harness
  type: browser
  hostname: harness
- id: toxqrpcjcyyb
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: 3j8drarl2epc
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: basic
timelimit: 1500
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ラボ 2: エージェントでビルドする</h2>
<hr class="cyan">
<br>

変更はマージされましたが、まだそれをリリースする仕組みがありません。このラボでは、パイプラインエディターをクリックして操作することはしません。**Software Delivery Agent** に普段の言葉でパイプラインを依頼し、提案内容を確認して受け入れます。

このパイプラインは次の処理を行います。
1. アプリのユニットテストを実行する
2. コンテナイメージをビルドする
3. イメージを **あなた専用の Harness Artifact Registry** にプッシュする（セットアップ済みです）

エージェントに CI パイプラインを依頼する
===

1) Harness 画面の右下にある **Ask AI** ボタンをクリックします
2) 次のプロンプトをチャットにコピーします。名前は書かれているとおりに入力してください。後のラボでこれらの名前を参照します。

```
"showcase" という名前で、識別子が showcase のパイプラインを作成してください。コードベースは Harness Code の sda-showcase リポジトリで、main ブランチをビルドします。

Harness Cloud（Linux、AMD64）で実行される "Build" という名前の CI ステージを追加し、次の 2 つのステップを含めてください。
1. "Unit tests" という名前の Run ステップ。イメージ golang:1.27-alpine を使用し、go test ./... を実行します。
2. "Build and push to HAR" という名前の "Build and Push to Docker Registry" ステップ。コネクター "har"、リポジトリ <+variable.image_repo>、タグ <+pipeline.sequenceId> を使用します。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Create a pipeline named "showcase" with the identifier showcase. Its codebase is the sda-showcase repository in Harness Code, building the main branch.

Add a CI stage named "Build" that runs on Harness Cloud (Linux, AMD64) with two steps:
1. A Run step named "Unit tests" that uses the image golang:1.27-alpine and runs: go test ./...
2. A "Build and Push to Docker Registry" step named "Build and push to HAR" that uses the connector "har", the repository <+variable.image_repo>, and the tag <+pipeline.sequenceId>.
```
</details>

3) 提案内容を確認します。エージェントは何かを作成する前に、まずパイプラインの内容を提示します
4) 提案を受け入れ、**Pipelines** → **showcase** からパイプラインを開きます

> [!NOTE]
> `<+variable.image_repo>` はレジストリを指すプロジェクト変数で、`<+pipeline.sequenceId>` は実行番号です。ビルドごとに固有のイメージタグが付きます。

> [!IMPORTANT]
> エージェントが異なる名前を付けたり、ステップを省略したりした場合は、同僚に頼むときと同じように、修正してほしい点を伝えてください。例: *パイプラインの名前を showcase に変更してください。*

実行して、失敗を確認する
===

1) **Run** をクリックし、**Run Pipeline** を選択します
2) **Unit tests** ステップが失敗します。これは意図的なものです。皆さんが来る前から、コードにバグが潜んでいました

バグを見つける
===

> [!IMPORTANT]
> バグは `internal/market/market.go` にあります。変更が必要なのはこのファイルだけです。

1) 失敗した **Unit tests** ステップをクリックし、テスト出力を読みます。どのテストが失敗したか、何が期待され、実際には何が返されたかを確認してください
2) **Analyze Error** をクリックして、別の視点からの意見を得ます。AI がログとコードを読み取ります
3) `internal/market/market.go` を開き、失敗の原因となっている行を見つけます

<details>
<summary>わからない場合はクリックして答えを表示</summary>

テストでは、`USDJPY` のような円の通貨ペアが小数点以下 2 桁で表示されることを期待しています。`internal/market/market.go` の 33 行目では、シンボルが `JPY` で **始まる** かどうかをチェックしています。円の通貨ペアは `JPY` で **終わる** ため、正しいチェックは `strings.HasSuffix(s, "JPY")` です。
</details>

バグを修正して成功させる
===

1) **Code Repository** → **sda-showcase** → `internal/market/market.go` に移動し、**Edit** をクリックします
2) バグを修正します
3) **Commit changes** をクリックし、`main` に直接コミットします
4) **showcase** パイプラインをもう一度実行します。テストが成功し、イメージがビルドされて、レジストリにプッシュされます
5) 左側のナビゲーションで **Artifact Registries** を開き、実行番号のタグが付いた `sda-showcase` イメージを見つけます

> [!NOTE]
> **ここで起きたこと:** エージェントがパイプラインを作成し、AI が失敗の診断を手伝いました。どちらも皆さんが確認し、その都度判断を下したのは皆さん自身です。

<!-- yaml-backup:start -->
<details>
<summary>エージェントでうまくいかない場合: バックアップのパイプライン YAML を使用</summary>

何度か試してもエージェントがパイプラインを正しく作成できない場合は、代わりに次の YAML を貼り付けてください。**showcase** パイプラインがまだない場合は、**Pipelines** → **Create a Pipeline** をクリックし、名前を `showcase` にして **Start** をクリックします。次に、上部で **Visual** から **YAML** に切り替え、内容をすべて下の YAML に置き換えて **Save** をクリックします。その後、中断したところからラボを再開してください。

```yaml
pipeline:
  name: showcase
  identifier: showcase
  orgIdentifier: [[ Instruqt-Var key="HARNESS_ORG_ID" hostname="sandbox" ]]
  projectIdentifier: [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]
  # Every delegate task runs on the student's own delegate (Harness Cloud CI ignores this).
  delegateSelectors:
    - [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-delegate
  tags: {}
  properties:
    ci:
      codebase:
        repoName: sda-showcase
        build:
          type: branch
          spec:
            branch: main
  stages:
    - stage:
        name: Build
        identifier: Build
        type: CI
        spec:
          cloneCodebase: true
          platform:
            os: Linux
            arch: Amd64
          runtime:
            type: Cloud
            spec: {}
          execution:
            steps:
              - step:
                  type: Run
                  name: Unit tests
                  identifier: Unit_tests
                  spec:
                    shell: Sh
                    image: golang:1.27-alpine
                    command: go test ./...
              - step:
                  type: BuildAndPushDockerRegistry
                  name: Build and push to HAR
                  identifier: Build_and_push_to_HAR
                  spec:
                    connectorRef: har
                    repo: <+variable.image_repo>
                    tags:
                      - <+pipeline.sequenceId>
```
</details>
<!-- yaml-backup:end -->

パイプラインの実行が成功したら、**Check** をクリックします。
