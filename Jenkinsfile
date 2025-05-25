pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('docker-hun')  
        DOCKERHUB_REPO_FRONTEND = 'ibr122/devops-app-frontend'
        DOCKERHUB_REPO_BACKEND = 'ibr122/devops-app-backend'
    }

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

        stage('Docker Login') {
            steps {
                script {
                    sh "docker login -u ${DOCKERHUB_USR} -p ${DOCKERHUB_PSW}"
                }
            }
        }

        stage('Push Images') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hun') {
                        docker.image("${DOCKERHUB_REPO_FRONTEND}:latest").push()
                        docker.image("${DOCKERHUB_REPO_BACKEND}:latest").push()
                    }
                }
            }
        }

        stage('Deploy Containers') {
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
