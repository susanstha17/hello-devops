pipeline {
    agent {
        label 'prodjenkins'
    }
    stages {
        stage('Build Application') {
            steps {
                sh 'mvn -f ./pom.xml clean package'
            }
            post {
                success {
                    echo "Now Archiving the Artifacts...."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        stage('Create Tomcat Image') {
            agent {
                label 'prodjenkins'
            }
            steps {
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
                echo "Building docker image"
                sh '''
                original_pwd=$(pwd -P)
                cd .
                docker compose build --no-cache
                cd $original_pwd
                '''
            }
        }
        stage('Deploy to Staging Env') {
            agent {
                label 'prodjenkins'
            }
            steps {
                echo "Running app on staging env"
                sh '''
                docker stop tomcatInstance || true
                docker rm tomcatInstance || true
                docker compose up -d
                '''
            }
        }
        // Uncomment this section if you want to deploy to production
        
        stage('Deploy Production Environment') {
            agent {
                label 'prodjenkins'
            }
            steps {
                timeout(time:1, unit:'DAYS'){
                    input message:'Approve PRODUCTION Deployment?'
                }
                echo "Running app on Prod env"
                sh '''
                docker stop tomcatInstanceProd || true
                docker rm tomcatInstanceProd || true
                docker-compose up -d 
                '''
            }
        }
        
    }
    post { 
        always { 
            mail to: 'susanstha29@gmail.com',
            subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
            body: "Please go to ${BUILD_URL} and verify the build"
        }
        success {
            mail body: """Hi Team,

Build #$BUILD_NUMBER is successful, please go through the URL:

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", subject: 'BUILD SUCCESS NOTIFICATION', to: 'susanstha29@gmail.com'
        }
        failure {
            mail body: """Hi Team,
            
Build #$BUILD_NUMBER is unsuccessful, please go through the URL:

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", subject: 'BUILD FAILED NOTIFICATION', to: 'susanstha29@gmail.com'
        }
    }
}
