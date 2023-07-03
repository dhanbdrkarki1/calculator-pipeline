pipeline {
    agent any 
    triggers {
        pollSCM('* * * * *')
    }
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

        stage("Static Code Analysis"){
            steps{
                sh "./gradlew checkstyleMain"
                publishHTML (target : [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: 'CheckStyle Report',
                ])
            }
        }
    }
    post {
        always {
            mail to: 'dhanbdrkarki111@gmail.com'
            subject: "Completed Pipeline: ${currentBuild.fullDisplayName}"
            body: " Your build completed, please check: ${env.BUILD_URL}"
        }
    }

}

