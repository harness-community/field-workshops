# Harness CI/CD DevDays Instruqt Workshop

![](https://raw.githubusercontent.com/harness-community/field-workshops/main/ci-cd-devdays/assets/images/hands_on_labs_full.png)

## Introduction

This workshop is designed to provide practical experience with the Harness platform, focusing on various aspects of its capabilities. Participants will gain hands-on experience in building and deploying applications, integrating security measures, and automating continuous verification processes.

## Labs

### Lab 1: Building the Application
Learn how to build your application using Harness, including setting up build steps, managing build artifacts, and configuring build environments.

### Lab 2: Continuous Deployment - Frontend
Create your first service and build a deployment pipeline utilizing a rollout deployment strategy to deploy the frontend of your application into your workshop environment.

### Lab 3: Continuous Deployment - Backend
Harness natively supports complex deployment strategies like **Canary** and **Blue/Green**, and in this lab, we will configure a pipeline to deploy the backend of your application using the Canary deployment strategy.

### Lab 4: Security Testing Orchestration
Shift-left and integrate security scanners into your pipelines, using Harness to automate vulnerability scanning, compliance checks, and other security measures.
- **SCA (Software Composition Analysis):** Integrate OWASP Dependency-Check, OSV (Open Source Vulnerabilities), and BlackDuck to identify vulnerabilities in open-source dependencies.
- **SAST (Static Application Security Testing):** Use Semgrep to detect vulnerabilities and enforce secure coding standards.
- **Container Scanning:** Integrate Wiz to scan your container images for vulnerabilities before deployment.
- **DAST (Dynamic Application Security Testing):** Automate runtime vulnerability scanning using tools like ZAP and Veracode to ensure application security at runtime.

### Lab 5: Governance and Policy as Code
Explore how to enforce governance via OPA policies within Harness, defining and applying policy rules to ensure compliance and best practices across your projects.
- **Security Scanners:** Enforce the use of SCA, SAST, Container, and DAST scanners as part of the pipeline policy to meet governance requirements.
- **Change Approval Required:** Integrate change management tools like ServiceNow to enforce approvals and audit compliance before any deployment occurs.

### Lab 7: Continuous Verification
Implement continuous verification practices, using Harness to automate the process of post-deployment validation by leveraging existing monitoring tools and validating the health and performance of your deployments in real time.
- **Automated Rollback:** Automatically roll back deployments on failure detection, using monitoring insights and Harness automation to ensure quick recovery and minimize downtime.

## Additional Resources
For more information on Harness and its capabilities, please visit the following resources:
- [Harness Developer Hub](https://developer.harness.io/)

## Contributing
Feel free to fork the repository and submit pull requests. You can also open issues if you find any bugs or have suggestions for improvements.

## Contact Information
For questions or support regarding this workshop, please contact [jtitra@harness.io](mailto:jtitra@harness.io).
