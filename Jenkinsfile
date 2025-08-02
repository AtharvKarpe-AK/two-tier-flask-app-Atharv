pipeline {
    agent any;
    stages{
        stage("Code"){
            steps{
                git url: "https://github.com/AtharvKarpe-AK/two-tier-flask-app-Atharv.git", branch: "master"
                echo "Code clone ho gaya ...."  
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
}
