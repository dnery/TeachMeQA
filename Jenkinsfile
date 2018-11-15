pipeline {
    agent {
        docker { image 'python:3.5.1' }
    }
    stages {
        stage('build') {
            steps {
                sh 'python --version'

                retry(3) {
                    timeout(time: 5, unit: 'SECONDS') {
                        sh '''
                            echo "Starting timeout"
                            sleep 10
                        '''
                    }
                }
            }
        }
    }
    post {
        success {
            echo "Build success!"
        }
        failure {
            echo "Build failure..."
        }
    }
}
