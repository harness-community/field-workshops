---
slug: ship-safely
id: svayvtl9scbr
type: challenge
title: "\U0001F6E1️ ラボ 4: 安全にリリースする"
teaser: ヘルスチェック付きのカナリアデプロイに切り替えたあと、不良なリリースを出して自動でロールバックされる様子を確認します
tabs:
- id: 1taaouewswvt
  title: Harness
  type: browser
  hostname: harness
- id: egyv0wcllsbw
  title: あなたのアプリ
  type: service
  hostname: sandbox
  port: 30080
- id: ixlyuhxwn5r8
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: xsbccm3soymz
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: intermediate
timelimit: 1200
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ラボ 4: 安全にリリースする</h2>
<hr class="cyan">
<br>

**アウターループへようこそ**。ラボ 1〜3 では、コードをビルドして動かすところまで進めました。ここまでは多くのデリバリーツールでも実現できます。アウターループとは、コードが開発者の手を離れたあとに起こるすべてのこと、つまり安全にリリースし、不良なリリースを検知し、すべての変更でルールを守ることです。ここにこそ Harness の強みがあり、このワークショップの残りのテーマでもあります。

ローリングデプロイでは、正常かどうかに関係なくすべての Pod が置き換えられます。**カナリアデプロイ** では、まず 1 つの Pod で新しいバージョンを試してヘルスチェックを行い、問題がなければ全体にロールアウトします。チェックが失敗すると Harness が自動でロールバックするので、オンコール担当者が呼び出されることもありません。

カナリアデプロイを依頼する
===

1) **Ask AI** をクリックし、**new chat** を開始します
2) 次のプロンプトをコピーします。

```
showcase パイプラインの Deploy ステージを、次のステップをこの順序で実行するカナリアデプロイに変更してください。
1. "Canary deploy" という名前の Canary Deployment ステップ（インスタンス数 1）
2. "Canary health check" という名前の Shell Script ステップ（タイムアウト 3 分、下記のスクリプトを使用）
3. "Canary delete" という名前の Canary Delete ステップ
4. "Rolling deploy" という名前の Rolling Deployment ステップ
5. "Health check" という名前の Shell Script ステップ（タイムアウト 3 分、同じスクリプトを使用）

ロールバックステップ：Canary Delete ステップ、続いて Rolling Rollback ステップ。いずれかのステップが失敗した場合は、ステージをロールバックしてください。

スクリプト：
url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
echo "Checking $url from $(hostname)"
for i in $(seq 1 20); do
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url")
  echo "check $i: HTTP $code"
  [ "$code" = "200" ] || { echo "Unhealthy release"; exit 1; }
  sleep 1
done
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
In the showcase pipeline, change the Deploy stage to a canary deployment with these steps, in order:
1. A Canary Deployment step named "Canary deploy" with 1 instance
2. A Shell Script step named "Canary health check" with a 3 minute timeout, using the script below
3. A Canary Delete step named "Canary delete"
4. A Rolling Deployment step named "Rolling deploy"
5. A Shell Script step named "Health check" with a 3 minute timeout, using the same script

Rollback steps: a Canary Delete step, then a Rolling Rollback step. If any step fails, roll back the stage.

The script:
url="http://showcase.<+infra.namespace>.svc.cluster.local/health"
echo "Checking $url from $(hostname)"
for i in $(seq 1 20); do
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url")
  echo "check $i: HTTP $code"
  [ "$code" = "200" ] || { echo "Unhealthy release"; exit 1; }
  sleep 1
done
```
</details>

3) 提案を確認して受け入れます。**Deploy** ステージの **Execution** タブを開き、各ステップと **Rollback** 側の内容を確認します

> [!NOTE]
> ヘルスチェックは、Kubernetes Service 経由でアプリの `/health` エンドポイントに 20 回アクセスします。4 つの Pod のうちカナリアは 1 つなので、不良なカナリアはほぼ確実に検知されます。

正常なリリースを出す
===

1) **Code Repository** → **sda-showcase** で `showcase.yaml` を編集します。`message` または `tagline` を変更し、`version` を上げます（例: `1.1.0` → `1.2.0`）。`main` に直接コミットします
2) **showcase** パイプラインを実行します
3) **Canary deploy** の実行中に **あなたのアプリ** タブを確認します。新しいバージョンの Pod が画面下部のストリップに表示されます。その後ローリングデプロイに引き継がれ、ページに新しいリリースが表示されます

不良なリリースを出す
===

次に、起動は正常でもトラフィックを処理できないリリースを、誰かが出してしまったと想定します。

1) `showcase.yaml` をもう一度編集します。`version` を `1.3.0` に上げ、次のように設定します。
   ```
   release:
     healthy: false
   ```
2) `main` にコミットし、パイプラインを実行します
3) **Canary health check** が失敗し、ステージが **ロールバック** される様子を確認します。不良なバージョンが動いたのはカナリアだけです。アプリはその間ずっと 1.2.0 のままです。**あなたのアプリ** タブで確認してください
4) 失敗した **Canary health check** ステップをクリックし、**Analyze Error** をクリックします。AI は何が起きたと説明しているでしょうか？

> [!NOTE]
> **これこそ、多くのスクリプトベースのデプロイにはできないことです**：不良なリリースを数秒で検知し、すべての Pod に届く前に、人手を介さずに元に戻します。

修正する
===

`healthy: true` を設定し、`version` を `1.3.1` に上げてコミットし、パイプラインを実行します。今回はカナリアがチェックに合格し、1.3.1 がロールアウトされます。

<!-- yaml-backup:start -->
<details>
<summary>エージェントでうまくいかない場合: バックアップのパイプライン YAML を使用</summary>

何度か試してもエージェントがカナリアデプロイを正しく構成できない場合は、**Pipelines** → **showcase** を開き、上部で **Visual** から **YAML** に切り替えます。読み取り専用になっている場合は **Edit YAML** をクリックし、内容をすべて下記の YAML に置き換えて **Save** をクリックします。その後、中断したところからラボを再開してください。

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
                  type: K8sCanaryDeploy
                  name: Canary deploy
                  identifier: Canary_deploy
                  timeout: 10m
                  spec:
                    instanceSelection:
                      type: Count
                      spec:
                        count: 1
                    skipDryRun: false
              - step:
                  type: ShellScript
                  name: Canary health check
                  identifier: Canary_health_check
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
              - step:
                  type: K8sCanaryDelete
                  name: Canary delete
                  identifier: Canary_delete
                  timeout: 10m
                  spec: {}
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
                  type: K8sCanaryDelete
                  name: Canary delete
                  identifier: Rollback_canary_delete
                  timeout: 10m
                  spec: {}
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

カナリアデプロイの成功した実行とロールバックをそれぞれ確認できたら、**Check** をクリックします。
