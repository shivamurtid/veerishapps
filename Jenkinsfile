pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'shivamurtid/my-react-app'  // Replace this
        DOCKER_CREDENTIALS_ID = 'dockerhub'                    // ID set in Jenkins
    }

    stages {

        stage('Checkout Code') {
            steps {
                git url: 'git@github.com:shivamurtid/veerishapps.git', credentialsId: 'github-key'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }

        // Optional: Add deployment step if needed
        // stage('Deploy') {
        //     steps {
        //         echo 'Deploying to server...'
        //         // Use ssh, kubectl, scp etc.
        //     }
        // }
    }

    post {
        success {
            echo 'Build and push completed successfully.'
        }
        failure {
            echo 'Build or push failed.'
        }
    }
}