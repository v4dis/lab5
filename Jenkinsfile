pipeline {
    agent any
    stages {
	stage('Checkout') {
	    steps {
		git 'https://github.com/v4dis/lab5.git'
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Maven Test') {
            steps {
                sh 'mvn test'
            }
	}
        stage('Newman') {
	    steps {
		sh 'newman run postman/restful_booker.postman_collection.json --environment postman/restful_booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                    junit '**/*xml'
		}
            }
        }
	stage('Robot') {
            steps {
                sh 'robot -d results --include VG_Test --variable BROWSER:headlessfirefox robot/car.robot'
            }
            post {
                always {
                script {
                    step(
			[
                            $class              : 'RobotPublisher',
                            outputPath          : 'results',
                            outputFileName      : '**/output.xml',
                            reportFileName      : '**/report.html',
                            logFileName         : '**/log.html',
                            disableArchiveOutput: false,
                            passThreshold       : 50,
                            unstableThreshold   : 40,
                            otherFiles          : "**/*.png,**/*.jpg",
                        ]
                    )	    
                }
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
