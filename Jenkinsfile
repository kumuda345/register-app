pipeline{

    agent any  //if i want to run this on agent we can specify  { label 'jenkin-agent'}

    tools {
       jdk 'jdk'
       maven 'maven'
       
    }
    environment {
         APP_NAME = "app1 "
         RELEASE_NO = " 1.0.0"
         DOCKER_USER = "kumuda0707"
         DOCKER_PASS = "docker-cred"
         IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
         IMAGE_TAG = " ${RELEASE_NO}.${BUILD_NUMBER}"
        
    }

   
    stages{
      stage ("1.Cleanup Ws") {
        steps {
            cleanWs()

        }

      }
      stage ( "2.Git Checkout") {
        steps {
            git branch: 'main', credentialsId: 'git_cred', url: 'https://github.com/kumuda345/register-app.git'
        }
        
      }
      stage ( "3. Maven package") {
        steps {
           sh 'mvn clean install -DskipTests=true'
        }
        
      }
       stage ( "5.Sonar Code Analysis") {
        steps {
           script {
               withSonarQubeEnv(credentialsId: 'sonar-token' ) {
               sh "mvn sonar:sonar"
               }
           }
         }
       }  
       stage("6.Quality Gate"){
           steps {
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }   
            }

       }
        stage ( "7.Docker build and push") {
          steps {
               script {
                withDockerRegistry(credentialsId: 'docker-cred') {
                sh "docker buildx build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                sh "docker push ${IMAGE_NAME}:latest"

                
            }
         }
       }
      }

        
 }
}
