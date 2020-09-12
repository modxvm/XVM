#!/bin/bash

# XVM Team (c) https://modxvm.com 2014-2020
# XVM nightly build system

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_PATH"
export XVMBUILD_ROOT_PATH="$CURRENT_PATH/.."

source "$XVMBUILD_ROOT_PATH/build/xvm-build.conf"
source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

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

  if [ "$TELEGRAM_TOKEN" == "" ]; then
    echo "No telegram token"
    return 1
  fi

  if [ "$TELEGRAM_CHAT_ID" == "" ]; then
    echo "No telegram chat id"
    return 1
  fi
}

create_config()
{
  cp "$CURRENT_PATH/ci_notify_telegram.conf.template" "/tmp/ci_notify_telegram.conf"
  sed -i "s/TELEGRAM_TOKEN/$TELEGRAM_TOKEN/g" "/tmp/ci_notify_telegram.conf"
  sed -i "s/TELEGRAM_CHAT_ID/$TELEGRAM_CHAT_ID/g" "/tmp/ci_notify_telegram.conf"
}

post_telegram()
{
  downloadlinkzip="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".zip
  downloadlinkexe="$XVMBUILD_URL_DOWNLOAD"/"$REPOSITORY_BRANCH"/xvm_"$XVMBUILD_XVM_VERSION"_"$REPOSITORY_COMMITS_NUMBER"_"$REPOSITORY_BRANCH"_"$REPOSITORY_HASH".exe
  builddate=$(date --utc +"%d.%m.%Y %H:%M (UTC)")

  XVMBUILD_XVM_COMMITAUTHOR=$(htmlencode "$REPOSITORY_AUTHOR")
  XVMBUILD_XVM_COMMITMSG=$(htmlencode "$REPOSITORY_SUBJECT")

  printf "<b>Build: </b><a href='$XVMBUILD_URL_REPO/$REPOSITORY_HASH'>${XVMBUILD_XVM_VERSION}_$REPOSITORY_COMMITS_NUMBER (branch $REPOSITORY_BRANCH)</a>\nWoT version: $XVMBUILD_WOT_VERSION\n<b>Date:</b> $builddate\n<b>Download: </b><a href='$downloadlinkzip'>.zip archive</a> | <a href='$downloadlinkexe'>.exe installer</a>\n<b>Author:</b>$REPOSITORY_AUTHOR\n<b>Description:</b> $REPOSITORY_SUBJECT\n\n$REPOSITORY_BODY" | telegram-send --stdin --disable-web-page-preview --format html --config /tmp/ci_notify_telegram.conf
}


detect_git
git_get_repostats

if $(check_variables); then
  create_config
  post_telegram
fi