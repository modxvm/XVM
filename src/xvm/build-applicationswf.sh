#!/bin/bash

export xfw_path_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export xfw_output_swf_wg_path="swf"

pushd ../xfw/src/application-swf/ >/dev/null
./build.sh
popd >/dev/null