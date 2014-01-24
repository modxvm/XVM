#!/bin/sh

if [ "$OS" = "Windows_NT" ]; then
    if [ "$FLEX_HOME" = "" ]; then
        MACHINE_TYPE=`uname -m`
        if [ ${MACHINE_TYPE} == 'x86_64' ]; then
            PROGRAMFILESPATH="$PROGRAMFILES (x86)"
        else
            PROGRAMFILESPATH="$PROGRAMFILES"
        fi
        FLEX_HOME="$PROGRAMFILESPATH/FlashDevelop/Tools/flexsdk"
        compc="$FLEX_HOME/bin/compc.exe"
    else
        compc="$FLEX_HOME/bin/compc" #Apache Flex SDK has only bat and shell scripts
    fi
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
