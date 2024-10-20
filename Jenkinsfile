pipeline {
    agent { label 'node' }
    
    environment {
        GIT_TOKEN = credentials('github-token')  // 'github-token' is the credential ID for pizza-menu token created
        GIT_REPO = 'https://github.com/HazemSabry/pizza-menu.git'
        DOCKER_IMAGE_FRONT = 'hazem196/pizzafront:latest'
        DOCKER_IMAGE_DB = 'hazem196/pizzadb:latest'
        DOCKER_IMAGE_BACK = 'hazem196/pizzaback:latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub-token'
    }
    
    stages {
        stage('Checkout Code From GitHub') {
            steps {
                script {
                    def repoUrl = "https://${GIT_TOKEN}@github.com/HazemSabry/pizza-menu.git"
                    git branch: 'main', url: repoUrl
                    sh "ls"
                }
            }
            
        }
        
        stage('Build Docker Images') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_FRONT} -f ./Front-end/Dockerfile ./Front-end/"
                    sh "docker build -t ${DOCKER_IMAGE_BACK} -f ./Back-end/Dockerfile ./Back-end/"
                    sh "docker build -t ${DOCKER_IMAGE_DB} -f ./Database/Dockerfile ./Database"
                }
            }
        }
        stage('Push Images to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {

                        // Push Frontend Image
                        try {
                            sh "docker push ${DOCKER_IMAGE_FRONT}"
                        } catch (Exception e) {
                            error "Failed to push frontend image: ${e.message}"
                        }

                        // Push Backend Image
                        try {
                            sh "docker push ${DOCKER_IMAGE_BACK}"
                        } catch (Exception e) {
                            error "Failed to push backend image: ${e.message}"
                        }

                        // Push Database Image
                        try {
                            sh "docker push ${DOCKER_IMAGE_DB}"
                        } catch (Exception e) {
                            error "Failed to push database image: ${e.message}"
                        }
                    }
                }
            }
        }
        stage('Run Application') {
                steps {
                        sh "docker run -dp 27017:27017 ${DOCKER_IMAGE_DB}"
                        sh "docker run -dp 3000:3000 ${DOCKER_IMAGE_BACK}"
                        sh "docker run -dp 3001:80 ${DOCKER_IMAGE_FRONT}" 
                    }
        }          
    }
    
    post {
        always {
            echo 'Pipeline completed!'
        }
    }
            
}
