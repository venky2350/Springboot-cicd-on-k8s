#!/bin/bash
# app/scripts/generate-sonar-html.sh

set -e

SONAR_HOST="http://54.162.210.95:9000"
PROJECT_KEY="Springboot-cicd-on-k8s"
SONAR_TOKEN="sqp_769b23655fcfe48703da63bfa408319399a380e9"
REPORT_DIR="target/sonar-report"

mkdir -p "$REPORT_DIR"

curl -s -u "$SONAR_TOKEN": \
  "$SONAR_HOST/api/issues/search?componentKeys=$PROJECT_KEY&types=BUG,VULNERABILITY,CODE_SMELL" \
  -o "$REPORT_DIR/report.json"

echo "✅ Sonar report generated at $REPORT_DIR/report.json"
