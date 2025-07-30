#!/bin/bash
set -e

# CONFIG
SONAR_HOST_URL="http://44.203.182.235:9000"
SONAR_TOKEN="sqp_6c15a28dd79bf8a9b25f0975f29eae5fdc325db3"
PROJECT_KEY="Springboot-cicd-on-k8s"
REPORT_DIR="target/sonar-report"  

mkdir -p "$REPORT_DIR"

# Call SonarQube API to get issues
curl -s -u "$SONAR_TOKEN:" "$SONAR_HOST_URL/api/issues/search?componentKeys=$PROJECT_KEY" | \
jq '.' > "$REPORT_DIR/raw-sonar-report.json"

# Basic HTML output
jq -r '
  "<html><head><title>SonarQube Report</title></head><body><h1>Issues Report</h1><ul>" +
  (.issues[] | "<li><b>\(.severity)</b>: \(.message) (<i>\(.component)</i>)</li>") +
  "</ul></body></html>"
' "$REPORT_DIR/raw-sonar-report.json" > "$REPORT_DIR/index.html"    

echo "✅ HTML report generated at: $REPORT_DIR/index.html"
