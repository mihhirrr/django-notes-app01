pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: "https://github.com/mihhirrr/django-notes-app01.git", branch: "main"
            }
        }
        stage('build') {
            steps {
                sh "docker build -t django-app:latest ."
            }
        }
        stage('Tag image'){
            steps {
                sh "docker tag django-app:latest mihirdongare/django-app:latest"
            }
        }
        stage('Push to dockerhub'){
            steps{
                withCredentials([
                usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )]) {
            sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                docker push mihirdongare/django-app:latest
                '''
                }
            }
        }
        stage('run') {
            steps {
                sh "docker compose up -d"
            }
        }
    }
}

