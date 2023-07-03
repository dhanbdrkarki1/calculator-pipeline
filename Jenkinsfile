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
        stage("Code Coverage"){
            steps{
                sh "./gradlew jacocoTestReport"
                publishHTML (target : [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Report',
                    reportTitles: 'Dhan Report'
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
    }
}

