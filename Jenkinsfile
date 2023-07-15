def tf_command(environment, command) {
    dir("environments/${environment}") {
        sh "AWS_CONFIG_FILE=/var/jenkins_home/.aws/config && AWS_SHARED_CREDENTIALS_FILE=/var/jenkins_home/.aws/credentials terraform ${command}"
    }
}

pipeline {
    agent any
    stages {
        stage('Clean Workspace'){
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('Terraform Init, Plan and Apply') {
            steps {
                script {
                    def environments = sh(returnStdout: true, script: "ls environments").trim().split("\n")
                    for (environment in environments) {
                        echo "Environment: ${environment}"
                        tf_command(environment, 'init')
                        tf_command(environment, 'plan')
                        
                        tf_command(environment, 'apply --auto-approve')
                    }
                }
            }
        }
    }
}
