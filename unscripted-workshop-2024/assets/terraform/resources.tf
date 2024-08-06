// Define the resources to create
// Provisions the following into Harness: 
//    Code Repo, Connectors (K8s and Prometheus), 
//    Infrastructure, Service, Monitored Service,
//    Project Variables, Templates (OWASP, Fortify, Compile)

// Repo
resource "harness_platform_repo" "repo" {
  identifier     = var.new_repo_id
  org_id         = var.org_id
  project_id     = var.project_id
  default_branch = "main"
  source {
    repo = var.github_repo_to_clone
    type = "github"
  }
}

// K8s Connector
resource "harness_platform_connector_kubernetes" "instruqt_k8" {
  identifier  = "instruqt_k8"
  name        = "Instruqt K8s"
  org_id      = var.org_id
  project_id  = var.project_id
  description = "Connector to Instruqt workshop K8s cluster"

  inherit_from_delegate {
    delegate_selectors = [var.delegate_selector]
  }
}

// Prometheus Connector
resource "harness_platform_connector_prometheus" "prometheus" {
  identifier         = "prometheus"
  name               = "Prometheus"
  org_id             = var.org_id
  project_id         = var.project_id
  description        = "Connector to Instruqt workshop Prometheus instance"
  url                = "http://prometheus-k8s.monitoring.svc.cluster.local:9090/"
  delegate_selectors = [var.delegate_selector]
}

// Dev Environment
resource "harness_platform_environment" "dev_environment" {
  identifier = "dev"
  name       = "Dev"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "PreProduction"
}

// Prod Environment
resource "harness_platform_environment" "prod_environment" {
  identifier = "prod"
  name       = "Prod"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "Production"
}

// Dev Infrastructure
resource "harness_platform_infrastructure" "dev_infra" {
  identifier      = "k8s_dev"
  name            = "K8s Dev"
  org_id          = var.org_id
  project_id      = var.project_id
  env_id          = harness_platform_environment.dev_environment.identifier
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml            = <<-EOT
    infrastructureDefinition:
     name: "K8s Dev"
     identifier: "k8s_dev"
     description: ""
     tags:
       owner: "${var.project_id}"
     orgIdentifier: "${var.org_id}"
     projectIdentifier: "${var.project_id}"
     environmentRef: "dev"
     deploymentType: Kubernetes
     type: KubernetesDirect
     spec:
      connectorRef: "instruqt_k8"
      namespace: "${var.namespace}"
      releaseName: release-<+INFRA_KEY>
     allowSimultaneousDeployments: true
  EOT
}

// Prod Infrastructure
resource "harness_platform_infrastructure" "prod_infra" {
  identifier      = "k8s_prod"
  name            = "K8s Prod"
  org_id          = var.org_id
  project_id      = var.project_id
  env_id          = harness_platform_environment.prod_environment.identifier
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml            = <<-EOT
    infrastructureDefinition:
     name: "K8s Prod"
     identifier: "k8s_prod"
     description: ""
     tags:
       owner: "${var.project_id}"
     orgIdentifier: "${var.org_id}"
     projectIdentifier: "${var.project_id}"
     environmentRef: "prod"
     deploymentType: Kubernetes
     type: KubernetesDirect
     spec:
      connectorRef: "instruqt_k8"
      namespace: "${var.namespace}"
      releaseName: release-<+INFRA_KEY>
     allowSimultaneousDeployments: true
  EOT
}

// Service
resource "harness_platform_service" "proj_service" {
  identifier  = "backend"
  name        = "backend"
  description = "Monitored backend service"
  org_id      = var.org_id
  project_id  = var.project_id
  yaml        = <<-EOT
    service:
      name: backend
      identifier: backend
      orgIdentifier: "${var.org_id}"
      projectIdentifier: "${var.project_id}"
      serviceDefinition:
        spec:
          manifests:
            - manifest:
                identifier: backend
                type: K8sManifest
                spec:
                  store:
                    type: HarnessCode
                    spec:
                      repoName: harnessrepo
                      gitFetchType: Branch
                      paths:
                        - harness-deploy/backend/manifests
                      branch: main
                  valuesPaths:
                    - harness-deploy/backend/values.yaml
                  skipResourceVersioning: false
                  enableDeclarativeRollback: false
          artifacts:
            primary:
              primaryArtifactRef: <+input>
              sources:
                - spec:
                    connectorRef: org.workshopdocker
                    imagePath: seworkshop/harness-workshop
                    tag: backend-latest
                    digest: ""
                  identifier: backend
                  type: DockerRegistry
        type: Kubernetes
  EOT
}

// Dev Monitored Service
resource "harness_platform_monitored_service" "dev_monitored_service" {
  org_id     = var.org_id
  project_id = var.project_id
  identifier = "backend_dev"
  request {
    name            = "backend"
    type            = "Application"
    service_ref     = harness_platform_service.proj_service.identifier
    environment_ref = harness_platform_environment.dev_environment.identifier
    health_sources {
      name       = "Prometheus"
      identifier = "prometheus"
      type       = "Prometheus"
      spec = jsonencode({
        connectorRef = "prometheus"
        metricDefinitions = [
          {
            identifier = "Prometheus_Metric",
            metricName = "Prometheus Metric",
            riskProfile = {
              riskCategory = "Performance_Other"
              thresholdTypes = [
                "ACT_WHEN_HIGHER"
              ]
            }
            analysis = {
              liveMonitoring = {
                enabled = true
              }
              deploymentVerification = {
                enabled                  = true
                serviceInstanceFieldName = "pod"
              }
            }
            query         = "avg(container_cpu_system_seconds_total { namespace=\"${var.namespace}\" , container=\"backend\"})"
            groupName     = "Infrastructure"
            isManualQuery = true
          }
        ]
      })
    }
  }
}

// Prod Monitored Service
resource "harness_platform_monitored_service" "prod_monitored_service" {
  org_id     = var.org_id
  project_id = var.project_id
  identifier = "backend_prod"
  request {
    name            = "backend"
    type            = "Application"
    service_ref     = harness_platform_service.proj_service.identifier
    environment_ref = harness_platform_environment.prod_environment.identifier
    health_sources {
      name       = "Prometheus"
      identifier = "prometheus"
      type       = "Prometheus"
      spec = jsonencode({
        connectorRef = "prometheus"
        metricDefinitions = [
          {
            identifier = "Prometheus_Metric",
            metricName = "Prometheus Metric",
            riskProfile = {
              riskCategory = "Performance_Other"
              thresholdTypes = [
                "ACT_WHEN_HIGHER"
              ]
            }
            analysis = {
              liveMonitoring = {
                enabled = true
              }
              deploymentVerification = {
                enabled                  = true
                serviceInstanceFieldName = "pod"
              }
            }
            query         = "avg(container_cpu_system_seconds_total { namespace=\"${var.namespace}\" , container=\"backend\"})"
            groupName     = "Infrastructure"
            isManualQuery = true
          }
        ]
      })
    }
  }
}

// DAST Template
resource "harness_platform_template" "dast_template" {
  identifier    = "DAST_Scans"
  org_id        = var.org_id
  project_id    = var.project_id
  name          = "DAST Scans"
  version       = "1.0"
  is_stable     = true
  template_yaml = <<-EOT
    template:
      name: "DAST Scans"
      identifier: "DAST_Scans"
      versionLabel: "1.0"
      type: Stage
      projectIdentifier: ${var.project_id}
      orgIdentifier: ${var.org_id}
      spec:
        type: SecurityTests
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
              - parallel:
                  - step:
                      type: Zap
                      name: ZAP
                      identifier: ZAP
                      spec:
                        mode: ingestion
                        config: default
                        target:
                          type: instance
                          detection: manual
                          name: frontend
                          variant: main
                        advanced:
                          log:
                            level: info
                        ingestion:
                          file: automation/sto_test/scan_tools/zap/001
                  - step:
                      type: Security
                      name: Veracode
                      identifier: Veracode
                      spec:
                        privileged: true
                        settings:
                          product_name: veracode
                          product_config_name: default
                          policy_type: ingestionOnly
                          scan_type: repository
                          repository_project: jhttp_isolated
                          repository_branch: <+codebase.branch>
                          customer_artifacts_path: automation/sto_test/scan_tools/veracode
                          manual_upload_filename: "001"
                        imagePullPolicy: Always
                      failureStrategies:
                        - onFailure:
                            errors:
                              - AllErrors
                            action:
                              type: Ignore
                      when:
                        stageStatus: Success
                        condition: "false"
          sharedPaths:
            - /var/run
          slsa_provenance:
            enabled: false
  EOT
}

// Compile Template
resource "harness_platform_template" "compile_template" {
  identifier    = "Compile_Application"
  org_id        = var.org_id
  project_id    = var.project_id
  name          = "Compile Application"
  version       = "v0.1"
  is_stable     = true
  template_yaml = <<-EOT
    template:
      name: "Compile Application"
      identifier: "Compile_Application"
      versionLabel: "v0.1"
      type: Step
      projectIdentifier: ${var.project_id}
      orgIdentifier: ${var.org_id}
      tags: {}
      spec:
        type: Run
        spec:
          connectorRef: org.workshopdocker
          image: node:20-alpine
          shell: Sh
          command: |-
            cd frontend-app/harness-webapp
            npm install
            npm install -g @angular/cli

            mkdir -p ./src/environments
            echo "export const environment = {
              production: true,
              defaultApiUrl: "'"https://backend.sandbox.<+variable.sandbox_id>.instruqt.io"'",
              defaultSDKKey: "'"<+variable.sdk>"'"
            };" > ./src/environments/environment.prod.ts


            echo "export const environment = {
              production: true,
              defaultApiUrl: "'"https://backend.sandbox.<+variable.sandbox_id>.instruqt.io"'",
              defaultSDKKey: "'"<+variable.sdk>"'"
            };" > ./src/environments/environment.ts

            npm run build
  EOT
}

// Project Variables
resource "harness_platform_variables" "user_variable" {
  identifier = "username"
  name       = "username"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = var.project_id
  }
}

resource "harness_platform_variables" "instruqt_variable" {
  identifier = "sandbox_id"
  name       = "sandbox_id"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = var.instruqt_sandbox_id
  }
}

resource "harness_platform_variables" "sdk_variable" {
  identifier = "sdk"
  name       = "sdk"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = "somekey"
  }
}

// OPA Policy
resource "harness_platform_policy" "sca_policy" {
  identifier = "SCA_Scans"
  name       = "SCA Scans"
  org_id     = var.org_id
  project_id = var.project_id
  rego       = <<-REGO
    package pipeline

    required_sca_steps = ["Owasp", "OsvScanner"]
    required_container_steps = ["AquaTrivy"]
    required_scan_steps = array.concat(required_sca_steps, required_container_steps)

    deny[msg] {
        required_step := required_scan_steps[_]
        not missing_scan_step(required_step)
        msg := sprintf("The CI stage is missing the required '%s' step. It's easy to add using the Harness Built-in Scanners.", [required_step])
    }

    deny[msg] {
        first_step := required_sca_steps[_]
        second_step := "BuildAndPushDockerRegistry"
        missing_scan_step(first_step)
        not incorrect_scan_placement(first_step, second_step)
        msg := create_message(first_step, second_step)
    }

    deny[msg] {
        first_step := "Compile_Application"
        second_step := required_sca_steps[_]
        missing_scan_step(second_step)
        not incorrect_scan_placement(first_step, second_step)
        msg := create_message(first_step, second_step)
    }

    deny[msg] {
        first_step := "BuildAndPushDockerRegistry"
        second_step := required_container_steps[_]
        missing_scan_step(second_step)
        not incorrect_scan_placement(first_step, second_step)
        msg := create_message(first_step, second_step)
    }

    contains(arr, elem) {
        arr[_] == elem
    }

    missing_scan_step(required_step) {
        stage = input.pipeline.stages[_].stage
        stage.type == "CI"
        steps := get_all_steps(stage)
        step_types := [step | step := steps[_].step_type ]
        contains(step_types, required_step)
    }

    incorrect_scan_placement(first_step, second_step) {
        stage := input.pipeline.stages[_].stage
        stage.type == "CI"
        steps := get_all_steps(stage)
        verify_scan_placement(steps, first_step, second_step)
    }

    get_all_steps(stage) = steps {
        parallel_steps := [{ "step_type": step_type, "step_index": step_index, "sub_index": sub_index,  } |
            step_type := stage.spec.execution.steps[step_index].parallel[sub_index].step.type
        ]
        sequential_steps := [{ "step_type": step_type, "step_index": step_index, "sub_index": 0,  } |
            step_type := stage.spec.execution.steps[step_index].step.type
        ]
        template_steps := [{ "step_type": step_type, "step_index": step_index, "sub_index": 0,  } |
            step_type := stage.spec.execution.steps[step_index].step.template.templateRef
        ]
        temp_steps := array.concat(parallel_steps, sequential_steps)
        steps := array.concat(temp_steps, template_steps)
        print("Debug: all_steps ", steps)
    }

    get_step_index(steps, step_type) = step_index {
        some index
        steps[index].step_type == step_type
        step_index := steps[index].step_index
    }

    verify_scan_placement(steps, first_step, second_step) {
        first_index := get_step_index(steps, first_step)
        second_index := get_step_index(steps, second_step)
        first_index < second_index
    }

    create_message(first_step_type, second_step_type) = msg {
        msg := sprintf("'%s' must occur prior to the '%s' step.", [first_step_type, second_step_type])
    }
  REGO
}

// Policy Set
resource "harness_platform_policyset" "sto_policyset" {
  identifier = "Security_Scan_Steps_Required"
  name       = "Security Scan Steps Required"
  org_id     = var.org_id
  project_id = var.project_id
  action     = "onrun"
  type       = "pipeline"
  enabled    = false
  policies {
    identifier = harness_platform_policy.sca_policy.id
    severity   = "error"
  }
}
