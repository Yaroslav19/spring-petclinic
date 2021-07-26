pipeline {
    environment {
        //registry = "gimbarr1717/yaroslav-repos"
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
                git url: 'https://github.com/Yaroslav19/spring-petclinic.git', branch: 'SDP-task3', credentialsId: 'github'

                bat "mvn clean package"

                script {
                    dockerImage = docker.build("gimbarr1717/yaroslav-repos:${env.BUILD_ID}")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Publish') {
            steps {
                script {
                    env.PRODUCT_SERVICE_TAG = "${env.BUILD_ID}"
                    kubernetesDeploy configs: 'k8s-manifest/spring-petclinic/*', kubeconfigId: 'docker-desktop'
                }
            }
        }
    }
}
