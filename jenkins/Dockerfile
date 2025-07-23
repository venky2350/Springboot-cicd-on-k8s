FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y docker.io

# Optional: clean up to reduce image size
RUN apt-get clean

USER jenkins
