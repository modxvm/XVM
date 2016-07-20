#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2016
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_REPOSITORY_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_REPOSITORY_PATH/build/xvm-build.conf"
source "$XVMBUILD_REPOSITORY_PATH/build/library.sh"

check_variables(){
  if [ "$XVMBUILD_URL_DOWNLOAD" == "" ]; then
    echo "No download URL"
    eturn 1
  fi

    if [ "$XVMBUILD_IPB_APIKEY" == "" ]; then
        echo "No IPB API key"
    return 1
    fi

    if [ "$XVMBUILD_IPB_USERID" == "" ]; then
    echo "No IPB User ID"
    return 1
    fi

    if [ "$XVMBUILD_IPB_TOPICID" == "" ]; then
    echo "No IPB Topic ID"
    return 1
    fi
}

post_ipb(){

downloadlinkzip="$XVMBUILD_URL_DOWNLOAD"/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip
downloadlinkexe="$XVMBUILD_URL_DOWNLOAD"/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_BRANCH"_xvm.exe

XVMBUILD_IPB_TEXT=$(printf "[b]Build:[/b] [url=$XVMBUILD_URL_REPO/$XVMBUILD_XVM_HASH]$XVMBUILD_XVM_REVISION (branch $XVMBUILD_XVM_BRANCH)[/url] \n [b]Download:[/b] [url=$downloadlinkzip].zip archive[/url] | [url=$downloadlinkexe].exe installer[/url]  \n [b]Author:[/b] $XVMBUILD_XVM_COMMITAUTHOR \n [b]Description:[/b] $XVMBUILD_XVM_COMMITMSG [hr]")

XVMBUILD_IPB_REQURL="http://www.koreanrandom.com/forum/interface/board/index.php"
XVMBUILD_IPB_REQBODY="<?xml version=\"1.0\" encoding=\"UTF-8\" ?>
<methodCall>
  <methodName>postReply</methodName>
  <params>
    <param>
      <value>
        <struct>
          <member>
            <name>api_module</name>
            <value><string>ipb</string></value>
          </member>
          <member>
            <name>api_key</name>
            <value><string>$XVMBUILD_IPB_APIKEY</string></value>
          </member>
          <member>
            <name>member_field</name>
            <value><string>member_id</string></value></member>
          <member>
            <name>member_key</name>
            <value><string>$XVMBUILD_IPB_USERID</string></value>
          </member>
          <member>
            <name>topic_id</name>
            <value><string>$XVMBUILD_IPB_TOPICID</string></value>
          </member>
          <member>
            <name>post_content</name>
            <value><string>$XVMBUILD_IPB_TEXT</string></value>
          </member>
        </struct>
      </value>
    </param>
  </params>
</methodCall>"

curl -sS -H "Content-Type: text/xml" -H "User-Agent: IPS XML-RPC Client Library (\$Revision: 10721 $)\r\n" -X POST --data "$XVMBUILD_IPB_REQBODY" "$XVMBUILD_IPB_REQURL"

}

load_repositorystats

check_variables
post_ipb