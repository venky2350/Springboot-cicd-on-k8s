#!/bin/bash
# Ensure Node.js is installed and sonar-report is globally available

# Install sonar-report if not already installed
npm install -g sonar-report

# Generate the report
sonar-report \
  -k "Springboot-cicd-on-k8s" \
  -t "sqp_769b23655fcfe48703da63bfa408319399a380e9" \
  -u "http://54.162.210.95:9000" \
  -o "target/sonar-report"

echo "SonarQube HTML report generated at: target/sonar-report/index.html"
