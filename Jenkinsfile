pipeline {
    agent any
    stages {
	stage('Checkout') {
	    steps {
		git 'https://github.com/v4dis/lab5.git'
            }
        }
	stage('Docker build & test'){
	    agent {
    	    	docker {
	  	    image 'maven:3-alpine'
	  	    args '-v $HOME/.m2:/root/.m2'
	  	}
	    }
	    steps {
	    	sh 'mvn -B compile'
		sh 'mvn -B test'
            }

	    
	}
	stage('Maven Build') {
	    steps {
	    	sh 'mvn -B compile'
            }
	}
        stage('Maven Test') {
            steps {
                //sh 'mvn -B test cobertura:cobertura'
		sh 'mvn -B cobertura:cobertura'
            }
	    post {
		always {
		    cobertura coberturaReportFile: '/cobertura.xml'
		}
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
                sh 'robot -d robot/results --include negative --variable BROWSER:headlessfirefox robot/car.robot'
            }
            post {
                always {
                script {
                    step(
			[
                            $class              : 'RobotPublisher',
                            outputPath          : 'robot/results',
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
