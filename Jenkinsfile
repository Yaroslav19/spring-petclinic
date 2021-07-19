pipeline {
    environment {
        registry = "gimbarr1717/yaroslav-repos"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent any
    tools {
        maven "apache-maven-3.6.3"
    }
    stages {
        stage('Build') {
            steps {
                git url: 'https://github.com/Yaroslav19/spring-petclinic.git', branch: 'SDP-task2', credentialsId: 'github'

                bat "mvn -DskipTests clean package"

                echo 'Build docker image'
                script {
                    dockerImage = docker.build("gimbarr1717/yaroslav-repos:${env.BUILD_ID}")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
