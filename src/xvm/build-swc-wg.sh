#!/bin/sh

if [ "$OS" = "Windows_NT" ]; then
    if [ "$FLEXSDK" = "" ]; then
        MACHINE_TYPE=`uname -m`
        if [ ${MACHINE_TYPE} == 'x86_64' ]; then
            PROGRAMFILESPATH="$PROGRAMFILES (x86)"
        else
            PROGRAMFILESPATH="$PROGRAMFILES"
        fi
        FLEXSDK="$PROGRAMFILESPATH/FlashDevelop/Tools/flexsdk"
        compc="$FLEXSDK/bin/compc.exe"
    else
        compc="$FLEXSDK/bin/compc" #Apache Flex SDK has only bat and shell scripts
    fi
else
    compc="compc"
fi

classes="
App
"

"$compc" \
	-source-path wg \
	-output lib/wg.swc \
	-include-classes $classes
