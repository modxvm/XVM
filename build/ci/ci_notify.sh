#!/bin/bash

# XVM team (c) https://modxvm.com 2014-2019
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/../.."

source /var/xvm/ci_config.sh
source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/src/xfw/build/library.sh"

detect_git
git_get_repostats

htmlencode()
{
  local result=$(echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g;')
  echo "$result"
}

check_variables()
{
  if [ "$XVMBUILD_URL_DOWNLOAD" == "" ]; then
    echo "No download URL"
    return 1
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
  downloadlinkzip="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip
  downloadlinkexe="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe
  builddate=$(date --utc +"%d.%m.%Y %H:%M (UTC)")

  XVMBUILD_XVM_COMMITAUTHOR=$(htmlencode "$XVMBUILD_XVM_COMMITAUTHOR")
  XVMBUILD_XVM_COMMITMSG=$(htmlencode "$XVMBUILD_XVM_COMMITMSG")
  
  XVMBUILD_IPB_TEXT=$(printf "<b>Build: </b><a href='$XVMBUILD_URL_REPO/$REPOSITORY_HASH'>${XVMBUILD_XVM_VERSION}_$REPOSITORY_COMMITS_NUMBER (branch $REPOSITORY_BRANCH)</a><br/><b>Date:</b> $builddate <br/> <b>Download: </b><a href='$downloadlinkzip'>.zip archive</a> | <a href='$downloadlinkexe'>.exe installer</a> <br/> <b>Author:</b> $REPOSITORY_AUTHOR <br/> <b>Description:</b> $REPOSITORY_SUBJECT <hr>")

  XVMBUILD_IPB_REQURL="$XVMBUILD_IPB_SERVER/api/forums/posts"
  XVMBUILD_IPB_REQBODY="key=$XVMBUILD_IPB_APIKEY&author=$XVMBUILD_IPB_USERID&topic=$XVMBUILD_IPB_TOPICID&post=$XVMBUILD_IPB_TEXT"

  curl -k -sS -m 2 -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: XVM Build Server\r\n" -X POST --data "$XVMBUILD_IPB_REQBODY" "$XVMBUILD_IPB_REQURL" --output /dev/null || true
}

post_telegram()
{
  downloadlinkzip="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip
  downloadlinkexe="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe
  builddate=$(date --utc +"%d.%m.%Y %H:%M (UTC)")

  XVMBUILD_XVM_COMMITAUTHOR=$(htmlencode "$REPOSITORY_AUTHOR")
  XVMBUILD_XVM_COMMITMSG=$(htmlencode "$REPOSITORY_SUBJECT")
  
  printf "<b>Build: </b><a href='$XVMBUILD_URL_REPO/$REPOSITORY_HASH'>${XVMBUILD_XVM_VERSION}_$REPOSITORY_COMMITS_NUMBER (branch $REPOSITORY_BRANCH)</a>\n<b>Date:</b> $builddate\n<b>Download: </b><a href='$downloadlinkzip'>.zip archive</a> | <a href='$downloadlinkexe'>.exe installer</a>\n<b>Author:</b>$REPOSITORY_AUTHOR\n<b>Description:</b> $REPOSITORY_SUBJECT" | telegram-send --stdin --disable-web-page-preview --format html --config /var/xvm/telegram-send.conf
}

check_variables

post_ipb
post_telegram
