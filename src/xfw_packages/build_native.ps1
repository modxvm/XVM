# This file is part of the XVM Framework project.
#
# Copyright (c) 2018-2020 XVM Team.
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

Push-Location $PSScriptRoot

Import-Module ../../build_lib/library.psm1 -Force -DisableNameChecking

#version
$version_str = "8.6.0.0"
$version = $version_str -replace "\.",","

$xfwnative_url="https://gitlab.com/xvm/xfw/xfw.native/uploads/8babfbe9fe26db9effee2f11c599f6b5/com.modxvm.xfw.native_2.0.9-devel.zip"

$projects_32=@(
    "xfw_filewatcher"
    "xfw_fonts"
    "xfw_mutex"
    "xfw_ping"
    "xfw_wotfix_crashes"
    "xfw_wotfix_hidpi"
)


$projects_64=@(
    "xfw_filewatcher"
    "xfw_fonts"
    "xfw_mutex"
    "xfw_ping"
    "xfw_wotfix_crashes"
    "xfw_wotfix_hidpi"
)

function Download-DevelPackage()
{
    Invoke-WebRequest $xfwnative_url -OutFile devel.zip
    Expand-Archive -Path ./devel.zip -DestinationPath ./_devel/
    Remove-Item -Path "./devel.zip"
}

function Build-CmakeProject($Name, $Arch = "32bit")
{
    Write-Output "  * $Name"

    $root = (Get-Location).Path -replace "\\","/"

    if ($Arch -eq "64bit") {
        $msvcarch = "x64"
    } else {
        $msvcarch = "Win32"
    }

    New-Item -ItemType Directory -Path ./_build/${Name}_${msvcarch}/ | Out-Null
    Push-Location "$root/_build/${Name}_${msvcarch}/"



    cmake -A $msvcarch -T v141_xp "$root/$Name/native/" -DVER_VERSION="${version}" -DVER_VERSION_STR="${version_str}" -DCMAKE_INSTALL_PREFIX="$root/_binaries/$Name/native_$Arch/" -DCMAKE_PREFIX_PATH="$root/_devel/$msvcarch"
    if ($LastExitCode -ne 0) {
        Write-Error "Configure failed"
        Pop-Location
        exit $LastExitCode
    }

    cmake --build . --target INSTALL --config RelWithDebInfo
    if ($LastExitCode -ne 0) {
        Write-Error "Build failed"
        Pop-Location
        exit $LastExitCode
    }

    Pop-Location
}


Remove-Item -Path "./_build/*" -Recurse -Force -ErrorAction SilentlyContinue
#Remove-Item -Path "./_binaries/*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "./_devel/*" -Force -Recurse -ErrorAction SilentlyContinue
Download-DevelPackage

foreach ($project in $projects_32) {
    Build-CmakeProject -Name $project -Arch "32bit"
}

foreach ($project in $projects_64) {
   Build-CmakeProject -Name $project -Arch "64bit"
}

Remove-Item -Path "./_build/*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "./_devel/*" -Recurse -Force -ErrorAction SilentlyContinue

if(Sign-IsAvailable){
    Write-Output "Signing files"
    Sign-Folder -Folder "./_binaries/"
    Write-Output ""
}

Write-Output "Successful"
