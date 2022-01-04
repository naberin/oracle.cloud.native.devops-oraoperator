pipeline {
    agent any
    
    parameters {
        string(name: 'Greeting'), defaultValue: 'Hello', description: 'How should I greet?'
    }

    stages {
        stage("hello") {
            steps {
                echo "${params.Greeting} World!"
                ls -lah
                
            }
        }
    }
}