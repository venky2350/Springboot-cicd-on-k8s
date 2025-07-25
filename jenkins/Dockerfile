FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y curl gnupg2 lsb-release sudo
RUN curl -fsSL https://get.docker.com | bash

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

USER jenkins
