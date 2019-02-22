pipeline 
{
    agent
    {
        node
        {
            label 'master'
        }
    }

    stages
    {
        stage('Checkout')
        {
            steps
            {
                sh 'hg pull'
                sh 'hg update'
            }
        }

        stage('XVM')
        {
            steps
            {
                sh './build/ci/ci_build_xvm.sh'
            }
        }

        stage('XVM Installer')
        {
            steps
            {
                sh './build/ci/ci_build_installer.sh'
            }
        }

        stage('Deploy')
        {
            steps
            {
                sh './build/ci/ci_deploy.sh'
            }
        }

        stage('Notify')
        {
            steps
            {
                sh './build/ci/ci_notify.sh'
            }
        }

        stage('SonarQube')
        {
            steps {
                script {
                    scannerHome = tool 'SonarQube Scanner'
                }
                withSonarQubeEnv('SonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.sources=. -Dsonar.projectKey=xvm-client -Dsonar.exclusions=src/xfw/src/actionscript/wg/**,src/xfw/src/python/mods/xfw/python/lib/**"
                }
            }
        }
    }

    post 
    {
        success 
        {
            script {
                def previousResult = currentBuild.previousBuild?.result
                if (previousResult && previousResult != 'SUCCESS') {
                    slackSend (color: '#00FF00', message: "FIXED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                }
            }
        }
        
        failure
        {
            slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}
