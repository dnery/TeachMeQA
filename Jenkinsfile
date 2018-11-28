node {
    currentBuild.result = 'SUCCESS';

    try {
        stage('Checkout') {
            checkout scm;
            stash 'source';
        }

        def mvn_plus_robot_img = docker.build("my-image:${env.BUILD_ID}");

        mvn_plus_robot_img.inside {
            stage('Test-Env') {
                unstash 'source';
                echo '$JAVA_HOME';
                sh 'mvn --version';
            }
            stage('Test-Deploy') {
                sh './redeploy.sh';
            }
            stage('Test-Run') {
                sh 'robot login_tests/';
            }
            stage('Test-Tail') {
                sh 'tail apache-tomcat-9.0.13/logs/catalina.out';
            }
            stage('Test-Teardown') {
                sh './apache-tomcat-9.0.13/bin/shutdown.sh';
            }
        }

    } catch (err) {
        currentBuild.result = 'FAILURE';
        echo 'Error: ' + err.toString();
        throw err;

    } finally {

        if (currentBuild.result == 'SUCCESS') {
            echo 'Build was a success!';
        } else {
            echo 'Build was a failure!';
        }
    }
}
