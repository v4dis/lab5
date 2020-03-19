pipeline {
    agent any
        stages {
	    stage('Checkout') {
	        steps {
		    git 'https://github.com/v4dis/fooproject.git'
                      }
            }
            stage('Build') {
                steps {
                    sh "mvn compile"
                }
            }
            stage('Test') {
                steps {
                    sh "mvn test"
                }
	    }
            stage('newman') {
	    	steps {
		    sh 'newman run c.json --environment e.json --reporters junit'
            }
            post {
                always {
                        junit '**/*xml'
                    }
                }
        }

        }
    post {
         always {
            junit '**/TEST*.xml'
            emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
            body: 'Bod-DAy!', recipientProviders: [culprits()], subject:
            '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'
         }
    }
}
