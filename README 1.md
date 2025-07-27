
# 🚀 Spring Boot CI/CD on Kubernetes using Jenkins + Helm + Monitoring

A complete CI/CD DevOps project built using Jenkins, Docker, Helm, Kubernetes (Minikube), GitHub Actions, SonarQube, Trivy, and Nginx reverse proxy — now with Prometheus & Grafana monitoring integration.

---

## 📁 Project Structure

```
Springboot-cicd-on-k8s/
├── app/                            # Spring Boot application
│   ├── src/                        # Java source code
│   └── Dockerfile
├── nginx/
│   ├── nginx.conf                  # Nginx reverse proxy config
│   ├── index.html                  # DevOps dashboard
│   ├── Dockerfile
│   └── reports/                    # HTML & Trivy reports
├── trivy/
│   └── scan-trivy.sh              # Trivy scan script
├── jenkins-demo-chart/            # Helm chart for app + nginx
│   ├── templates/
│   └── values.yaml
├── monitoring/
│   ├── grafana-values.yaml
│   └── prometheus-values.yaml
├── Jenkinsfile
└── README.md
```

---

## ⚙️ Tools & Technologies

| Category         | Tools Used                                         |
|------------------|----------------------------------------------------|
| CI/CD            | Jenkins, GitHub Actions                            |
| SCM              | Git + GitHub                                       |
| Build Tool       | Maven                                              |
| Code Quality     | SonarQube                                          |
| Security         | Trivy                                              |
| Containerization | Docker                                             |
| Orchestration    | Kubernetes (Minikube), Helm                        |
| Monitoring       | Prometheus, Grafana                                |
| Reverse Proxy    | Nginx                                              |
| Reporting        | HTML Reports for SonarQube & Trivy                |

---

## 🛠️ Prerequisites

| Tool              | Version / Link                                      |
|------------------|-----------------------------------------------------|
| Docker            | [Install](https://docs.docker.com/get-docker/)      |
| Minikube          | [Install](https://minikube.sigs.k8s.io/docs/)       |
| kubectl           | [Install](https://kubernetes.io/docs/tasks/tools/)  |
| Helm              | `v3.14.4` → `brew install helm` or use binary      |
| Jenkins (on EC2)  | Pre-installed Jenkins with Maven + JDK + Trivy     |
| SonarQube         | Running on `http://<public-ip>:9000`               |
| DockerHub         | Push credentials set using Jenkins credentials     |

---

## 🚀 Jenkins Pipeline Stages

1. **Checkout Source Code**
2. **Maven Build**
3. **SonarQube Code Analysis**
4. **Sonar HTML Report Generation**
5. **Docker Build + Push (Spring App)**
6. **Trivy Security Scanning**
7. **Copy Reports for Nginx dashboard**
8. **Helm Deployment (Spring Boot + Nginx)**
9. **Nginx Docker Build + Push**

---

## 🔐 Credentials Required in Jenkins

| ID                | Type         | Description                          |
|------------------|--------------|--------------------------------------|
| `dockerhub-creds`| Username/Password | For DockerHub push                  |
| `sonarqube-token`| Secret Text  | SonarQube token for analysis         |

---

## 📄 SonarQube HTML Report

Generated with `curl` + `jq` after SonarQube scan:

```bash
curl -s -u "<TOKEN>:" \
  "http://<sonar-host>:9000/api/issues/search?componentKeys=<project-key>" \
  -o sonar-report.json

# Convert to HTML
echo "<html><body><pre>" > sonar-report.html
cat sonar-report.json | jq '.' >> sonar-report.html
echo "</pre></body></html>" >> sonar-report.html
```

> Output saved in: `nginx/reports/sonar-report.html`

---

## 🛡️ Trivy Security Scan

Located in `trivy/scan-trivy.sh`, this script scans the Docker image:

```bash
trivy image $IMAGE_NAME > ../trivy-reports/image-scan-report.txt
```

> Results saved under: `reports/trivy-report.txt` and `trivy-report.json`

---

## 🧱 Nginx Reverse Proxy

Docker image contains a custom HTML dashboard to access:

- Jenkins
- SonarQube
- Grafana
- Trivy Report
- Sonar HTML Report

➡️ Dashboard URL:

```
http://<NGINX-SERVICE-NODEPORT>
```

---

## 📊 Monitoring Setup with Prometheus & Grafana

### 1. 🛠️ Create `monitoring/` directory

```bash
mkdir -p monitoring
```

### 2. 📄 prometheus-values.yaml

```yaml
server:
  global:
    scrape_interval: 15s
  service:
    type: NodePort
```

### 3. 📄 grafana-values.yaml

```yaml
adminUser: admin
adminPassword: admin123
service:
  type: NodePort
```

### 4. 🚀 Install Prometheus + Grafana using Helm

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

#### Prometheus:

```bash
helm install prometheus prometheus-community/prometheus -f monitoring/prometheus-values.yaml
```

#### Grafana:

```bash
helm install grafana grafana/grafana -f monitoring/grafana-values.yaml
```

### 5. 🔍 Access Monitoring UI

| Tool       | Default Port | Access URL (on Minikube)                 |
|------------|--------------|------------------------------------------|
| Prometheus | 30090        | `http://<minikube-ip>:30090`             |
| Grafana    | 30030        | `http://<minikube-ip>:30030`             |

> Get Minikube IP:

```bash
minikube ip
```

---

## 📦 Helm Deployment

Your Helm chart is in `jenkins-demo-chart/`:

```bash
helm upgrade --install jenkins-demo . \
  --namespace dev --create-namespace \
  --set springApp.image=venkatesh384/jenkins-demo:latest \
  --set nginx.image=venkatesh384/nginx-reverse-proxy:latest
```

---

## ✅ Final Result

You will have:

- Spring Boot app deployed on Kubernetes
- Jenkins building the pipeline
- SonarQube and Trivy reporting
- Dockerized Nginx dashboard with access to reports
- Monitoring via Prometheus & Grafana dashboards

---

## 🧹 Clean Up (Optional)

```bash
helm uninstall jenkins-demo -n dev
helm uninstall prometheus
helm uninstall grafana
minikube delete
```

---

## 📬 Author

**Yendoti Venkateswarlu**  
DevOps Trainee | VCube, Hyderabad  
📧 GitHub: [venky2350](https://github.com/venky2350)  
🐳 DockerHub: [venkatesh384](https://hub.docker.com/u/venkatesh384)

---

## 📌 Note

- You can use this repo as your resume project.
- Feel free to fork and customize for your own use.
