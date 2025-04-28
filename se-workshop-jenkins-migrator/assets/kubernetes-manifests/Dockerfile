FROM jenkins/jenkins:2.492.3-lts-jdk21

# Switch to root to install plugins
USER root

# Install plugins with specific versions
RUN jenkins-plugin-cli --plugins \
    bouncycastle-api \
    credentials \
    jackson2-api \
    okhttp-api \
    pipeline-build-step \
    pipeline-model-definition \
    pipeline-stage-step \
    plain-credentials \
    scm-api \
    workflow-basic-steps \
    workflow-cps \
    workflow-durable-task-step \
    workflow-job \
    workflow-multibranch \
    github \
    git \
    job-dsl \
    matrix-project \
    jackson2-api \
    docker-workflow \
    kubernetes

# Install Harness Migration plugin from URL
RUN curl -L -o /usr/share/jenkins/ref/plugins/harnessmigration.hpi https://github.com/harness-community/jenkins-migration-binary/releases/download/3.3.4/harnessmigration-3.3.4.hpi

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install prerequisites (Git and curl for downloading binary)
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download convert-server binary and make it executable
RUN curl -L -o /usr/local/bin/convert_server_amd64 https://github.com/harness-community/jenkins-migration-binary/raw/main/convert-server-binaries/convert_server_amd64 && \
    chmod +x /usr/local/bin/convert_server_amd64

# Add Jenkins user to the docker group (GID 999 to match DIND container)
RUN groupadd -g 999 docker && usermod -aG docker jenkins

# Switch back to Jenkins user
#USER jenkins
