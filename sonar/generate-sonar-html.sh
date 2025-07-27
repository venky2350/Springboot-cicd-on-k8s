#!/bin/bash

# === CONFIGURATION ===
SONAR_HOST="http://23.20.105.203:9000"
PROJECT_KEY="Springboot-cicd-on-k8s"
TOKEN="sqp_01f14e2ef5704ad682458e7204539f477ab72578"

# === FETCH SONAR ISSUES (open bugs, vulnerabilities, code smells) ===
echo "Fetching SonarQube issues from $SONAR_HOST..."
response=$(curl -s -u $TOKEN: "$SONAR_HOST/api/issues/search?componentKeys=$PROJECT_KEY&resolved=false&ps=500")

# === CHECK FOR ERRORS ===
if [[ -z "$response" ]]; then
  echo "❌ Failed to fetch data from SonarQube. Exiting."
  exit 1
fi

# === FORMAT HTML REPORT ===
echo "Generating sonar-report.html..."

mkdir -p nginx/reports

cat <<EOF > nginx/reports/sonar-report.html
<!DOCTYPE html>
<html>
<head>
  <title>Sonar Report - $PROJECT_KEY</title>
  <style>
    body { font-family: Arial; padding: 20px; background: #f9f9f9; }
    h1 { color: #333; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ccc; padding: 8px; font-size: 14px; }
    th { background-color: #eee; }
    tr:nth-child(even) { background-color: #f2f2f2; }
    code { background: #eee; padding: 2px 4px; border-radius: 3px; }
  </style>
</head>
<body>
  <h1>🚀 SonarQube Issues Report</h1>
  <p><strong>Project:</strong> $PROJECT_KEY</p>
  <table>
    <tr>
      <th>Type</th>
      <th>Severity</th>
      <th>Component</th>
      <th>Line</th>
      <th>Message</th>
    </tr>
EOF

echo "$response" | jq -c '.issues[]' | while read -r issue; do
  type=$(echo "$issue" | jq -r '.type')
  severity=$(echo "$issue" | jq -r '.severity')
  component=$(echo "$issue" | jq -r '.component')
  line=$(echo "$issue" | jq -r '.line // "N/A"')
  message=$(echo "$issue" | jq -r '.message' | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g')
  echo "    <tr><td>$type</td><td>$severity</td><td><code>$component</code></td><td>$line</td><td>$message</td></tr>" >> nginx/reports/sonar-report.html
done

cat <<EOF >> nginx/reports/sonar-report.html
  </table>
</body>
</html>
EOF

echo "✅ sonar-report.html generated at nginx/reports/sonar-report.html"
