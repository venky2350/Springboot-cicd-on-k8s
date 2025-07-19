# CI/CD Pipeline for Spring Boot Microservice using Jenkins, Argo CD, Helm & Trivy on Kubernetes

![CI/CD Architecture](./assets/architecture-diagram.png)

This project implements a secure and automated CI/CD pipeline for a Spring Boot microservice. It includes:

* **Jenkins** for CI/CD orchestration
* **Docker** for containerization
* **SonarQube** for static code analysis
* **Trivy** for image vulnerability scanning
* **Argo CD** for GitOps deployment
* **Helm** for multi-container Kubernetes deployment
* **NGINX** for reverse proxy and browser routing
* **Kubernetes** (EKS-ready) as the deployment platform

### 🔁 Flow Summary

1. Developer commits code to GitHub.
2. Jenkins triggers build, test, scan, and image creation.
3. SonarQube checks code quality.
4. Trivy scans Docker image for vulnerabilities.
5. Docker image pushed to registry.
6. Argo CD pulls updated manifests and deploys to Kubernetes.
7. NGINX routes requests to `/app`, `/admin`, and `/reports`.
8. Users access app via browser.

> ✅ Final Output: Secure, production-grade Spring Boot app running on Kubernetes with full DevOps automation.



## Project Folder Architecture:
-------------------------------
Springboot-cicd-on-k8s
├── app/                             ← Spring Boot application
│   ├── src/
│   │   └── main/
│   │       ├── java/com/example/
│   │       │   ├── HelloJenkinsApplication.java   ← Main Spring Boot class
│   │       │   └── WebController.java            ← UI Controller
│   │       └── resources/
│   │           ├── static/
│   │           │   └── tech-stack.png             ← Tech stack image
│   │           ├── templates/
│   │           │   └── index.html                 ← HTML UI with message + image
│   │           └── application.properties         ← Spring config
│   ├── pom.xml                     ← Maven dependencies
│   └── Dockerfile                 ← Dockerize Spring Boot app
│
├── nginx/                           ← Nginx reverse proxy config & content
│   ├── Dockerfile                   ← Builds image with embedded routes/reports
│   ├── default.conf                 ← Nginx routing config (/app, /admin, /reports)
│   ├── index.html                  ← Admin dashboard (HTML)
│   └── reports/
│       ├── trivy-report.txt         ← CLI scan report
│       ├── sonar-report.html        ← Optional HTML output
│       └── image-scan.json          ← Trivy JSON vulnerability output
│
├── jenkins/
│   ├── Jenkinsfile                 ← CI/CD pipeline (Build + Sonar + Trivy + Argo CD)
│   └── scan-trivy.sh              ← Shell script to scan image & fail on criticals
│
├── sonar/
│   └── sonar-project.properties    ← Sonar project config
│
├── manifests/                      ← Kubernetes YAML (manual deployment)
│   ├── deployment.yaml             ← Spring Boot K8s deployment
│   ├── service.yaml                ← NodePort/LoadBalancer access
│   └── nginx.yaml                  ← Nginx K8s deployment + service
│
├── jenkins-demo-chart/             ← Helm chart for Spring + Nginx
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── spring-deployment.yaml
│       ├── spring-service.yaml
│       ├── nginx-deployment.yaml
│       ├── nginx-service.yaml
│       ├── configmap-nginx.yaml
│       └── ingress.yaml            ← Handles /app, /admin, /reports routing
│
├── .github/                        ← CI/CD workflows for Docker builds
│   └── workflows/
│       └── docker-nginx.yml        ← GitHub Actions: auto build/push Nginx
│
├── README.md                       ← Project overview, architecture, setup
├── .gitignore                      ← Ignore target/, logs, reports, secrets
