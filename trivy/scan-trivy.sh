#!/bin/bash

# ----------------------------
# Trivy Docker Image Scanner
# ----------------------------

IMAGE_NAME=${IMAGE_NAME:-venkatesh384/jenkins-demo:latest}
REPORT_DIR="trivy-reports"
TEXT_REPORT="$REPORT_DIR/image-scan-report.txt"
JSON_REPORT="$REPORT_DIR/report.json"

# Ensure report directory exists
mkdir -p "$REPORT_DIR"

echo "🔍 Scanning Docker image: $IMAGE_NAME"

# Plain text scan output
trivy image "$IMAGE_NAME" > "$TEXT_REPORT"

# JSON output for archiving and integration
trivy image --format json --output "$JSON_REPORT" "$IMAGE_NAME"

if grep -q "CRITICAL" "$TEXT_REPORT"; then
    echo "❌ Critical vulnerabilities found in $IMAGE_NAME!"
    echo "----- Report -----"
    cat "$TEXT_REPORT"
    exit 1
else
    echo "✅ No critical vulnerabilities found in $IMAGE_NAME."
    echo "Reports saved to $TEXT_REPORT and $JSON_REPORT"
fi
