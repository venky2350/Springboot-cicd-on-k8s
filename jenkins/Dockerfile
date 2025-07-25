FROM jenkins/jenkins:lts

USER root

# Install Docker inside the Jenkins container to allow Jenkins to use Docker commands
RUN apt-get update && \
    apt-get install -y docker.io

# Optional: Add Jenkins plugins or additional tools here

USER jenkins
