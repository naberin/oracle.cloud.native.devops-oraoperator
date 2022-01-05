// frontend docker image
// initialized by build
// used in push
def frontend = ""

pipeline {
    agent any
    environment {
        region = "iad"
        img = "${region}.ocir.io/orasenatdoracledigital01/react-express-native:dev"
        registry = "https://${region}.ocir.io"

        ocir_credential_id = "ocir-orasenatdoracledigital01"
        
        repository_url = 'https://github.com/naberin/oracle.devops.jenkins.sample'
        repository_branch = 'main'
    }


    
    stages {
        stage("checkout-latest") {
            steps {
                git branch: repository_branch, url: repository_url
            }
        }
        stage("image-build") {
            steps {
                script {
                    dir("frontend") {
                        frontend = docker.build(img)
                    }
                }
            }
        }
        stage("image-push") {
            steps {
                script {
                    docker.withRegistry(registry, ocir_credential_id) {
                        frontend.push()
                    }
                }
            }
        }
        stage("image-cleanup") {
            steps {
                script {
                    sh "docker rmi $img"
                }
            }
        }

    }
}
