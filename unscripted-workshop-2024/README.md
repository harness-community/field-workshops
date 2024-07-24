# Instructions for building your own Instruqt Track

## Start by making a copy of this template.
```
.
├── README.md
├── assets
│   └── README.md
└── instruqt-track
    ├── 01-logging-into-your-harness-sandbox-account
    │   ├── assignment.md
    │   ├── check-sandbox
    │   ├── setup-sandbox
    │   └── solve-sandbox
    ├── 02-lab1-your-lab-name-here
    │   ├── assignment.md
    │   ├── check-sandbox
    │   ├── setup-sandbox
    │   └── solve-sandbox
    ├── config.yml
    ├── track.yml
    └── track_scripts
        ├── cleanup-sandbox
        └── setup-sandbox
```

## Instruqt 101
Every track has a few key components: <br>
- **config.yml**
  - For a basic workshop this will not require any modification.
- **track.yml**
  - This only requires a few updates and controls how your track is rendered in Instruqt.
  - ![Instruqt Track](https://raw.githubusercontent.com/harness-community/field-workshops/main/aaa-se-workshop-template/assets/images/EXAMPLE.png)
- **track_scripts**
  - `setup-sandbox`
    - This script contains the standard setup required for every Instruqt track.
    - 🟥 Do NOT modify any of it.
      - This script creates a user in Keycloak and then creates a project for that user in Harness
    - If you need to add any configuration specific to your workshop add it after line `#80`
  - `cleanup-sandbox`
    - This script cleans up everything that was provisioned as part of the Instruqt track.
    - 🟥 Do NOT modify any of it.
    - If you need to clean up any configuration specific to your workshop add it after line `#44`

**instruqt-track**
- Every lab will have it's own folder which will contain four files.
  - `assignment.md` This is the lab guide the attendees will follow
  - `setup-sandbox` This contains any additional setup required for this individual lab
  - `check-sandbox` This contains any programmatic validation you wish to occur when the user clicks the ***Check*** button
  - `solve-sandbox` This contains any automation to perform the steps for the user. Only necessary if you allow the user to ***Skip***
- Name the folder using the same value as the ***slug*** from `assignment.md` prefixed with its numerical position in the workshop sequence.
- Focus on the `assignment.md` file first and do not worry about any validation until after your content and flow is finalized.

### Install Instruqt CLI
- [Set up Instruqt](https://docs.instruqt.com/getting-started/set-up-instruqt#step-3-set-up-your-chosen-tool) <br>
- [CLI Commands](https://docs.instruqt.com/reference/cli/commands#instruqt-track-push) <br>
Once the CLI is installed run ```instruqt auth login``` to authenticate <br>
Then `cd` to your `instruqt-track` folder and run ```instruqt track push``` to push your track to the Instruqt platform <br>



For more information on Instruqt and its capabilities, please visit the following resources:
- [Instruqt Docs](https://docs.instruqt.com/)
- [Email Joe](mailto:jtitra@harness.io) or @Joe on Slack



## Harness Tracks
- **assets**
   - This is where any track specific assets go. Refer to the IaCM workshop as an example.
- **instruqt-track**
  - `01-logging-into-your-harness-sandbox-account`
    - Every workshop should start with this track. You should not need to change anything about it.
    - The workshop provisions a user in Keycloak and then leverages JIT to create the user in Harness the first time they login.
    - The `check-sandbox` script will verify that the user has actually logged in prior to allowing them to continue.
  - `02-lab1-your-lab-name-here`
    - Rename this folder to match the name of your first lab.
    - Now that the user exists in Harness, the `setup-sandbox` script will assign admin permissions to the Harness project we've created for the user.
    - 🟥 Do NOT modify this script.


# Use the structure below when creating the track readme.
You can also reference this example: https://raw.githubusercontent.com/harness-community/field-workshops/main/se-workshop-iacm/README.md

# Harness TEMPLATE Instruqt Workshop

![Harness TEMPLATE](https://assets-global.website-files.com/6222ca42ea87e1bd1aa1d10c/65e64f6e1344e6f327643409_Harness%20101%20Header%20(1)-p-2000.webp)

## Introduction

Your workshop description here

## Labs

Add your individual labs here: e.g.,
### Lab 1: Creating a Workspace
In this lab, participants will learn how to create and configure a workspace in Harness IaCM. This will serve as the foundation for the subsequent labs, where you will manage your infrastructure as code.

## Additional Resources
Notate any additional resources relevant here

## Contributing
Feel free to fork the repository and submit pull requests. You can also open issues if you find any bugs or have suggestions for improvements.

## Contact Information
Add your contact info here: e.g.,
For questions or support regarding this workshop, please contact [jtitra@harness.io](mailto:jtitra@harness.io).
