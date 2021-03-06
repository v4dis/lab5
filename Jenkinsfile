pipeline {
    agent any
    stages {
	stage('Checkout') {
	    steps {
		git 'https://github.com/v4dis/lab5.git'
            }
        }
	/* Fungerar inte på ithsjenkins-servern
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
	*/
	stage('Maven Build & Test') {
	    steps {
		sh 'mvn -B clean'
	    	sh 'mvn -B compile'
		sh 'mvn -B test'
            }
	}
        stage('Maven Rapport') {
            steps {
		sh 'mvn -B cobertura:cobertura -Dcobertura.report.format=xml'
            }
	    post {
		always {
		    cobertura coberturaReportFile: 'target/site/cobertura/*.xml'
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
