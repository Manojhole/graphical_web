pipeline {
    agent any

    environment {
        IMAGE_NAME = 'flask-multi-app'
        REPO_URL = 'https://github.com/Manojhole/graphical_web_app.git'
        BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout only main branch
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Containers') {
            steps {
                script {
                    // Stop old containers if they exist
                    ['main-app','app1','app2','app3'].each { name ->
                        sh "docker rm -f ${name} || true"
                    }

                    // Run containers on separate ports
                    sh "docker run -d --name main-app -p 5000:5000 ${IMAGE_NAME} python app.py"
                    sh "docker run -d --name app1 -p 5001:5000 ${IMAGE_NAME} python app1.py"
                    sh "docker run -d --name app2 -p 5002:5000 ${IMAGE_NAME} python app2.py"
                    sh "docker run -d --name app3 -p 5003:5000 ${IMAGE_NAME} python app3.py"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo "All containers are running. Access apps at EC2_PUBLIC_IP:5000-5003"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
