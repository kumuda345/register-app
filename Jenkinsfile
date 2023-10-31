pipeline{

    agent any  //if i want to run this on agent we can specify  { label 'jenkin-agent'}

    tools {
       jdk 'jdk'
       maven 'maven'

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
      


    }


}
