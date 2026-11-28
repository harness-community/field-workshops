---
slug: deploy-with-the-agent
id: jdr2sy5f4s9k
type: challenge
title: "\U0001F680 ラボ 3: エージェントでデプロイする"
teaser: エージェントにサービス、環境、クラスターをモデル化させ、アプリをデプロイして稼働させます
tabs:
- id: frjpesonoidi
  title: Harness
  type: browser
  hostname: harness
- id: 1r1g2uefck7q
  title: あなたのアプリ
  type: service
  hostname: sandbox
  port: 30080
- id: uxywceyjy6mu
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: apdfujfh3vlg
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
</style><h2 class="cyan">ラボ 3: エージェントでデプロイする</h2>
<hr class="cyan">
<br>

イメージはレジストリに格納されました。次は、それを Kubernetes にリリースします。Harness ではデプロイを 3 つの構成要素でモデル化します。エージェントがそのすべてを作成します。

| 構成要素 | 何を表すか | このラボでの識別子 |
|---|---|---|
| **Service**（サービス） | *何を* デプロイするか。マニフェストとイメージ | `showcase` |
| **Environment**（環境） | 論理的に *どこへ* デプロイするか | `dev` |
| **Infrastructure**（インフラストラクチャ） | 物理的に *どこへ* デプロイするか。クラスターとネームスペース | `k8s_dev` |

Kubernetes クラスターのコネクター `workshop_k8s` はセットアップ済みです。

環境とインフラストラクチャを依頼する
===

1) **Ask AI** をクリックし、**new chat** を開始します
2) 次のプロンプトをコピーします。

```
"dev" という名前で、識別子が dev の PreProduction 環境を作成してください。

その環境に、"k8s_dev" という名前で、識別子が k8s_dev の Kubernetes インフラストラクチャ定義を作成してください。Kubernetes コネクター "workshop_k8s"、ネームスペース <+project.identifier>、リリース名 release-<+INFRA_KEY_SHORT_ID> を使用します。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Create a PreProduction environment named "dev" with the identifier dev.

In that environment, create a Kubernetes infrastructure definition named "k8s_dev" with the identifier k8s_dev. It uses the Kubernetes connector "workshop_k8s", the namespace <+project.identifier>, and the release name release-<+INFRA_KEY_SHORT_ID>.
```
</details>

3) 提案内容を確認して受け入れます

サービスを依頼する
===

次のプロンプトを同じチャットにコピーします。

```
"showcase" という名前で、識別子が showcase の Kubernetes サービスを作成してください。

マニフェスト: "showcase" という名前の K8sManifest。Harness Code リポジトリ sda-showcase の main ブランチに格納されており、マニフェストフォルダーは deploy/manifests、values ファイルは deploy/values.yaml です。

プライマリアーティファクト: "showcase" という名前の Docker Registry アーティファクト。コネクター "har"、イメージパス [[ Instruqt-Var key="IMAGE_PATH" hostname="sandbox" ]]、タグ <+pipeline.sequenceId> を使用します。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
Create a Kubernetes service named "showcase" with the identifier showcase.

Manifests: a K8sManifest named "showcase" stored in the Harness Code repository sda-showcase, branch main, with the manifest folder deploy/manifests and the values file deploy/values.yaml.

Primary artifact: a Docker Registry artifact named "showcase" using the connector "har", the image path [[ Instruqt-Var key="IMAGE_PATH" hostname="sandbox" ]], and the tag <+pipeline.sequenceId>.
```
</details>

提案内容を確認して受け入れます。

> [!NOTE]
> マニフェストはコードと同じ **あなたのリポジトリ内** の `deploy/` にあります。`deploy/values.yaml` を見てみましょう。イメージとプルシークレットは `<+artifacts.primary...>` から取得されるため、Harness はこの実行でビルドされたイメージをそのまま埋め込みます。

デプロイステージを追加する
===

次のプロンプトをコピーします。

```
showcase パイプラインで、Build ステージの後に "Deploy" という名前の Deployment ステージを追加してください。このステージは、サービス showcase を環境 dev とインフラストラクチャ k8s_dev に、ローリングデプロイ（Rolling）でデプロイします。ステージが失敗した場合は、ロールバックしてください。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
In the showcase pipeline, add a Deployment stage named "Deploy" after the Build stage. It deploys the service showcase to the environment dev and the infrastructure k8s_dev, using a Rolling deployment. If the stage fails, roll it back.
```
</details>

1) 提案内容を確認して受け入れ、**showcase** パイプラインを開きます。ステージが **Build** → **Deploy** の 2 つになっています
2) **Run** をクリックし、**Run Pipeline** を選択します
3) **Deploy** ステージを確認します。Harness がマニフェストを取得してイメージを埋め込み、3 つの Pod をロールアウトします

動作を確認する
===

**あなたのアプリ** タブを開きます。ラボ 1 で設定したブランディングが、ラボ 2 でビルドされ、今 Kubernetes 上で動いています。ページが空白の場合は、数秒待ってからタブの更新アイコンをクリックしてください。

> [!NOTE]
> ページ下部の帯に注目してください。どの Pod が応答しているか、各 Pod がどのバージョンを実行しているかが表示されます。次のラボで使うので覚えておいてください。

<!-- yaml-backup:start -->
<details>
<summary>エージェントでうまくいかない場合: バックアップのパイプライン YAML を使用</summary>

何度か試してもエージェントが Deploy ステージを正しく作成できない場合は、**Pipelines** → **showcase** を開き、上部で **Visual** から **YAML** に切り替えます。読み取り専用になっている場合は **Edit YAML** をクリックし、内容をすべて下の YAML に置き換えて **Save** をクリックします。その後、中断したところからラボを再開してください。この YAML には、最初の 2 つのプロンプトで作成する `showcase` サービス、`dev` 環境、`k8s_dev` インフラストラクチャが必要です。エージェントがこれらを作成できなかった場合は、代わりに **Skip** をクリックしてください。

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
    - stage:
        name: Deploy
        identifier: Deploy
        type: Deployment
        spec:
          deploymentType: Kubernetes
          service:
            serviceRef: showcase
          environment:
            environmentRef: dev
            deployToAll: false
            infrastructureDefinitions:
              - identifier: k8s_dev
          execution:
            steps:
              - step:
                  type: K8sRollingDeploy
                  name: Rolling deploy
                  identifier: Rolling_deploy
                  timeout: 10m
                  spec:
                    skipDryRun: false
                    pruningEnabled: false
              - step:
                  type: ShellScript
                  name: Health check
                  identifier: Health_check
                  timeout: 3m
                  spec:
                    shell: Bash
                    onDelegate: true
                    # Pin the student's own delegate. Without a selector Harness may pick any
                    # delegate in the account, and cluster DNS only resolves on this cluster.
                    delegateSelectors:
                      - [[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]-delegate
                    source:
                      type: Inline
                      spec:
                        script: |-
                          # Every pod answers through the Service, the canary included. Any
                          # unhealthy answer fails the step and the stage rolls back.
                          url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
                          echo "Checking $url from $(hostname)"
                          for i in $(seq 1 20); do
                            code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            # 000 means no connection yet (endpoints still settling): retry briefly
                            tries=0
                            while [ "$code" = "000" ] && [ $tries -lt 5 ]; do
                              sleep 2; tries=$((tries + 1))
                              code=$(curl -s -o /tmp/health -w '%{http_code}' --max-time 3 "$url")
                            done
                            echo "check $i: HTTP $code $(cat /tmp/health 2>/dev/null)"
                            if [ "$code" != "200" ]; then
                              echo "Unhealthy release: rolling back"
                              exit 1
                            fi
                            sleep 1
                          done
                          echo "20 of 20 health checks passed"
                    environmentVariables: []
                    outputVariables: []
            rollbackSteps:
              - step:
                  type: K8sRollingRollback
                  name: Rolling rollback
                  identifier: Rolling_rollback
                  timeout: 10m
                  spec:
                    pruningEnabled: false
        failureStrategies:
          - onFailure:
              errors:
                - AllErrors
              action:
                type: StageRollback
```
</details>
<!-- yaml-backup:end -->

アプリが稼働したら、**Check** をクリックします。
