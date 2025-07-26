FROM jenkins/jenkins:lts

USER root

# Install basic packages
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Install Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Install kubectl (latest stable)
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && sudo mv kubectl /usr/local/bin/kubectl

# Add Jenkins user to docker group
RUN usermod -aG docker jenkins

USER jenkins
