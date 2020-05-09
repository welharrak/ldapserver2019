pipeline {
  agent any
  stages {
    stage('Change directory') {
      steps {
        sh 'cd ldapserver19:group'
      }
    }

    stage('Delete all unused images') {
      steps {
        sh 'echo "y" | docker system prune'
      }
    }

    stage('Stop ldapserver running containers') {
      steps {
        sh 'docker stop ldapserver || echo "there is no ldapserver running container"'
      }
    }

    stage('Build image') {
      steps {
        sh 'docker build -t ldapserver:latest .'
      }
    }

    stage('Run the image created') {
      steps {
        sh 'docker run --rm --name ldapserver -h ldapserver -p 389:389 -d ldapserver:latest'
      }
    }

  }
}
