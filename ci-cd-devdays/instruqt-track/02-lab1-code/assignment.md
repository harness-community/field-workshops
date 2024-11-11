---
slug: lab1-code
id: og5lgz8tnczk
type: challenge
title: Lab 1 - Harness Code
teaser: Your introduction to Harness Code and it's extremely powerful capabilities.
notes:
- type: text
  contents: |
    - Ensure every commit meets your organization’s security and compliance standards
    - Scan for hard-coded secrets before the code is committed in the repository
    - Scan for open source vulnerabilities before the code is committed in the repository
tabs:
- id: 4sj72ayzjs30
  title: Harness Platform
  type: browser
  hostname: harness
- id: 3dlzkxgyh580
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: mwu1ortzhiil
  title: Shell
  type: terminal
  hostname: sandbox
- id: dtxlwxsgsa6j
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: hop8oh1uyv03
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
</style><h2 class="cyan">Harness Code</h2>
<hr class="cyan">
<br><br>

First let's select the project that's been created for this workshop <br>
![project_selection.png](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/project_selection.png)

## Let's take a look at our code
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_code.png)

Select the **Code Repository** module from the list <br>

Click on the **harnessrepo** that's been setup for you <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/code_repo.png)

Click on **Clone** in the top right <br>
And then click ```+Generate Clone Credential``` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/code_clone.png)

Copy the values from here and store them on the `Notes` 📝 tab or locally on your machine.

> # Switch to the ```>_Shell``` tab to continue

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

> # Switch to the ```Code Editor``` tab to continue

### Update `backend` **>** `entrypoint.sh` file
- Under `APP_PORT=${PORT:-8000}`
  - Add:
```bash
TOKEN="02290a2a-7f5a-4836-8745-d4d797e475d0"
```

1) Click on `Source Control` tab on the left nav
2) Enter your commit message e.g., `added my password`
3) Click the dropdown `v`
4) Click `Commit & Push` \
    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_commit.png)
5) Click `Yes` \
    ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_stage_changes.png)


## Our commit has been blocked...
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/unscripted-workshop-2024/assets/images/vs_code_commit_error.png)
- Click on `Show Command Output` to see the details

## *Why wait until your secrets are committed to detect them?*
### With ***Harness Code*** you don't have to
Harness Code provides security features to protect your code and ***prevent*** `secrets` or `vulnerabilities` from being pushed to your Git repositories. ***Blocking*** secrets and vulnerabilities from being introduced into your repos is crucial for securing your codebase.

===============

Click the **Check** button to continue.
