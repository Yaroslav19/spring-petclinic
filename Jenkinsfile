pipeline {
    agent any

    stages {
        stage('Initialize') {
            steps {
                script {
                    env.PATH = "${env.PATH}:/usr/local/bin:/usr/bin:/usr/sbin:/sbin"
                    echo env.PATH
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Git checkout'
                git url: 'https://github.com/Yaroslav19/spring-petclinic/', branch: 'SDP-Continuous-Delivery-and-CI', credentialsId: 'github'

                echo 'Build docker image'
                script {
                    dockerImage = docker.build("gimbarr1717/yaroslav-repos:${env.BUILD_ID}")
                }
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'login', passwordVariable: 'password')]) {
                    sh """
                        docker login -u ${login} -p ${password}
                        docker push gimbarr1717/yaroslav-repos:${env.BUILD_ID}
                        docker push gimbarr1717/yaroslav-repos:latest
                    """
                }
            }
        }
    }
}
