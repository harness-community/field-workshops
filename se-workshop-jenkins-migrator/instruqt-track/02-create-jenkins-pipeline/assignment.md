---
slug: create-jenkins-pipeline
id: bke6koh2myc4
type: challenge
title: Lab 1 - Create a Jenkins Pipeline
notes:
- type: text
  contents: |-
    <style>
      .container {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        height: 90vh;
        gap: 10px;
        padding: 5px;
        box-sizing: border-box;
      }

      .sub-container {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
      }

      .harness-image {
        max-width: 90%;
        max-height: 55%;
        object-fit: contain;
      }

      .features-list {
        list-style-type: none;
        padding: 0;
        position: sticky;
      }

      .features-list li {
        margin: 5px 0;
        font-weight: bold;
        font-size: 25px;
      }

      .features-list .sub-list {
        list-style-type: disc;
        margin-left: 20px;
        font-weight: normal;
        font-size: 20px;
        font-style: italic;
      }

      @media (max-width: 768px) {
        .features-list li {
          font-size: 1.25rem;
        }

        .features-list .sub-list {
          font-size: 1.25rem;
        }
      }

      @media (max-width: 480px) {
        .features-list li {
          font-size: 1rem;
        }

        .features-list .sub-list {
          font-size: 1rem;
        }
    </style>

    <div class="container">
      <h1>Legacy DevOps</h1>
      <img class="harness-image" src="https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_devil.png">
      <ul class="features-list">
        <li>Plugin Hell. Brought to you by Jenkins.</li>
      </ul>
    </div>
tabs:
- id: 5mznaz5kj0ho
  title: Harness Platform
  type: browser
  hostname: harness
- id: dzxhnxbxypjb
  title: Jenkins
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
- id: 3hrh0m8djs1o
  title: Shell
  type: terminal
  hostname: sandbox
- id: pvuaw7vdg722
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
- id: w7ylo74e9rle
  title: Harness Platform
  type: website
  url: https://app.harness.io/ng/account/UL037itkT6SA3IDdIIXWcQ/main-dashboard
  new_window: true
- id: nmz9rrq5usgm
  title: Jenkins
  type: website
  url: https://${_SANDBOX_ID}.instruqt.harness-demo.site/
  new_window: true
difficulty: basic
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Jenkins Setup</h2>
<hr class="cyan">
<br><br>

> - Click `+ API Key` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/harness_new_api_key.png)
> **New API Key**
> - Name: <pre>`Service Accounts`</pre>
> - Click: Save

> - Click `+ Token` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/harness_new_api_token.png)
> **New Token**
> - Name: <pre>`Jenkins`</pre>
> - Click: Generate Token
> - Copy the Value

## Switch to Jenkins Tab

### Configure Harness Migration Plugin
> - Click on `Manage Jenkins` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_manage_jenkins.png)
> - Click on `System` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_configure_system.png)
> - Scroll down to `Harness Migration`
> - Configure with the details below ↓

> **Harness Migration**
> - API Key: `(Value you copied from Harness)`
> - Account Identifier: <pre>`[[ Instruqt-Var key="HARNESS_ACCOUNT_ID" hostname="sandbox" ]]`</pre>
> - Organization Identifier: <pre>`[[ Instruqt-Var key="HARNESS_ORG_ID" hostname="sandbox" ]]`</pre>
> - Project Identifier: <pre>`[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]`</pre>
> - Click **Save**


### Create a Jenkins Pipeline
> - Click `+New Item` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_new_item.png)

> **New Item**
> - Name: <pre>`se-lab`</pre>
> - Type: `Pipeline`
> - Click **OK**
> - Scroll down and paste in the `Pipeline Script` below ↓
```
@Library("build-utils") _
pipeline {
    agent {
        kubernetes {
            cloud 'gke'
            inheritFrom 'build-agent'
        }
    }
    environment {
        DOCKER_IMAGE = "seworkshop/zuul"
        DOCKER_TAG = "[[ Instruqt-Var key="HARNESS_PRJ_ID" hostname="sandbox" ]]"
    }
    stages {
        stage('Checkout') {
            steps {
                git(branch: 'master', url: 'https://github.com/anurag-harness/zuul')
            }
        }
        stage('Download Dependencies') {
            parallel {
                stage('Download Dependencies 1') {
                    steps {
                        sh "touch gradle_build_log"
                    }
                }
                stage('Download Dependencies 2') {
                    steps {
                        sh "mkdir -p target/log/gradle"
                    }
                }
            }
        }
        stage('Build and Test') {
            steps {
                container('gradle') {
                    script {
                        runGradleBuildAndTest()
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                container('docker') {
                    script {
                        withDockerRegistry(credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/') {
                            def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                            image.push()
                        }
                    }
                }
            }
        }
    }
    post {
        success {
            echo "Docker image ${DOCKER_IMAGE}:${DOCKER_TAG} was built and pushed successfully."
        }
        failure {
            echo "There was an error building or pushing the Docker image."
        }
    }
}
```

> - Click **Save**
> - Click `Build Now` \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-jenkins-migrator/assets/images/jenkins_build_now.png)



===============

Click the **Check** button to continue.
