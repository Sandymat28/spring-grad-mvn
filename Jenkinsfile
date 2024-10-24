pipeline {
  agent any

  environment {
    DOCKER_CREDENTIALS = credentials('DOCKER_ACCOUNT')
    PROJECT_DIR = 'complete'
  }

  stages {
    stage('build-one') {
      steps {
        echo 'Building'
        dir("${PROJECT_DIR}") {
        sh './gradlew clean build'
        }
      }
    }

    stage('Navigate to Project Folder') {  // Se déplacer dans le dossier 'complete'
      steps {
      dir("${PROJECT_DIR}") { // Exécuter des commandes dans le dossier 'complete'
      sh 'ls -la'   // Liste les fichiers du dossier
      }
    }
  }
    
    stage ('Build-two') {
      steps {
        echo 'Building image...'
        dir("${PROJECT_DIR}") {
        sh 'docker build -t matsandy/spring-gradle:latest . -f /complete/Dockerfile'
        //sh 'docker build -t matsandy/spring-gradle:latest .'
        }
      }
    }

    stage ('Run') {
      steps {
        echo 'Running image'
        dir("${PROJECT_DIR}") {
        sh 'docker run -p 8086:8080 -d matsandy/spring-gradle:latest'
        }
      }
    }
    
    stage('login') {
      steps {
        echo 'Connecting to Dockerhub'
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }

    stage ('Push') {
      steps {
        echo 'Pushing to Dockerhub'
        dir("${PROJECT_DIR}") {
        sh 'docker push matsandy/spring-gradle:latest'
        }
      }
    }
  }

    post {
      always {
        echo 'PIPELINE FINISHED'
      }
    }
  }


/*pipeline {
  agent any // Utiliser n'importe quel agent disponible
  //tools {
    //Maven maven:3.9.9
    //}
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('DOCKER_ACCOUNT')
  }
  stages {
    stage('Build') {
      steps {
       //sh 'mvn clean package'
         sh 'docker build -t matsandy/gradlelari:lts .'
       //sh 'docker-compose build'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push matsandy/gradlelari:lts'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}*/
