pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-java-app'
        CONTAINER_NAME = 'java-app-container'
        APP_PORT = '8080'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Java Application') {
            steps {
                // Using Maven wrapper or standard mvn command to build the JAR
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the current Jenkins build number as a tag
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                    // Also tag it as latest for convenience
                    sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Clean up any existing container with the same name to avoid port/name conflicts
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Run the container locally on the Jenkins server, mapping port 8080
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Verify Container Output') {
            steps {
                script {
                    // Wait a few seconds for the Java application to fully start up
                    sleep 5

                    // 1. Inspect container logs to verify startup logs
                    sh "docker logs ${CONTAINER_NAME}"

                    // 2. Perform an HTTP check to verify the service is responding (adjust endpoint as needed)
                    // If it's a Spring Boot app with Actuator: http://localhost:8080/actuator/health
                    sh "curl -f http://localhost:${APP_PORT}/ || exit 1"
                }
            }
        }
    }

    post {
        always {
            // Optional: Clean up dangling images or perform post-build actions
            echo 'Pipeline execution finished.'
        }
        failure {
            // Optional: Print logs if the container failed to start properly
            sh "docker logs ${CONTAINER_NAME} || true"
        }
    }
}
