# 🚀 DevOps CI/CD Pipeline Project

## 📌 Project Overview

This project demonstrates a **complete end-to-end DevOps CI/CD pipeline** using Jenkins, Docker, AWS, CloudWatch, and Linux automation.

The system automates:

* Code integration
* Build and containerization
* Deployment on AWS EC2
* Monitoring using CloudWatch
* System automation using shell scripts and cron jobs

---

## 🏗️ Architecture

```
Developer → GitHub → Jenkins → Docker → AWS ECR → EC2 → Container → CloudWatch → Cron Jobs
```

---

## ⚙️ Technologies Used

| Tool          | Purpose               |
| ------------- | --------------------- |
| Jenkins       | CI/CD automation      |
| Docker        | Containerization      |
| AWS EC2       | Application hosting   |
| AWS ECR       | Docker image registry |
| CloudWatch    | Monitoring & logging  |
| Linux         | System operations     |
| Shell Scripts | Automation            |
| Cron Jobs     | Scheduling            |

---

## 🔄 CI/CD Pipeline Flow

1. Developer pushes code to GitHub
2. Jenkins pipeline is triggered (webhook)
3. Code is pulled into Jenkins
4. Docker image is built
5. Image is tagged and pushed to AWS ECR
6. EC2 instance pulls latest image
7. Docker container is deployed
8. Application health check is performed

---

## 🧪 Jenkins Pipeline

```groovy
pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '528133971227.dkr.ecr.us-east-1.amazonaws.com/myapp'
        IMAGE_NAME = 'myapp'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-hub', url: 'https://github.com/myfirstgitravindra/jenkins-demo'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }

        stage('Tag Image') {
            steps {
                sh 'docker tag myapp:latest $ECR_REPO:latest'
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ECR_REPO
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $ECR_REPO:latest'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                docker stop myapp || true
                docker rm myapp || true
                docker pull $ECR_REPO:latest
                docker run -d -p 5000:5000 --name myapp $ECR_REPO:latest
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                docker ps | grep myapp
                curl -f http://localhost:5000 || echo "App not responding"
                '''
            }
        }
    }
}
```

---

## 🐳 Docker Commands

```bash
docker build -t myapp .
docker images
docker ps
docker run -d -p 5000:5000 myapp
docker stop myapp
docker rm myapp
docker system prune -f
```

---

## 🖥️ Linux Commands Used

```bash
top
free -m
df -h
ps -ef
kill -9 <PID>
ping google.com
netstat -tulnp
chmod +x script.sh
```

---

## ⚡ Automation Scripts

### 1. Application Health Check

```bash
docker ps | grep myapp
```

### 2. Disk Monitoring

```bash
df -h /
```

### 3. Network Check

```bash
ping -c 3 google.com
```

---

## ⏱️ Cron Jobs

```bash
*/2 * * * * /home/ec2-user/jenkins-demo/app_health_check.sh >> /home/ec2-user/app.log 2>&1
*/5 * * * * /home/ec2-user/jenkins-demo/disk_alert.sh >> /home/ec2-user/disk.log 2>&1
*/10 * * * * /home/ec2-user/jenkins-demo/basic_net_check.sh >> /home/ec2-user/net.log 2>&1
```

---

## 📊 Monitoring (CloudWatch)

* CPU, Memory, Disk metrics
* Application logs collection
* Real-time monitoring using CloudWatch Agent

### Commands

```bash
sudo systemctl status amazon-cloudwatch-agent
sudo systemctl restart amazon-cloudwatch-agent
```

---

## 🔧 Troubleshooting Guide

### Jenkins

```bash
sudo systemctl status jenkins
sudo tail -f /var/log/jenkins/jenkins.log
```

### Docker

```bash
docker ps -a
docker logs myapp
```

### Cron

```bash
crontab -l
cat /var/log/cron
```

### Linux

```bash
df -h
free -m
top
```

### CloudWatch

```bash
cat /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

---

## 🔐 Security Best Practices

* IAM roles used instead of access keys
* No hardcoded credentials
* Security groups restrict access
* Docker images stored securely in ECR

---

## 🚨 Issues Faced & Fixes

| Issue                 | Fix                        |
| --------------------- | -------------------------- |
| Cron script not found | Corrected file path        |
| Jenkins build failed  | Fixed permissions          |
| Docker push failed    | ECR login configured       |
| Logs not visible      | CloudWatch agent restarted |

---

## 🎯 Final Outcome

* Fully automated CI/CD pipeline
* Zero manual deployment
* Real-time monitoring
* Automated system health checks
* Production-level troubleshooting

---

## 📌 Conclusion

This project demonstrates a **real-world DevOps pipeline** with automation, deployment, monitoring, and troubleshooting capabilities.

---

