#!/bin/bash

export xfw_path_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export xfw_output_swc_path="lib"
export xfw_output_swf_path="../../release/mods"

pushd ../xfw/src/actionscript/ >/dev/null
./build.sh
popd >/dev/null