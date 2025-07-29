#!/bin/bash

# Configuration
SONAR_HOST="http://54.162.210.95:9000"
PROJECT_KEY="Springboot-cicd-on-k8s"
AUTH_TOKEN="sqp_769b23655fcfe48703da63bfa408319399a380e9"

# Generate HTML report
mvn sonar-report:report \
  -Dsonar.report.export.path=target/sonar-report \
  -Dsonar.report.export.format=html \
  -Dsonar.projectKey=Springboot-cicd-on-k8s \
  -Dsonar.projectName='Springboot-cicd-on-k8s' \
  -Dsonar.host.url=http://54.162.210.95:9000 \
  -Dsonar.token=sqp_769b23655fcfe48703da63bfa408319399a380e9

