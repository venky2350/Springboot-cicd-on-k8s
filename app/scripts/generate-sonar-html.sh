#!/bin/bash
set -e

# CONFIG: Update with your actual values
SONAR_HOST_URL="http://54.162.210.95:9000"
SONAR_TOKEN="sqp_769b23655fcfe48703da63bfa408319399a380e9"
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
