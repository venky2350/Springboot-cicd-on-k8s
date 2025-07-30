#!/bin/bash

set -e

# Input
IMAGE_NAME=${IMAGE_NAME:-"venkatesh384/jenkins-demo:latest"}
REPORT_DIR="../trivy-reports"

mkdir -p "${REPORT_DIR}"

echo "📄 Running Trivy scan for image: ${IMAGE_NAME}"

# Text report
trivy image --no-progress -f table -o "${REPORT_DIR}/image-scan-report.txt" "${IMAGE_NAME}"

# JSON report
trivy image --no-progress -f json -o "${REPORT_DIR}/report.json" "${IMAGE_NAME}"

# SARIF report
trivy image --no-progress -f sarif -o "${REPORT_DIR}/report.sarif" "${IMAGE_NAME}"

# HTML conversion
if command -v sarif-multitool &>/dev/null; then
  sarif-multitool rewrite --inline "${REPORT_DIR}/report.sarif" \
    | sarif-multitool view --output "${REPORT_DIR}/trivy-report.html"
  echo "✅ HTML report generated at ${REPORT_DIR}/trivy-report.html"
else
  echo "⚠️ SARIF multitool not found — skipping HTML generation"
fi
