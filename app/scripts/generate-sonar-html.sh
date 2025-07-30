#!/bin/bash

# This script generates an HTML report from the SonarQube analysis
# Requires sonar-report plugin enabled on your SonarQube server

set -e

# Variables
SONAR_HOST_URL="http://<your-sonarqube-host>:9000"
SONAR_PROJECT_KEY="jenkins-demo"
SONAR_TOKEN="sqp_6c15a28dd79bf8a9b25f0975f29eae5fdc325db3"  # Replace with your actual token
REPORT_DIR="target/sonar-reports"

# Create report directory
mkdir -p $REPORT_DIR

# Generate report using sonar-report API or download it if enabled
curl -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/report/export_html?projectKey=$SONAR_PROJECT_KEY" \
  -o "$REPORT_DIR/sonar-report.html"

if [ $? -eq 0 ]; then
  echo "✅ SonarQube HTML report saved to $REPORT_DIR/sonar-report.html"
else
  echo "❌ Failed to generate SonarQube HTML report"
fi
