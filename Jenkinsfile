pipeline {
    agent any
    environment {
        region = "iad"
        registry = "${region}.ocir.io/orasenatdoracledigital01/react-express-native:dev"
        credential_id = "ocir-orasenatdoracledigital01"
        image = ""
    }
    
    stages {
        stage("checkout-latest") {
            steps {
                echo 'checking out main from https://github.com/naberin/oracle.devops.jenkins.sample'
                git branch: 'main', credentialsId: 'naberin-github-credentials', url: 'https://github.com/naberin/oracle.devops.jenkins.sample'
            }
        }
        stage("image-build") {
            steps {
                script {
                    image = docker.build(registry)
                }
            }
        }
        stage("image-push") {
            steps {
                script {
                    docker.withRegistry("https://${region}.ocir.io", "ocir-orasenatdoracledigital01") {
                        docker.push()
                    }
                }
            }
        }
        stage("image-cleanup") {
            steps {
                script {
                    sh "docker rmi $registry"
                }
            }
        }

    }
}
