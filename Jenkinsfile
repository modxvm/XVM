node {

    try { 

        stage 'Checkout'         
            sh '''
                hg pull
                hg update --clean
                hg --config "extensions.purge=" purge --all
            '''
        
        stage 'XVM'
            sh '''
                ./build.sh
            '''

        stage 'XVM Installer'
            sh '''
                ROOT_PATH=$(pwd)

                source /var/xvm/ci_config.sh
                source "$ROOT_PATH/build/xvm-build.conf"
                source "$ROOT_PATH/build/ci/ci_init_variables.sh"

                hg clone "$XVMINST_REPO" "$ROOT_PATH/xvminst"
                cd "$ROOT_PATH/xvminst/"
                ./build.sh
            '''

        stage 'Deploy'
            sh '''
                ROOT_PATH=$(pwd)

                source /var/xvm/ci_config.sh
                source "$ROOT_PATH/build/xvm-build.conf"
                source "$ROOT_PATH/build/ci/ci_init_variables.sh"

                "$ROOT_PATH/build/ci/ci_pack.sh"
            '''

        stage 'Notify'
            sh '''
                ROOT_PATH=$(pwd)

                source /var/xvm/ci_config.sh
                source "$ROOT_PATH/build/ci/ci_init_variables.sh"

               "$ROOT_PATH/build/ci/ci_notify_forum.sh"
            '''
    } catch (e) {
        currentBuild.result = "FAILED"
        notifyBuild(currentBuild.result)
        throw e
    } finally {
        //notifyBuild(currentBuild.result)
    }

}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}