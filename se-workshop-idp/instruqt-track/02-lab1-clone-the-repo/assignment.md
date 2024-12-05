---
slug: lab1-clone-the-repo
id: 7tuv4ozrtvjr
type: challenge
title: Lab 1 - Clone the IaC Repo
teaser: For this workshop we will be using Harness Code, but this process works the
  same with any git based SCM.
notes:
- type: text
  contents: |
    - For this workshop we will be using Harness Code, but this process works the same with any git based SCM
tabs:
- id: pnkbunaxykef
  title: Harness Platform
  type: browser
  hostname: harness
- id: isjuvjax6upx
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: 8yzzcntmbdnp
  title: Shell
  type: terminal
  hostname: sandbox
- id: pkkmtc8vrkso
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: r3emfsfsgytm
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
