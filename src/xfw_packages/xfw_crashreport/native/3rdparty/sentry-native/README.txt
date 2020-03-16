name    : sentry-native
version : 0.2.0~7acd79f1008d591cf07fbe8f5a43749a3a09996d
url     : https://github.com/getsentry/sentry-native
notes   : RelWithDebInfo, crashpad, without curl
cmake-32: cmake -B build32 -A Win32 -DSENTRY_CURL_SUPPORT=OFF -DCMAKE_INSTALL_PREFIX=install32 -DCMAKE_SYSTEM_VERSION="6.1"
cmak3-64: cmake -B build64 -A x64   -DSENTRY_CURL_SUPPORT=OFF -DCMAKE_INSTALL_PREFIX=install64 -DCMAKE_SYSTEM_VERSION="6.1"