#!/bin/bash

# XVM team (c) www.modxvm.com 2014-2017
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/src/xfw/build/library.sh"

load_repositorystats(){
    #read xvm revision and hash
    pushd "$XVMBUILD_ROOT_PATH"/ > /dev/null
        export XVMBUILD_XVM_BRANCH=$(hg parent --template "{branch}") || exit 1
        export XVMBUILD_XVM_HASH=$(hg parent --template "{node|short}") || exit 1
        export XVMBUILD_XVM_REVISION=$(hg parent --template "{rev}") || exit 1
        export XVMBUILD_XVM_COMMITMSG=$(hg parent --template "{desc}") || exit 1
        export XVMBUILD_XVM_COMMITAUTHOR=$(hg parent --template "{author}" | sed 's/<.*//') || exit 1
    popd > /dev/null
}

htmlencode()
{
  local result=$(echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g;')
  echo "$result"
}

check_variables()
{
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

  if [ "$XVMBUILD_IPB_SERVER" == "" ]; then
    echo "No IPB Server"
    return 1
  fi
}

post_ipb()
{
  downloadlinkzip="$XVMBUILD_URL_DOWNLOAD"/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_HASH"_xvm.zip
  downloadlinkexe="$XVMBUILD_URL_DOWNLOAD"/"$XVMBUILD_XVM_BRANCH"/"$XVMBUILD_XVM_REVISION"_"$XVMBUILD_XVM_BRANCH"_xvm.exe
  builddate=$(date --utc +"%d.%m.%Y %H:%M (UTC)")

  XVMBUILD_XVM_COMMITAUTHOR=$(htmlencode "$XVMBUILD_XVM_COMMITAUTHOR")
  XVMBUILD_XVM_COMMITMSG=$(htmlencode "$XVMBUILD_XVM_COMMITMSG")
  
  XVMBUILD_IPB_TEXT=$(printf "<b>Build:</b> <a href='$XVMBUILD_URL_REPO/$XVMBUILD_XVM_HASH'>$XVMBUILD_XVM_REVISION (branch $XVMBUILD_XVM_BRANCH)</a><br/><b>Date:</b> $builddate <br/> <b>Download:</b> <a href='$downloadlinkzip'>.zip archive</a> | <a href='$downloadlinkexe'>.exe installer</a> <br/> <b>Author:</b> $XVMBUILD_XVM_COMMITAUTHOR <br/> <b>Description:</b> $XVMBUILD_XVM_COMMITMSG <hr>")

  XVMBUILD_IPB_REQURL="$XVMBUILD_IPB_SERVER/api/forums/posts"
  XVMBUILD_IPB_REQBODY="key=$XVMBUILD_IPB_APIKEY&author=$XVMBUILD_IPB_USERID&topic=$XVMBUILD_IPB_TOPICID&post=$XVMBUILD_IPB_TEXT"

  curl -k -sS -w %{http_code} -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: XVM Build Server\r\n" -X POST --data "$XVMBUILD_IPB_REQBODY" "$XVMBUILD_IPB_REQURL" --output /dev/null
}

load_repositorystats
check_variables
post_ipb
