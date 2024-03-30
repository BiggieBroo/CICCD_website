#!/usr/bin/env groovy
package com.classes

class Docker implements Serializable {
	def script
	
	Docker(script) {
		this.script = script
	}

	def dockerLogin() {
		script.withCredentials([script.usernamePassword(credentialsId: 'docker', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
			script.sh "echo $script.PASS | docker login -u $script.USER --password-stdin"
		}
	}

	def buildDockerImage(String imageName) {
		script.sh "docker build -t $imageName ."
	}

	def dockerPush(String imageName) {
		script.sh "docker push $imageName"
	}

}