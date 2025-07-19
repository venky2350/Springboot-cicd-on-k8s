#!/bin/bash

# ----------------------------
# Trivy Docker Image Scanner
# ----------------------------

IMAGE_NAME=your-dockerhub-username/jenkins-demo:latest
REPORT_DIR="trivy-reports"
REPORT_FILE="$REPORT_DIR/image-scan-report.txt"

# Ensure report directory exists
mkdir -p "$REPORT_DIR"

echo "🔍 Scanning Docker image: $IMAGE_NAME"
trivy image "$IMAGE_NAME" > "$REPORT_FILE"

if grep -q "CRITICAL" "$REPORT_FILE"; then
    echo "❌ Critical vulnerabilities found in $IMAGE_NAME!"
    echo "----- Report -----"
    cat "$REPORT_FILE"
    exit 1
else
    echo "✅ No critical vulnerabilities found in $IMAGE_NAME."
    echo "Report saved to $REPORT_FILE"
fi
