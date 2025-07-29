#!/bin/bash

set -e

# Define variables
SONAR_HOST_URL="http://54.162.210.95:9000"
SONAR_PROJECT_KEY="Springboot-cicd-on-k8s"
SONAR_TOKEN="sqp_769b23655fcfe48703da63bfa408319399a380e9"

# Create a report output directory
mkdir -p target/sonar-report

# Download sonar-report package and run report generation
docker run --rm \
  -e SONAR_TOKEN=$SONAR_TOKEN \
  -e SONAR_HOST_URL=$SONAR_HOST_URL \
  -e SONAR_PROJECT_KEY=$SONAR_PROJECT_KEY \
  -v "$(pwd)/target/sonar-report:/app/output" \
  ghcr.io/cnescatlab/sonar-report:latest \
  -i html -o /app/output
