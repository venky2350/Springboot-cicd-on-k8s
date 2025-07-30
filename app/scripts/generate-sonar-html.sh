#!/bin/bash
set -e

# CONFIG: Update with your actual values
SONAR_HOST_URL="http://44.203.182.235:9000/"
SONAR_TOKEN="sqp_6c15a28dd79bf8a9b25f0975f29eae5fdc325db3"
PROJECT_KEY="Springboot-cicd-on-k8s"

# Output directory for HTML report
REPORT_DIR="target/sonar-report"
mkdir -p $REPORT_DIR

# Generate HTML using Dockerized converter
docker run --rm \
  -v "$(pwd)/target:/data" \
  ghcr.io/silentsokolov/sonarqube-report:latest \
  -s "$SONAR_HOST_URL" \
  -t "$SONAR_TOKEN" \
  -k "$PROJECT_KEY" \
  -o "/data/sonar-report"

echo "✅ HTML report generated at: target/sonar-report/index.html"
