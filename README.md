# CI/CD Pipeline for Spring Boot Microservice using Jenkins, Argo CD, Helm & Trivy on Kubernetes

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
8. Users access the app via a browser.

> ✅ Final Output: Secure, production-grade Spring Boot app running on Kubernetes with full DevOps automation.

## Project Folder Architecture:
-------------------------------

```bash

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
│   ├── Dockerfile                   ← : Builds image with embedded routes/reports
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


## ASCII Art Version (For Quick Overview):
-------------------------------------------

+-------------------------------------------------------+
|       CONTINUOUS DELIVERY (JENKINS + HELM + ARGOCD)   |
+-------------------------------------------------------+
|                                                       |
|  JENKINS PIPELINE                                     |
|  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐   |
|  │ BUILD   │→ │SONARQUBE│→ │ TRIVY   │→ │ ARGOCD  │   |
|  │ (Maven) │  │(Quality)│  │ (CVE)   │  │ (Deploy)│   |
|  └─────────┘  └─────────┘  └─────────┘  └─────────┘   |
|            ↓              ↓              ↓            |
|  ┌───────────────────────────────────────────────┐    |
|  │               QUALITY GATES                  │     |
|  │  - Sonar: Coverage ≥80%                      │     |
|  │  - Trivy: 0 Critical CVEs                    │     |
|  └───────────────────────────────────────────────┘    |
|                                                       |
+-------------------------------------------------------+
           ↓
+-------------------------------------------------------+
|               KUBERNETES CLUSTER                      |
|  ┌─────────────────┐        ┌─────────────────┐       |
|  │ SPRING BOOT POD │←──────→│ NGINX POD       │       |
|  │ (app:8080)      │ Ingress│ (admin/reports) │       |
|  └─────────────────┘        └─────────────────┘       |
+-------------------------------------------------------+
## TECH STACK:
   -----------
┌───────────────────────────────────────────────────────────────────────----┐ 
│                           TECH STACK                                      │
├───────────────────┬───────────────────┬───────────────────┬────────────---┤
│    Backend        │    DevOps         │      CI/CD        │ Cloud Services│
├───────────────────┼───────────────────┼───────────────────┼────────────---|
│  • Java           │  • Docker         │  • GitHub         │  • AWS EC2    │
│  • Spring Boot    │  • Jenkins        │  • GitHub Actions │  • AWS EKS    │
│  • Maven          │  • SonarQube      │  • Helm           │               │
│  • Thymeleaf      │  • Trivy          │  • Argo CD        │               │
├───────────────────┴───────────────────┴───────────────────┴────────────---|
│                                                                           │
│  Platform & Infrastructure: Kubernetes, Nginx, Ingress                    │
│                                                                           |
└───────────────────────────────────────────────────────────────────────----┘

##Run an application on browser in local environment:
------------------------------------------------------
*Create an ec2 instance in AWS cloud
       >name   : Springboot-cicd-on-k8s
       >os     : ubuntu
       >instance: t2.large
       >key pair : Prometheus.pem
       >Network settings: port - 8080
*connect server through an ec2 instance via git bash
        >   chmod 400 "Prometheus.pem"  
        > ssh -i "Prometheus.pem" ubuntu@ec2-3-86-177-86.compute-1.amazonaws.com
*Clone the project repository from GitHub 
         > git clone <repository url></repository>
         > root@ip-172-31-95-129:~/Springboot-cicd-on-k8s/app# 
         > apt update -y
         > apt install maven -y
         > apt install openjdk-17-jdk -y
         > apt install docker.io -y
         > mvn clean package
         > java -jar target/jenkins-demo-1.0.0.jar



##Trouble Shooting:
-------------------
#1) Thanks for sharing. Your system has a conflicting Java environment:

🔍 Summary of current issue:
java is pointing to OpenJDK 21

javac (the Java compiler) is pointing to JDK 17

But your Maven build uses javac --release 17, and this mismatch can cause errors if javac and java are not aligned properly.

sudo update-alternatives --config java

/usr/lib/jvm/java-17-openjdk-amd64/bin/java

java -version
javac -version

openjdk version "17.0.x"
javac 17.0.x

 Then retry:

 mvn clean package
#2)app(Dockerfile):
>vi Springboot-cicd-on-k8s/app/Dockerfile

FROM openjdk:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/jenkins-demo-1.0.0.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]


>Build Docker image:
cd ~/Springboot-cicd-on-k8s/app
docker build -t jenkins-demo:latest .

>Run Docker Container:
docker run -d -p 8080:8080 --name springboot-app jenkins-demo:latest

