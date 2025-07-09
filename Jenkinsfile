pipeline {
  agent any

  stages {
    stage('checkout') {
      steps {
        checkout scm
      }
    }

    stage('install dependencies') {
      steps {
        sh 'npm install'
      }
    }

    stage('build docker image') {
      steps {
        sh 'docker build -t coolestv .'
      }
    }

    stage('run docker compose') {
      steps {
        sh 'docker-compose up -d --build'
      }
    }
  }

  post {
    success {
      echo 'yaaay build completed successfully'
    }
    failure {
      echo 'sorry not sorry, build failed'
    }
  }
}
