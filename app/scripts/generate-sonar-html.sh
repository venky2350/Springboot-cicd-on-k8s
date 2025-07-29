#!/bin/bash
# File: app/scripts/generate-sonar-html.sh

set -e

# Variables
SONAR_HOST_URL="http://54.162.210.95:9000"
PROJECT_KEY="Springboot-cicd-on-k8s"
TOKEN="sqp_769b23655fcfe48703da63bfa408319399a380e9"
REPORT_DIR="target/sonar-report"

# Create directory for report
mkdir -p "$REPORT_DIR"

# Download the sonar-report tool (optional; if using third-party tools)
# wget https://github.com/cnescatlab/sonar-report/releases/download/1.4.0/sonar-report.jar -O sonar-report.jar

# Generate HTML report using API
curl -u "$TOKEN": "$SONAR_HOST_URL/api/issues/search?componentKeys=$PROJECT_KEY&types=BUG,VULNERABILITY,CODE_SMELL" -o "$REPORT_DIR/sonar-report.json"

# Optionally convert to HTML or display as-is
echo "SonarQube JSON report saved at $REPORT_DIR/sonar-report.json"
