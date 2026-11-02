pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image from the Dockerfile in the workspace
                sh 'docker build -t java-hello-world:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the container locally and check output (--rm removes container after exit)
                sh 'docker run --rm java-hello-world:latest'
            }
        }
    }
}
