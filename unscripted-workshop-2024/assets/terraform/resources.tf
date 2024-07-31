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

// K8s connector
resource "harness_platform_connector_kubernetes" "k8s" {
  identifier  = "k8sprod"
  name        = "k8s-prod"
  org_id      = var.org_id
  project_id  = var.project_id
  description = "Connector to Instruqt workshop K8s cluster"

  inherit_from_delegate {
    delegate_selectors = [var.delegate_selector]
  }
}

// Prometheus connector
resource "harness_platform_connector_prometheus" "prometheus" {
  identifier         = "prometheus"
  name               = "prometheus"
  org_id             = var.org_id
  project_id         = var.project_id
  description        = "prometheus metrics"
  url                = "http://prometheus-k8s.monitoring.svc.cluster.local:9090/"
  delegate_selectors = [var.delegate_selector]
}

// Environment
resource "harness_platform_environment" "proj_environment" {
  identifier = "prod"
  name       = "prod"
  org_id     = var.org_id
  project_id = var.project_id
  type       = "PreProduction"
}

// Infrastructure
resource "harness_platform_infrastructure" "proj_infra" {
  identifier      = "k8s"
  name            = "k8s"
  org_id          = var.org_id
  project_id      = var.project_id
  env_id          = harness_platform_environment.proj_environment.identifier
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml            = <<-EOT
        infrastructureDefinition:
         name: "k8s"
         identifier: "k8s"
         description: ""
         tags:
           owner: "${var.project_id}"
         orgIdentifier: "${var.org_id}"
         projectIdentifier: "${var.project_id}"
         environmentRef: "prod"
         deploymentType: Kubernetes
         type: KubernetesDirect
         spec:
          connectorRef: "k8sprod"
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
                tag: backend-v2
                digest: ""
              identifier: backend
              type: DockerRegistry
    type: Kubernetes
  EOT
}

// Monitored Service
resource "harness_platform_monitored_service" "proj_monitored_service" {
  org_id     = var.org_id
  project_id = var.project_id
  identifier = "backend"
  request {
    name            = "backend"
    type            = "Application"
    description     = "description"
    service_ref     = harness_platform_service.proj_service.identifier
    environment_ref = harness_platform_environment.proj_environment.identifier
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

// OWASP template
/*
resource "harness_platform_template" "owasp_template" {
  identifier    = "owasp"
  org_id        = var.org_id
  project_id    = var.project_id
  name          = "OWASP"
  version       = "v0.1"
  is_stable     = true
  template_yaml = <<-EOT
template:
  name: "OWASP"
  identifier: "owasp"
  versionLabel: "v0.1"
  type: Step
  projectIdentifier: ${var.project_id}
  orgIdentifier: ${var.org_id}
  tags: {}
  spec:
    type: Owasp
    spec:
      mode: ingestion
      config: default
      target:
        type: repository
        name: <+pipeline.name>
        variant: <+codebase.branch>
      advanced:
        log:
          level: info
      ingestion:
        file: automation/sto_test/scan_tools/owasp/001
  EOT
}
*/

// Fortify template
resource "harness_platform_template" "fortify_template" {
  identifier    = "fortify"
  org_id        = var.org_id
  project_id    = var.project_id
  name          = "Fortify"
  version       = "v0.1"
  is_stable     = true
  template_yaml = <<-EOT
template:
  name: "Fortify Scan"
  identifier: "fortify"
  versionLabel: "v0.1"
  type: Step
  projectIdentifier: ${var.project_id}
  orgIdentifier: ${var.org_id}
  tags: {}
  spec:
    type: Security
    spec:
      privileged: true
      settings:
        product_name: fortify
        product_config_name: fortify-default
        policy_type: manualUpload
        scan_type: repository
        repository_project: harness-workshop
        repository_branch: <+codebase.branch>
        customer_artifacts_path: automation/sto_test/scan_tools/fortify/
        manual_upload_filename: "001"
      imagePullPolicy: Always
    failureStrategies:
      - onFailure:
          errors:
            - AllErrors
          action:
            type: ManualIntervention
            spec:
              timeout: 1d
              onTimeout:
                action:
                  type: StageRollback
    when:
      stageStatus: Success
  icon: data:image/png;base64,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
  EOT
}

// Compile template
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
          defaultApiUrl: "'"http://web-backend-svc.default.svc.cluster.local"'",
          defaultSDKKey: "'"<+variable.sdk>"'"
        };" > ./src/environments/environment.prod.ts


        echo "export const environment = {
          production: true,
          defaultApiUrl: "'"http://web-backend-svc.default.svc.cluster.local"'",
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
