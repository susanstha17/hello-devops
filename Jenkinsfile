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
                docker build -t localtomcatimg:$BUILD_NUMBER .
                cd $original_pwd
                sh '''
            }
        }
         stage('Deploy to Stagging Env') {
            agent {
                label 'prodjenkins'
            }
            steps {
                echo "Running app on stagging env"
                sh '''
                docker stop tomcatInstanceStaging || true
                docker rm tomcatInstanceStaging || true
                docker run -itd --name tomcatInstanceStaging -p 8085:8080 localtomcatimg:$BUILD_NUMBER
                sh '''
            }
        }
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
                docker run -itd --name tomcatInstanceProd -p 8082:8080 localtomcatimg:$BUILD_NUMBER
                '''
            }
        }
    }
}
