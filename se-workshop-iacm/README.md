# Harness IaCM Instruqt Workshop

![Harness IaCM](https://developer.harness.io/img/iacm_landing.png)

## Introduction

This workshop is designed to provide hands-on experience with Harness Infrastructure as Code Management. Participants will learn how to create workspaces, build pipelines, detect configuration drifts, and enforce governance using Open Policy Agent (OPA).

## Versions
 - [AWS](https://github.com/harness-community/field-workshops/tree/main/se-workshop-iacm/instruqt-tracks/aws) - Each attendee gets their own AWS account to deploy and drift EC2 instances
 - [GCP](https://github.com/harness-community/field-workshops/tree/main/se-workshop-iacm/instruqt-tracks/gcp) - Each attendee gets their own GCP project to deploy and drift GCE instances
 - Azure (coming soon)

## Labs

### Lab 1: Clone the IaC Repo
In this first lab, participants will clone the IaC repo that we will use in subsequent labs.

### Lab 2: Creating a Workspace
Next, participants will learn how to create and configure a workspace in Harness IaCM. This will serve as the foundation to manage your infrastructure as code.

### Lab 3: Create a Harness IaCM Pipeline
Learn how to create a pipeline in Harness IaCM. This lab will cover the basics of pipeline configuration, including how to trigger deployments and manage infrastructure changes effectively.

### Lab 4: Drift Detection with Harness IaCM
This lab focuses on detecting configuration drifts in your infrastructure. Participants will learn how to set up drift detection, interpret its results, and understand the impact of drift on infrastructure management.

### Lab 5: Security Testing Orchestration
Shift-left and integrate security scanners into your pipelines, using Harness to automate vulnerability scanning, compliance checks, and other security measures.
 - IaC (Infrastructure as Code): Integrate Wiz to identify vulnerabilities before you deploy your infrastructure.

### Lab 6: Governance with OPA
Explore how to integrate Open Policy Agent (OPA) with Harness IaCM to enforce governance policies. This lab will demonstrate setting up policy-as-code frameworks to ensure compliance across your infrastructure deployments.

### Lab 7: Cost Estimation and State Changes
In this lab you will learn how to utilize Harness IaCM to estimate costs and track state changes in your infrastructure, enabling more informed decision-making.

### Lab 8: PR Triggers and Validation
In our final lab, you will create a PR Validation pipeline that we will trigger by adding a new TF resource.

## Additional Resources
This workshop leverages the Terraform code found here:
- [iacm-workshop](https://github.com/harness-community/se-iacm-workshop)

For more information on Harness IaCM and its capabilities, please visit the following resources:
- [Harness Developer Hub](https://developer.harness.io/docs/infrastructure-as-code-management)

## Contributing
Feel free to fork the repository and submit pull requests. You can also open issues if you find any bugs or have suggestions for improvements.

## Contact Information
For questions or support regarding this workshop, please contact [jtitra@harness.io](mailto:jtitra@harness.io).

