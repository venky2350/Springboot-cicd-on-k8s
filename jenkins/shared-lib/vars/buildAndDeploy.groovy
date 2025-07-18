def call(Map config = [:]) {
    pipeline {
        agent any

        environment {
            SONARQUBE = 'SonarQube'
            DOCKER_IMAGE = "${config.image}"
        }

        tools {
            maven 'MAVEN_HOME'
            jdk 'JAVA_HOME'
        }

        stages {
            stage('Checkout') {
                steps {
                    git "${config.repo}"
                }
            }

            stage('Build') {
                steps {
                    sh 'mvn clean package'
                }
            }

            stage('Code Analysis') {
                steps {
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh 'mvn sonar:sonar'
                    }
                }
            }

            stage('Trivy Scan') {
                steps {
                    sh 'bash trivy/trivy-scan.sh'
                }
            }

            stage('Docker Build & Push') {
                steps {
                    sh """
                    docker build -t $DOCKER_IMAGE .
                    docker push $DOCKER_IMAGE
                    """
                }
            }

            stage('Deploy to Kubernetes') {
                steps {
                    sh '''
                    kubectl apply -f manifests/namespace.yaml
                    kubectl apply -f manifests/
                    '''
                }
            }
        }
    }
}
