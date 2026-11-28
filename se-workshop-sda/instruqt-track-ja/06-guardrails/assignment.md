---
slug: guardrails
id: coehrt2r8p6f
type: challenge
title: "\U0001F46E ラボ 5: ガードレール"
teaser: ポリシーによってデプロイがブロックされます。エージェントにパイプラインをポリシーに準拠させ、最後にリリースを自分で承認します
tabs:
- id: aieniuvsprcb
  title: Harness
  type: browser
  hostname: harness
- id: hfvcuxh0objp
  title: あなたのアプリ
  type: service
  hostname: sandbox
  port: 30080
- id: cntw8sirhzcq
  title: ラボ認証情報
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: qy1god0kkwfx
  title: Harness（新しいウィンドウ）
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
difficulty: intermediate
timelimit: 600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">ラボ 5: ガードレール</h2>
<hr class="cyan">
<br>

アウターループの最後の要素は **ガバナンス** です。つまり、すべての変更に例外なく毎回適用されるルールです。自律的にビルドとリリースを行うエージェントには、うまく言いくるめて回避することのできないガードレールが必要です。プラットフォームチームが、あなたのプロジェクトに対して「**すべてのデプロイには承認ステップが必要**」というポリシーを有効にしました。このポリシーは、人が書いたものかエージェントが書いたものかにかかわらず、すべてのパイプラインに適用されます。

ブロックされる
===

1) **showcase** パイプラインを実行します
2) どのステージも開始される前に失敗します。実行を開いて **policy evaluation** を確認してください。ポリシー `deploy_needs_approval` によって拒否されたことと、その理由が表示されています

ルールを確認する
===

1) **Project Settings** → **Policies** に移動し、**Deploys need an approval** を開きます
2) コードを読む必要はありません。先頭のコメントに、このポリシーの内容が平易な英語で書かれています。デプロイは、その前に人による承認がある場合にのみ許可されます

> [!NOTE]
> プラットフォームチームは、このようなルールを Rego（Open Policy Agent）で一度記述するだけです。Harness がルールを保存してバージョン管理し、実行のたびにすべてのパイプラインをこのルールに照らしてチェックします。

ポリシーに準拠させる
===

1) **Ask AI** をクリックし、**new chat** を開始します
2) 次のプロンプトをコピーします:

```
showcase パイプラインで、Deploy ステージの最初のステップとして "Approve release" という名前の Harness Approval ステップを追加してください。承認者はユーザーグループ All Project Users、最低承認数は 1 とし、パイプラインを実行したユーザー自身も承認できるようにしてください。タイムアウトは 1 時間にしてください。
```

<details>
<summary>英語のプロンプト（エージェントの応答がうまくいかない場合）</summary>

```
In the showcase pipeline, add a Harness Approval step named "Approve release" as the first step of the Deploy stage. The approvers are the user group All Project Users, with a minimum of 1 approval, and the person who ran the pipeline may approve. Time out after 1 hour.
```
</details>

3) 内容を確認して受け入れます

リリースを承認する
===

1) パイプラインを実行します。今回はポリシーのチェックを通過します
2) 実行が **Approve release** で一時停止したら、**Approve** をクリックします
3) 前回と同様にカナリアデプロイが展開されます。**あなたのアプリ** タブを確認してください

> [!NOTE]
> **自律的な SDLC を安全にするのは Policy as Code です**。エージェントはポリシーに準拠するようにパイプラインを書き換え、OPA はその変更を、他のすべての変更と同じ方法でチェックしました。ルールは、誰が（あるいは何が）書いたかにかかわらず、すべてのパイプラインに常に適用されます。

<!-- yaml-backup:start -->
<details>
<summary>エージェントでうまくいかない場合: バックアップのパイプライン YAML を使用</summary>

何度か試してもエージェントが承認ステップを追加できない場合は、**Pipelines** → **showcase** を開き、上部で **Visual** から **YAML** に切り替えます。読み取り専用になっている場合は **Edit YAML** をクリックし、内容をすべて下の YAML に置き換えて **Save** をクリックします。その後、中断したところからラボを再開してください。

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
                  type: HarnessApproval
                  name: Approve release
                  identifier: Approve_release
                  timeout: 1h
                  spec:
                    approvalMessage: Release <+pipeline.sequenceId> of showcase to dev. Approve?
                    includePipelineExecutionHistory: true
                    isAutoRejectEnabled: false
                    approvers:
                      userGroups:
                        - _project_all_users
                      minimumCount: 1
                      disallowPipelineExecutor: false
                    approverInputs: []
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

承認したリリースが稼働したら、**Check** をクリックします。
