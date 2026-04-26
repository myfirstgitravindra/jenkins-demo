pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ACCOUNT_ID = '528133971227'
        REPO_NAME = 'myapp'
        ECR_REPO = '528133971227.dkr.ecr.us-east-1.amazonaws.com/myapp'
        IMAGE_TAG = 'n1'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'git-hub',
                url: 'https://github.com/myfirstgitravindra/jenkins-demo'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${REPO_NAME} ."
            }
        }

        stage('Tag Image') {
            steps {
                sh "docker tag ${REPO_NAME}:latest ${ECR_REPO}:${IMAGE_TAG}"
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh "docker push ${ECR_REPO}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                docker stop myapp || true
                docker rm myapp || true
                docker pull $ECR_REPO:$IMAGE_TAG
                docker run -d -p 5000:5000 --name myapp $ECR_REPO:$IMAGE_TAG
                '''
            }
        }
    }
}
