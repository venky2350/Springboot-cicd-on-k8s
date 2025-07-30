#!/bin/bash

echo "🔧 Installing Node.js and SARIF multitool..."

# Install Node.js 18 (recommended for compatibility)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Confirm node and npm
node -v
npm -v

# Install SARIF multitool globally
npm install -g @microsoft/sarif-multitool

# Create trivy folder if not exists
mkdir -p ~/Springboot-cicd-on-k8s/trivy
cd ~/Springboot-cicd-on-k8s/trivy

# Write scan-trivy.sh
cat <<'EOF' > scan-trivy.sh
#!/bin/bash

IMAGE_NAME=${IMAGE_NAME:-"venkatesh384/jenkins-demo:latest"}
REPORT_DIR="../trivy-reports"

mkdir -p "${REPORT_DIR}"

echo "📄 Saving Trivy reports for \$IMAGE_NAME..."

# Text report
trivy image --no-progress -f table -o "\${REPORT_DIR}/image-scan-report.txt" "\$IMAGE_NAME"

# JSON report
trivy image --no-progress -f json -o "\${REPORT_DIR}/report.json" "\$IMAGE_NAME"

# SARIF report for HTML
trivy image --no-progress -f sarif -o "\${REPORT_DIR}/report.sarif" "\$IMAGE_NAME"

# Convert SARIF to HTML
if command -v sarif-multitool &>/dev/null; then
  sarif-multitool rewrite --inline "\${REPORT_DIR}/report.sarif" \
    | sarif-multitool view --output "\${REPORT_DIR}/trivy-report.html"
else
  echo "⚠️ SARIF multitool not found – skipping HTML report."
fi
EOF

chmod +x scan-trivy.sh

echo "✅ Setup complete. Run Jenkins pipeline to generate Trivy HTML reports."
