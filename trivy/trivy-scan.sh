#!/bin/bash
IMAGE_NAME=your-dockerhub-username/hello-jenkins:latest

echo "🔍 Scanning image: $IMAGE_NAME"
trivy image $IMAGE_NAME > trivy-report.txt

if grep -q "CRITICAL" trivy-report.txt; then
  echo "❌ Vulnerabilities found!"
  cat trivy-report.txt
  exit 1
else
  echo "✅ No critical vulnerabilities."
fi
