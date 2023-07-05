pipeline {
    agent any

    // triggers {
    //     pollSCM('* * * * *')
    // }

    environment {     
        DOCKERHUB_CREDENTIALS= credentials('dockerhubcredentials') 
        SLACK_CREDENTIALS=credentials('cynicalslackcredentials')    
    } 

    stages {
        stage("Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/dhanbdrkarki1/calculator-pipeline.git'
            }
        }

        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }

        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }

        stage("Code Coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                publishHTML(target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Report',
                    reportTitles: 'Dhan Report'
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }

        stage("Static Code Analysis") {
            steps {
                sh "./gradlew checkstyleMain"
                publishHTML(target: [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: 'CheckStyle Report'
                ])
            }
        }

        stage("Package"){
            steps{
                sh "./gradlew build"
            }
        }

        stage("Docker build"){
            steps{
                sh "docker build -t dhan007/calculator ."
                echo "Build completed..."
            }
        }

        stage("Docker login"){
            steps{
                // withCredentials([usernamePassword(credentialsId: dockerhubcredentials, passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR')]) {
                //     sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin <<< "$DOCKERHUB_CREDENTIALS_PSW"'
                //     echo 'Login completed...'
                // }

                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                echo 'Login completed...'
            }
        }

        stage("Docker Push"){
            steps{
                sh "docker tag $DOCKERHUB_CREDENTIALS_USR/calculator $DOCKERHUB_CREDENTIALS_USR/calculator:$BUILD_NUMBER"
                sh "docker push $DOCKERHUB_CREDENTIALS_USR/calculator:$BUILD_NUMBER"
                echo "push completed"
            }
        }

        stage("Staging"){
            steps{
                sh "docker run -it --rm -d -p 8765:8080 --name calculator $DOCKERHUB_CREDENTIALS_USR/calculator:$BUILD_NUMBER"
                sh "docker ps"
            }
        }

        stage("Acceptance Test"){
            steps{
                sleep 15
                sh "chmod u+x ./acceptance-test.sh"
                sh "./acceptance-test.sh"
            }
        }
    }

    post {
        always{
            // mail(to: 'dhanbdrkarki111@gmail.com', subject: "Completed Pipeline: ${currentBuild.fullDisplayName}", body: "Your build completed, please check: ${env.BUILD_URL}")
            // slack integration
            slackSend( 
                channel: "#jenkins", 
                color: "good", 
                message: "${custom_msg()}")
        }
    }
}

def custom_msg()
{
  def JENKINS_URL= "localhost:8080"
  def JOB_NAME = env.JOB_NAME
  def BUILD_ID= env.BUILD_ID
  def JENKINS_LOG= " FAILED: Job [${env.JOB_NAME}] Logs path: ${JENKINS_URL}/job/${JOB_NAME}/${BUILD_ID}/consoleText"
  return JENKINS_LOG
}
