---
slug: clone-the-repo
id: gvavccxp4j0l
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
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/modules/svg/code.svg" alt="Harness Code" width="150">
        <p>Harness Code</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/logos/svg/github.svg" alt="GitHub" width="150">
        <p>GitHub</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/logos/svg/gitlab.svg" alt="GitLab" width="150">
        <p>GitLab</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/logos/svg/bitbucket.svg" alt="BitBucket" width="150">
        <p>BitBucket</p>
      </div>
      <div class="plugin-item">
        <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/logos/svg/git_scm.svg" alt="Git" width="150">
        <p>Git</p>
      </div>
    </div>
tabs:
- id: f8s8eq3oxx7p
  title: Harness Platform
  type: browser
  hostname: harness
- id: pbqsmsyt8ghj
  title: Code Editor
  type: service
  hostname: sandbox
  port: 8443
- id: fy7e5aikytca
  title: Shell
  type: terminal
  hostname: sandbox
- id: yacyc0qmz5gw
  title: Notes
  type: code
  hostname: sandbox
  path: /root/notes
- id: crkuelhxut5n
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
img.inline { height: 5; vertical-align:middle; }
</style><h2 class="cyan">Clone the IaC Repo</h2>
<hr class="cyan">
<br><br>

Review Repo and Generate Clone Credentials
===

## Let's take a look at the repo

Select the **Code Repository** module from the module selector menu <br>

![](https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/module_code.png)

<br>

There is a repo (**iacm-repo**) that has been provisioned for you.
<br><br>

## Generate Clone Credentials

Before we can clone the repo, we need to generate credentials.

- Click into the **iacm-repo** repo

- Click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_clone_button.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> at the top right of the page.

- In the **Git clone URL** dialog that appears, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hcr_generate_clone_creds.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;">

- In the **Generate Clone Credentials** dialog that appears, click <img src="https://raw.githubusercontent.com/harness-community/field-workshops/iacm-updates/assets/images/hcr/hrc_copy_value_button.png" style="display:inline; height:24px; width:auto; vertical-align:middle; margin:0; padding:0;"> next to the **Password (API Token)** field to copy the token to your clipboard
<br>

Clone the Repo and View in IDE
===

> ## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

### Update the credential file

Click `▶️ run` below and then provide the token you just copied.
```bash,run
./script.sh
```

### Clone the repo
Click `▶️ run` below
```bash,run
git clone [[ Instruqt-Var key="HARNESS_REPO_URL" hostname="sandbox" ]]
```

> ## Switch to the [button label="Code Editor" variant="success"](tab-1) tab to continue
From here we can take a look at our HCL code to get a better understanding of what we will provision through an IaCM pipeline in the following labs. We'll be using the `aws/v1` folder for this workshop.

> [!IMPORTANT]
> Please do not make any changes at this time.

===============

Click the **Check** button to continue.