pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'maven-app'
        DOCKER_TAG = '21'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                dir('my-app') {
                    sh 'mvn clean compile'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('my-app') {
                    sh 'mvn test'
                }
            }
        }

        stage('Package') {
            steps {
                dir('my-app') {
                    sh 'mvn package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Test Docker Image') {
            steps {
                sh """
                docker run -d --name test-container -p 8080:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}
                sleep 10
                curl -f http://localhost:8080/ || exit 1
                docker stop test-container
                docker rm test-container
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                // Uncomment and configure for your registry
                // sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} your-registry/${DOCKER_IMAGE}:${DOCKER_TAG}"
                // sh "docker push your-registry/${DOCKER_IMAGE}:${DOCKER_TAG}"
                echo 'Docker push skipped - configure registry in this stage'
            }
        }
    }

    post {
        always {
            sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}