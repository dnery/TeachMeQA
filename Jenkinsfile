node {
    currentBuild.result = 'SUCCESS';

    try {
        checkout scm;

        def mvn_plus_robot_img = docker.build("my-image:${env.BUILD_ID}");

        mvn_plus_robot_img.inside {
            stage('Checkout') {
                checkout scm
            }
            stage('Test-Env') {
                sh 'mvn --version';
                sh 'echo $JAVA_HOME';
            }
            stage('Deploy') {
                sh './redeploy.sh';
            }
            stage('Tail') {
                sh 'tail apache-tomcat-9.0.13/logs/catalina.out';
            }
        }

    } catch (err) {
        currentBuild.result = 'FAILURE';
        echo 'Error: ' + err.toString();
        throw err;

    } finally {

        if (curentBuild.result == 'SUCCESS') {
            sh 'echo "Build was a success!"';
        } else {
            sh 'echo "Build was a failure!"';
        }
    }
}
