#!/usr/bin/env groovy
import com.classes.Docker

def call() {
	return new Docker(this).dockerLogin()
}