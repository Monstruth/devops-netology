pipeline {
    agent {
        label 'linux'
    }
    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: '70aa877d-05d0-46e9-b370-2e502e75c01f', url: 'git@github.com:perepelitsyn-alexei/clickhouse.git'
            }
        }
        stage ('Run molecule') {
            steps {
                sh 'molecule test'
                cleanWs()
            }
        }
    }
}
