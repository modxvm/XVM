#!/bin/sh

if [ "$OS" = "Windows_NT" ]; then
    if [ "$FLEX_HOME" = "" ]; then
        FLEX_HOME="$LOCALAPPDATA/FlashDevelop/Apps/flexsdk/4.6.0"
    fi
    compc="$FLEX_HOME/bin/compc" #Apache Flex SDK has only bat and shell scripts
else
    compc="compc"
fi

class="App"

"$compc" \
	-source-path wg/app \
	-source-path wg/links \
	-source-path wg/ui \
	-output lib/wg.swc \
	-include-classes $class
