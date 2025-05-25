pipeline {
    agent any
  
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Frontend Image') {
            steps {
                script {
                    docker.build("${DOCKERHUB_REPO_FRONTEND}:latest", "./frontend")
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    docker.build("${DOCKERHUB_REPO_BACKEND}:latest", "./backend")
                }
            }
        }

        stage('Push Images to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-id') {
                        docker.image("${DOCKERHUB_REPO_FRONTEND}:latest").push()
                        docker.image("${DOCKERHUB_REPO_BACKEND}:latest").push()
                    }
                }
            }
        }

        stage('Run Containers') {
            steps {
                script {
                    sh "docker rm -f frontend || true"
                    sh "docker rm -f backend || true"
                    sh "docker run -d --name frontend -p 8081:80 ${DOCKERHUB_REPO_FRONTEND}:latest"
                    sh "docker run -d --name backend -p 5000:5000 ${DOCKERHUB_REPO_BACKEND}:latest"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
