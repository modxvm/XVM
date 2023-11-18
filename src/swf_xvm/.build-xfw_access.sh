#!/bin/bash

# This file is part of the XVM Framework project.
#
# Copyright (c) 2014-2023 XVM Team.
#
# XVM Framework is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# XVM Framework is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

set -e

currentdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
XVMBUILD_ROOT_PATH="$currentdir/../../"

# $XVMBUILD_FLAVOR
if [[ "$XVMBUILD_FLAVOR" == "" ]]; then
    export XVMBUILD_FLAVOR="wg"
fi

source "$XVMBUILD_ROOT_PATH/build_lib/library.sh"

detect_os
detect_arch
detect_patch
detect_unzip
detect_actionscript_sdk

# modify PATH
PATH="$currentdir"/../../build_lib/bin/"$OS"_"$arch"/:$PATH

# create temp dir
TMP_DIR="$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/tmp/xfw_access"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# compile
class="com.xfw.XfwAccess"
build_as3_swc \
    -inline \
    -source-path "$currentdir/xfw_access" \
    -external-library-path+="$currentdir/../swc_$XVMBUILD_FLAVOR/common-1.0-SNAPSHOT.swc" \
    -external-library-path+="$XVMBUILD_ROOT_PATH/~output/$XVMBUILD_FLAVOR/swc/xfw_shared.swc" \
    -output "$TMP_DIR/xfw_access.swc" \
    -include-classes $class

pushd "$TMP_DIR" > /dev/null

# unpack
unzip "./xfw_access.swc"
rm "./xfw_access.swc"

# get hash
hash1=$(sha256sum "./library.swf" | awk '{print $1}')
echo $hash1

# disassemble
abcexport "./library.swf" || exit 1
rabcdasm "./library-0.abc" || exit 1

# patch
patch --binary -p0 < "$currentdir/xfw_access/postbuild.patch" || exit 1

# replace
rabcasm library-0/library-0.main.asasm || exit 1
abcreplace library.swf 0 library-0/library-0.main.abc || exit 1

rm "library-0.abc"
rm -r "./library-0"

# get hash
hash2=$(sha256sum "./library.swf" | awk '{print $1}')
echo $hash2

# replace hash
sed -i "s/$hash1/$hash2/" ./catalog.xml

# zip
zip xfw_access.swc ./catalog.xml ./library.swf
rm ./catalog.xml ./library.swf

rm -rf "$currentdir/../../~output/$XVMBUILD_FLAVOR/swc/xfw_access.swc"
mv "./xfw_access.swc" "$currentdir/../../~output/$XVMBUILD_FLAVOR/swc/xfw_access.swc"

popd > /dev/null