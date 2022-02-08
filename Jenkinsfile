// frontend docker image
// initialized by build
// used in push
def frontend = ""

pipeline {
    agent any
    environment {
        docker_region = "phx"
        docker_img = "${docker_region}.ocir.io/orasenatdoracledigital01/oracicd/frontend-react:1.0"
        docker_registry = "https://${docker_region}.ocir.io"
        docker_credential_id = "ocir-orasenatdoracledigital01"
        
        repository_url = 'https://github.com/naberin/oracle.cloud.native.devops-oraoperator.git'
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
                    dir("app-react-test") {
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

        stage("push to") {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '', 
                    clusterName: 'cluster-cgcf6dpb4iq', 
                    contextName: '', 
                    credentialsId: 'kubeconfig-sa', 
                    namespace: 'kube-system', 
                    serverUrl: 'https://152.70.148.78:6443'
                    ]]) {
                        script {
                            dir("deploy/manifests/frontend") {
                                sh 'kubectl config set-context --current --namespace=default'
                                sh 'kubectl set image deployment/odjs-test-frontend ${docker_img}'
'
                        }
                    }
                }
            }
        }

    }
}
