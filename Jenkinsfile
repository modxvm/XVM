node {

    dir("$WORKSPACE@script") {
        try { 
            stage 'checkout'
                checkout scm
                sh 'hg pull'
                sh 'hg update'

            stage 'XVM'
                sh './build/ci/ci_build_xvm.sh'

            stage 'XVM Installer'
                sh './build/ci/ci_build_installer.sh'

            stage 'Deploy'
                sh './build/ci/ci_deploy.sh'

            stage 'Notify'
                sh './build/ci/ci_notify.sh'

        } catch (e) {
            currentBuild.result = "FAILED"
            notifyBuild(currentBuild.result)
            throw e
        } finally {
            //notifyBuild(currentBuild.result)
        }

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
