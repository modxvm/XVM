# This file is part of the XVM Framework project.
#
# Copyright (c) 2018-2019 XVM Team.
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
$version_str = "8.1.2.0"
$version = $version_str -replace "\.",","

$xfwnative_url="https://ci.appveyor.com/api/buildjobs/o7mfpjq3iimkwj9n/artifacts/output%2Fdeploy%2Fcom.modxvm.xfw.native_1.4.9-devel.zip"

$projects=@(
    "xfw_crashreport"
    "xfw_filewatcher"
    "xfw_fonts"
    "xfw_mutex"
    "xfw_ping"
    "xfw_wotfix_crashes"
    "xfw_wotfix_hidpi"
    "xfw_wwise"
)

function Download-DevelPackage()
{
    Invoke-WebRequest $xfwnative_url -OutFile devel.zip
    Expand-Archive -Path ./devel.zip -DestinationPath ./_devel/
    Remove-Item -Path "./devel.zip"
}

function Build-CmakeProject($Name)
{
    Write-Output "  * $Name"

    New-Item -ItemType Directory -Path ./_build/$Name/native/ | Out-Null

    $root = (Get-Location).Path -replace "\\","/"

    Push-Location "$root/_build/$Name/"

    cmake -A Win32 -T v141_xp "$root/$Name/native/" -DVER_VERSION="${version}" -DVER_VERSION_STR="${version_str}" -DCMAKE_INSTALL_PREFIX="$root/_binaries/$Name/native_32bit/" -DCMAKE_PREFIX_PATH="$root/_devel/" | Out-File -FilePath "$root/_logs/$Name-cmake-config.log"
    if ($LastExitCode -ne 0) {
        Write-Error "Configure failed"
        Pop-Location
        exit $LastExitCode
    }

    cmake --build . --target INSTALL --config RelWithDebInfo | Out-File -FilePath "$root/_logs/$Name-cmake-build.log"
    if ($LastExitCode -ne 0) {
        Write-Error "Build failed"
        Pop-Location
        exit $LastExitCode
    }

    Pop-Location
}


Remove-Item -Path "./_build/*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "./_binaries/*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "./_logs/*" -Force -Recurse -ErrorAction SilentlyContinue
New-Item -Path "./_logs/" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

Remove-Item -Path "./_devel/*" -Force -Recurse -ErrorAction SilentlyContinue
Download-DevelPackage

foreach ($project in $projects) {
    Build-CmakeProject -Name $project
}

#Remove-Item -Path "./_build/*" -Recurse -Force -ErrorAction SilentlyContinue
#Remove-Item -Path "./_devel/*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "Successful"
