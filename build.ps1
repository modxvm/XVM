# SPDX-License-Identifier: MIT
# Copyright (c) 2022-2023 XVM Team

# Import modules
Import-Module "$PSScriptRoot/src_build/library.psm1" -Force -DisableNameChecking

# Import settings
if ($null -eq $env:XVMBUILD_FLAVOUR) { 
    $env:XVMBUILD_FLAVOUR = 'wg' 
}
. $PSScriptRoot/build/xvm-build.conf.ps1
$env:XVMBUILD_VERSION_MOD = "$env:XVMBUILD_VERSION_MOD.$(Get-GitRevision)"

# Build packages
Build-Packages -PackageDirectory "$PSScriptRoot/src" -OutputDirectory "$PSScriptRoot/~output" -Flavour $env:XVMBUILD_FLAVOUR -Version $env:XVMBUILD_VERSION_MOD
