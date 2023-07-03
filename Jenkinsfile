pipeline {
    agent any 
    stages {
        stage("Checkout"){
            steps{
                git branch: 'main', url: 'https://github.com/dhanbdrkarki1/calculator-pipeline.git'
            }
        }
        stage("Compile"){
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test") {
            steps {
                sh "./gradlew test"
               }
          }
    }
}

