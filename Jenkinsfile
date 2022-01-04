pipeline {
    agent any
    
    stages {
        stage("build-and-push") {
            steps {
                sh "ls -lah"

                sh "cd frontend"

                docker.withRegistry("iad.ocir.io/orasenatdoracledigital01/react-express-native:dev", "ocir-orasenatdoracledigital01") {

                    def newImage = docker.build("react-express-native:dev")
                    newImage.push()
                }
            }
        }

    }
}