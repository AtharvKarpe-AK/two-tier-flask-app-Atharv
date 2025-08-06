pipeline {
    agent {label "dev"};
    stages{
        stage("Code"){
            steps{
                git url: "https://github.com/AtharvKarpe-AK/two-tier-flask-app-Atharv.git", branch: "master"
                echo "Code clone ho gaya ...."  
            }
        }

        stage("Trivy file system scan"){
            steps{
                sh "trivy fs . -o results.json"
            }
        }
        stage("Build"){
            steps{
                sh "docker build -f Dockerfile-multistage -t flaskapp ."
                echo "Code build ho gaya..."
            }
        }
        stage("Test"){
            steps{
                echo "Developer/Tester tests likh ke dega..."
            }
        }
        stage("Push"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId: "DockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser"
                )]){
                
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker image tag flaskapp ${env.dockerHubUser}/flaskapp"
                sh "docker push ${env.dockerHubUser}/flaskapp"
                        
                    
                    
                    
                }
            }
            
        }
        stage("Deploy"){
            steps{
                sh "docker compose up -d --build flask"
                echo "Docker compose se code deploy ho gaya...."
            }
        }
    }
post {
    success {
        emailext (
        body: 'Hello Atharv good news: Build Successful for demo cicd app!',
        subject: 'Jenkins Build Successful',
        to: 'atharvkkarpe@gmail.com'
        attachmentsPattern: 'results.json'
        )
        
    }
    failure {
        emailext (
        body: 'Hello Atharv bad news: Build failed for demo cicd app!',
        subject: 'Jenkins Build Failed',
        to: 'atharvkkarpe@gmail.com'
        attachmentsPattern: 'results.json'
        )
    }
}
}
