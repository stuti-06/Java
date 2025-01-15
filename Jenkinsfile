pipeline { 
    agent any 
    
    environment { 
        DOCKER_IMAGE = 'addition:latest' // Replace with your desired image name  
        IMAGE_TAG = 'latest' 
        IMAGE_NAME = 'sum' // Image name 
    } 

    stages { 
        stage('Git Checkout Stage') { 
            steps { 
              checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'stuti-06', url: 'https://github.com/stuti-06/Java.git']]) 
            } 
        } 
      
        stage('SonarQube Analysis') { 
            steps { 
                withSonarQubeEnv('SonarQube Server') { 
                    // Directly using the token (NOT recommended for security reasons)
                    sh 'mvn sonar:sonar -Dsonar.login="squ_69f7d3d1ec22e8a85bcce1a11e7e72cba5555c9b"'
                }
            } 
        }


        stage('Build WAR File') { 
            steps { 
                sh 'mvn clean package' 
            } 
        } 

        stage('Build Docker Image') { 
            steps { 
                sh 'docker build -t $DOCKER_IMAGE .' 
            } 
        } 

        stage('Scan Docker Image with Trivy') { 
            steps { 
                sh 'trivy image $DOCKER_IMAGE' 
            } 
        } 

        stage('Run Docker Container') { 
            steps { 
                sh 'docker run -d -p 8081:8080 --name app3 $DOCKER_IMAGE' 
            } 
        } 
    } 
} 

