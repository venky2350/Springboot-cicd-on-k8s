#!/bin/bash
set -e

SONAR_HOST="http://54.162.210.95:9000"
PROJECT_KEY="Springboot-cicd-on-k8s"
AUTH_HEADER="Authorization: Bearer $SONAR_TOKEN"

echo "📡 Fetching latest analysis ID..."
analysisId=$(curl -s -H "$AUTH_HEADER" "$SONAR_HOST/api/project_analyses/search?project=$PROJECT_KEY" | jq -r '.analyses[0].analysis')

if [ -z "$analysisId" ]; then
  echo "❌ Failed to retrieve analysisId"
  exit 1
fi

echo "📥 Downloading HTML report..."
mkdir -p target/sonar-report
curl -s -H "$AUTH_HEADER" "$SONAR_HOST/api/report/report?analysisId=$analysisId" -o target/sonar-report/index.html

echo "✅ Sonar HTML report saved to target/sonar-report/index.html"
