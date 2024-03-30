library identifier: 'CICD_website@jenkins-shared-library', retriever: modernSCM([$class: 'GitSCMSource', remote: 'https://github.com/BiggieBroo/CICD_website', credentialsId: 'github'])

pipeline {

	agent any

	// Environment 
	environment {
		IMAGE_TITLE = "biggiebroo/practice:web:1.0"
		AWS_ACCESS_KEY_ID = credentials("aws_access_key_id")
		AWS_SECRET_ACCESS_KEY = credentials("aws_secret_access_key")
		DOCKER_CREDENTIALS = credentials('docker')
		TFVAR_env = "dev"
	}

	
	stages {

		stage("Docker Login, Build Image and Push into Hub") {
			steps {
				script {
					dockerLogin()
					buildDockerImage("${IMAGE_TITLE}")
					dockerPush("${IMAGE_TITLE}")
				}
			}
		} // Docker Login, Build Image and Push into Hub

		stage("Build AWS Server with Terraform") {
			steps {
				script {
					dir("terraform") {
						sh "terraform init"
						sh "terraform apply -auto-approve"
						SERVER_IP = sh(
							script: "terraform output 'ec2_public_ip'",
							returnStdout: true
						).trim()
					}
				}
			}
		} // end Build AWS Server with Terraform

		stage("Deployment on AWS") {
			steps {
				script {
					sleep(time: 120, units: 'SECONDS')
					def connectionToServer = "ec2-user@${SERVER_IP}"
					def cmdScript = "bash ./script.sh ${IMAGE_TITLE} ${DOCKER_CREDENTIALS.username()} ${DOCKER_CREDENTIALS.password()}"
					sshagent(["aws_server"]) {
						sh "scp -o StrictHostKeyChecking=no script.sh ${connectionToServer}"
						sh "scp -o StrictHostKeyChecking=no site-compose.yaml ${connectionToServer}"
						sh "ssh -o "
					}
				}
			}
		} // end Deployment on AWS

	} // end stages

} // end pipeline