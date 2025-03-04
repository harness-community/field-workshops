---
slug: cloud-development-environments-beta
id: ftiejxgmvfxx
type: challenge
title: Lab 6 - Cloud Development Environments Beta
teaser: On-demand development environments.
notes:
- type: text
  contents: |-
    <h1>Streamline the Development Inner Loop</h1>

    Developers can start coding immediately with environments tailored to their projects, accessible from anywhere while maintaining familiarity with their preferred tools.

    <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_streamline_dev_loop.png" width="800" style="display: inline; vertical-align: center;">

    - **Run preferred IDEs locally or in the cloud**
    - **On-demand development environments**
    - **Integrate with existing workflows**
tabs:
- id: gbelzfu0gzoe
  title: Harness Platform
  type: browser
  hostname: harness
- id: 4ra6zmpptujy
  title: Shell
  type: terminal
  hostname: sandbox
- id: mm2qrwvexzj3
  title: Public Key
  type: code
  hostname: sandbox
  path: /root/.ssh/harness_cde.pub
- id: wh7geypyj9mv
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
</style><h2 class="cyan">Cloud Development Environments</h2>
<hr class="cyan">
<br><br>

# There are two types of Cloud Development Environments
## Expand the section for the Gitspace you'd like to configure

VS Code Online in the Gitspace
===
## Now let's create a CDE Gitspace
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_cde.png)

Select the **Cloud Development Environments** module from the list <br>

Click on **Gitspaces** in the left Nav <br>
And then click `Get Started Now >` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_get_started_now.png) <br>
Configure your Gitspace as per the instructions provided below ↓ <br>

> [!NOTE]
> We are using a public GitHub repo for this workshop so you can ignore the OAuth message. \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_github_configure_oauth.png)


> **Create Gitspace**
> - Repository Details
>   - Git Provider: `GitHub Cloud`
>   - Repo URL: <pre>`https://github.com/jtitra/haikus`</pre>
>   - Repo Branch: `main`
> - IDE: `VS Code Browser`
> - Region: `us-west`
> - Machine Type: `Standard`
> - Click **Create Gitspace**

<br>


> [!NOTE]
> This will set up your development environment in the cloud and will take approximately 2-3 minutes to complete. \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_gitspace_starting.png)
> - Expand `Gitspace Activity` and `Container Logs` to see this process in real-time.

## Now that your development environment is set up, you can start coding and testing your applications!
> [!IMPORTANT]
> - Scroll to the top of the page and click on the **Open VS Code Online** button to launch your coding environment \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_open_vs_code_online.png)
> - Due to a limitation with the **Instruqt** platform, you will need to click on the prompt and show the pop-up \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_instruqt_allow_pop_up.png)
> - You are now ready to start coding!

> [!NOTE]
> Please skip over the `VS Code Desktop` section below and continue with `Running Your App`

Testing - VS Code Desktop on your local machine
===
> [!IMPORTANT]
> Not currently implemented in this workshop. Please follow the instructions for using `VS Code Online` instead.

## Prior to creating our Gitspace we must first create an SSH Keypair

> ## Switch to the [button label=">_Shell" variant="success"](tab-2) tab to continue

### Generate SSH Keypair
> [!NOTE]
> This step will allow our local VS Code IDE to connect with the remote Gitspace.

<br>

Click `▶️ run` to generate a new ssh keypair.
```bash,run
ssh-keygen -o -f ~/.ssh/harness_cde -C harness -N ""
```

<br>

Click `▶️ run` to display the public key.
```bash,run
cat ~/.ssh/harness_cde.pub
```

> ### Highlight the public key to copy it to your clipboard
> #### You can also find the contents on the [button label="Public Key" variant="success"](tab-3) tab

> ## Switch to the [button label="Harness Platform" variant="success"](tab-0) tab to continue

## Now let's create a CDE Gitspace
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/module_cde.png)

Select the **Cloud Development Environments** module from the list <br>

Click on **Gitspaces** in the left Nav <br>
And then click `Get Started Now >` <br>
![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_get_started_now.png) <br>
Configure your Gitspace as per the instructions provided below ↓ <br>

> [!NOTE]
> We are using a public GitHub repo for this workshop so you can ignore the OAuth message. \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_github_configure_oauth.png)


> **Create Gitspace**
> - Repository Details
>   - Git Provider: `GitHub Cloud`
>   - Repo URL: <pre>`https://github.com/jtitra/haikus`</pre>
>   - Repo Branch: `main`
> - IDE: `VS Code Desktop`
> - SSH Key:
>   - Click the dropdown and select `Add SSH Key`
>   - Key Name: <pre>`harness_cde`</pre>
>   - SSH Key: ***Paste contents from [button label="Public Key" variant="success"](tab-3) tab***
>   - Click `Add Key`
> - Region: `us-west`
> - Machine Type: `Standard`
> - Click **Create Gitspace**

<br>


> [!NOTE]
> This will set up your development environment in the cloud and will take approximately 2-3 minutes to complete. \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_gitspace_starting.png)
> - Expand `Gitspace Activity` and `Container Logs` to see this process in real-time.

## Now that your development environment is set up, you can start coding and testing your applications!
> [!IMPORTANT]
> - Normally you would be able to scroll to the top of the page and click on the **Open VS Code Editor** button to launch your coding environment \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_open_vs_code_editor.png)
> - But due to a limitation with the **Instruqt** platform, you will need to manually open your VS Code editor after the Gitspace is ready
> - Open your local VS Code editor and add the [Harness Gitspaces](https://marketplace.visualstudio.com/items?itemName=harness-inc.gitspaces) extension
> - Login to the extension using your credentials on the <img src="https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/images/link.svg" alt="Link icon" width="16" height="16" style="display: inline; vertical-align: middle;">[button label="Lab Credentials" variant="success"](tab-4) tab

Running Your App
===
## In your VS Code Editor

> - Click in the top search bar and select <br> `Show and Run Commands >`
> - Or use the shortcut:
> <div class="monaco-keybinding" custom-hover="true" aria-label="Shift+Command+P"
>    style="color: var(--vscode-keybindingLabel-foreground);"><span class="monaco-keybinding-key"
>        style="background-color: var(--vscode-keybindingLabel-background); border-top-color: ; border-right-color: ; border-bottom-color: var(--vscode-keybindingLabel-bottomBorder); border-left-color: ; box-shadow: inset 0 -1px 0 var(--vscode-widget-shadow);">⇧</span><span
>        class="monaco-keybinding-key"
>        style="background-color: var(--vscode-keybindingLabel-background); border-top-color: ; border-right-color: ; border-bottom-color: var(--vscode-keybindingLabel-bottomBorder); border-left-color: ; box-shadow: inset 0 -1px 0 var(--vscode-widget-shadow);">⌘</span><span
>        class="monaco-keybinding-key"
>        style="background-color: var(--vscode-keybindingLabel-background); border-top-color: ; border-right-color: ; border-bottom-color: var(--vscode-keybindingLabel-bottomBorder); border-left-color: ; box-shadow: inset 0 -1px 0 var(--vscode-widget-shadow);">P</span>
></div>
>
> - Select or type: `Create New Terminal`
> - Select: `bash`
> - A new terminal will open at the bottom of your IDE
> - You can now run your commands and start building your application in this terminal
> - Type `yarn start` into the terminal and press enter to run your application
> - Click `Open in Browser` to see your application! \
>     ![](https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-idp/assets/images/cde_open_in_browser.png)


<br><br>

Conclusion
===

# Congratulations on completing this `Harness IDP` workshop!
> [!IMPORTANT]
> That's all for now. We hope you enjoyed your hands-on experience with the Harness IDP module. We are always looking to improve so please rate your experience and share any suggestions or issues you may have encountered. Thank you! Happy coding!


===============

Click the **Check** button to continue.
