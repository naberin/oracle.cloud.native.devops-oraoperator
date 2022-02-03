// frontend docker image
// initialized by build
// used in push
def frontend = ""

pipeline {
    agent any
    environment {
        docker_region = "phx"
        docker_img = "${docker_region}.ocir.io/orasenatdoracledigital01/oracicd/react-test:1.0"
        docker_registry = "https://${docker_region}.ocir.io"
        docker_credential_id = "ocir-orasenatdoracledigital01"
        
        repository_url = 'https://github.com/naberin/oracle.devops.oraoperator.jenkins'
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
                        frontend = docker.build(docker_img)
                    }
                }
            }
        }
        stage("image-push") {
            steps {
                script {
                    docker.withRegistry(docker_registry, docker_credential_id) {
                        frontend.push()
                    }
                }
            }
        }
        stage("image-cleanup") {
            steps {
                script {
                    sh "docker rmi $docker_img"
                }
            }
        }

    }
}
