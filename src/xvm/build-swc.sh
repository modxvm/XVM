#!/bin/sh

if [ "$OS" = "Windows_NT" ]; then
    if [ "$FLEX_HOME" = "" ]; then
        FLEX_HOME="$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0"
    fi
    compc="$FLEX_HOME/bin/compc" #Apache Flex SDK has only bat and shell scripts
else
    compc="compc"
fi

frswc="$FLEX_HOME/frameworks/libs/framework.swc"
class="com.xvm.Xvm"

"$compc" \
    -framework="$FLEX_HOME/frameworks" \
    -source-path src \
    -library-path=lib/wg.swc \
    -library-path="$frswc" \
    -output lib/xvm.swc \
    -include-classes $class
