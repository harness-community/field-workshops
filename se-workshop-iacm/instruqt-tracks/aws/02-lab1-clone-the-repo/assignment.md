---
slug: lab1-clone-the-repo
id: bhnpt1x9ilr3
type: challenge
title: Lab 1 - Clone the IaC Repo
teaser: For this workshop we will be using Harness Code, but this process works the
  same with any git based SCM.
notes:
- type: text
  contents: |-
    <style>
      .plugins-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        justify-items: center;
        gap: 20px;
        margin: 20px 0;
        text-align: center;
      }

      .plugin-item img {
        max-width: 100%;
        height: auto;
      }

      .plugin-item p {
        margin-top: 10px;
        font-size: 19px;
      }
    </style>

    For this workshop we will be using Harness Code, but this process works the same with any git based SCM.

    <div class="plugins-grid">
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/modules/svg/code.svg" alt="Harness Code" width="150">
        <p>Harness Code</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/logos/svg/github.svg" alt="GitHub" width="150">
        <p>GitHub</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/logos/svg/gitlab.svg" alt="GitLab" width="150">
        <p>GitLab</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/logos/svg/bitbucket.svg" alt="BitBucket" width="150">
        <p>BitBucket</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/logos/svg/git_scm.svg" alt="Git" width="150">
        <p>Git</p>
      </div>
    </div>
tabs:
- id: 9v1f5dkcnmft
  title: Harness Platform
  type: browser
  hostname: harness
- id: gyhxvkvqjmkz
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 6tt2eycijprw
  title: Shell
  type: terminal
  hostname: sandbox
- id: 2mxzsvuu1g0k
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: zadrovayhp0t
  title: Lab Credentials
  type: service
  hostname: sandbox
  path: /credential_tab.html
  port: 8000
difficulty: basic
timelimit: 1600
enhanced_loading: null
---

<style type="text/css" rel="stylesheet">
hr.cyan { background-color: cyan; color: cyan; height: 2px; margin-bottom: -10px; }
h2.cyan { color: cyan; }
</style><h2 class="cyan">Clone the IaC Repo</h2>
<hr class="cyan">
<br><br>

First let's select the project that's been created for this workshop <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/project_selection.png)

## Let's take a look at our code
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_code.png)

Select the **Code Repository** module from the list <br>

Click on the **iacm-repo** that's been setup for you <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/assets/images/iacm_code_repo.png)

Click on **Clone** in the top right <br>
And then click `+Generate Clone Credential` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/code_clone.png)

Copy the values from here and store them on the `Notes` 📝 tab or locally on your machine.

> # Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

### Update our credential file
> [!NOTE]
> This step is optional, but will eliminate the need to enter the username and password in subsequent steps.

<br>

Click `▶️ run` and then provide the token you just copied.
```bash,run
./script.sh
```

### Clone the repo
```bash,run
git clone [[ Instruqt-Var key="HARNESS_REPO_URL" hostname="sandbox" ]]
```

> # Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue
From here we can take a look at our Terraform code to get a better understanding of what we will provision through an IaCM pipeline in the following labs.

> [!IMPORTANT]
> Please do not make any changes at this time.

===============

Click the **Check** button to continue.
