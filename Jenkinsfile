pipeline {
    agent any
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

        stage('Create Tomcat Docker Image') {
            agent {
                label 'prodjenkins'
            }
            steps {
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
                echo "Building Docker Image"
                sh '''
                original_pwd=$(pwd -P)
                cd .
                docker-compose build --no-cache
                cd $original_pwd
                '''
            }
        }

        stage('Deploy to Staging Environment') {
            agent {
                label 'prodjenkins'
            }
            steps {
                echo "Running app on Staging Env"
                sh '''
                docker stop tomcatInstance || true
                docker rm tomcatInstance || true
                docker-compose up -d
                '''
            }
        }

        stage('Deploy to Production Environment') {
            agent {
                label 'prodjenkins'
            }
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
    }
}
