pipeline {
    agent { label 'prodjenkins' }  // Ensure all stages run on the slave node

    environment {
        scannerHome = tool 'sonar7.0'
    }

    stages {
        stage('Build Application') {
            steps {
                sh 'mvn -f ./pom.xml clean package -DskipTests'
            }
            post {
                success {
                    echo "Now Archiving the Artifacts...."
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn -f pom.xml test'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn -f pom.xml checkstyle:checkstyle'
            }
        }

        stage('Sonar Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=java-tomcat-sample \
                        -Dsonar.projectName=java-tomcat-sample \
                        -Dsonar.projectVersion=4.0 \
                        -Dsonar.sources=src/ \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }

        // Uncomment this section if you want to enable Nexus artifact upload
        /*
        stage('Upload Artifact to Nexus') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '192.168.56.30:8081',
                    groupId: 'QA',
                    version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
                    repository: 'java-application',
                    credentialsId: 'sonartypecredential',
                    artifacts: [
                        [artifactId: 'techaxis-webapp',
                         classifier: '',
                         file: 'target/techaxis-webapp.war',
                         type: 'war']
                    ]
                )
            }
        }
        */

        stage('Create Tomcat Docker Image') {
            steps {
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
                // echo "Building Docker Image"
                // sh '''
                // original_pwd=$(pwd -P)
                // cd .
                // docker-compose build --no-cache
                // cd $original_pwd
                // '''
                 echo "Current Workspace: ${WORKSPACE}"

                // List files to confirm the docker-compose.yml exists
                sh 'ls -alh'

                // Change to the correct directory and run docker-compose
                sh '''
                cd ${WORKSPACE}  # Ensure we're in the correct workspace folder
                docker-compose build --no-cache
                '''
            }
        }

        // Uncomment this section if you want to enable Staging deployment
        /*
        stage('Deploy to Staging Environment') {
            steps {
                echo "Running app on Staging Env"
                sh '''
                docker stop tomcatInstance || true
                docker rm tomcatInstance || true
                docker-compose up -d
                '''
            }
        }
        */

        // Uncomment this section if you want to enable Production deployment
        /*
        stage('Deploy to Production Environment') {
            steps {
                timeout(time: 1, unit: 'DAYS') {
                    input message: 'Approve PRODUCTION Deployment?'
                }
                echo "Running app on Prod Env"
                sh '''
                docker stop tomcatInstanceProd || true
                docker rm tomcatInstanceProd || true
                docker-compose up -d
                '''
            }
        }
        */
    }
    
    post { 
        always { 
            mail to: 'susanstha29@gmail.com',
            subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
            body: "Please go to ${BUILD_URL} and verify the build"
        }
        success {
            mail bcc: '', body: """Hi Team,

Build #$BUILD_NUMBER is successful, please go through the URL:

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: '', from: '', replyTo: '', subject: 'BUILD SUCCESS NOTIFICATION', to: 'susanstha29@gmail.com'
        }
        failure {
            mail bcc: '', body: """Hi Team,
                
Build #$BUILD_NUMBER is unsuccessful, please go through the URL:

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: '', from: '', replyTo: '', subject: 'BUILD FAILED NOTIFICATION', to: 'susanstha29@gmail.com'
        }
    }
}
