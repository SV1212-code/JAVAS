pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Compile') {
            steps {
                sh 'javac helloworld.java'
            }
        }

        stage('Execute') {
            steps {
                sh 'java helloworld'
            }
        }
    }

    post {
        always {
            sh 'rm -f *.class'
        }
    }
}
