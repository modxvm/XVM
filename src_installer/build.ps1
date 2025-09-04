#!/usr/bin/env pwsh

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

#
# Imports
#

Import-Module "$PSScriptRoot/../src_build/library.psm1" -Force -DisableNameChecking



#
# Globals
#

$Global:config = Get-Content -Path "$PSScriptRoot/../build.json"| ConvertFrom-Json

$Global:path_temp = "$PSScriptRoot/../~output/installer_temp/"

$Global:version_lesta = $config.game_version_lesta
$Global:version_wg = $config.game_version_wg
$Global:version_xvm = Get-VcsVersionString

$Global:url_l10n = "https://translate.modxvm.com/downloads/xvm-installer/xvm-installer-l10n_isl.zip"



#
# Functions
#

function Clean-Directories()
{
    if (Test-Path $path_temp) {
        Remove-Item -Recurse -Force $path_temp
    }
    New-Item -ItemType Directory -Path $path_temp                 | Out-Null
    New-Item -ItemType Directory -Path "$path_temp/defines"       | Out-Null
    New-Item -ItemType Directory -Path "$path_temp/l10n_download" | Out-Null
    New-Item -ItemType Directory -Path "$path_temp/l10n_result"   | Out-Null
}


function Prepare-Defines()
{
    $templateFile = "$PSScriptRoot/xvm_defines_template.iss"
    $outputFile = "$path_temp/defines/xvm_defines.iss"
    Copy-Item -Path $templateFile -Destination $outputFile

    (Get-Content $outputFile -Raw) `
        -replace 'XVM_WOTVERSION', $Global:version_lesta `
        -replace 'XVM_MTVERSION',  $Global:version_wg `
        -replace 'XVM_VERSION',    $Global:version_xvm |
        Set-Content $outputFile
}


function Prepare-Languages()
{
    $l10nDownloadDir = "$Global:path_temp/l10n_download"
    $l10nResultDir = "$Global:path_temp/l10n_result"
    $l10nZip = Join-Path -Path $l10nDownloadDir -ChildPath "l10n.zip"

    Invoke-WebRequest -Uri $Global:url_l10n -OutFile $l10nZip
    Expand-Archive -Path $l10nZip -DestinationPath $l10nDownloadDir -Force
    Remove-Item $l10nZip

    Copy-Item -Path "$PSScriptRoot/l10n/en.islu.tpl" -Destination "$l10nDownloadDir/en.islu.tpl"

    Get-ChildItem -Path $l10nDownloadDir -Filter '*.tpl' -File | ForEach-Object {
        $lang = $_.BaseName
        $destinationFile = Join-Path $l10nResultDir $lang
        New-Item -ItemType Directory -Path $l10nResultDir -Force | Out-Null
        Copy-Item $_.FullName $destinationFile -Force

        (Get-Content $destinationFile -Raw) `
            -replace '\{#VersionWOT\}', [regex]::Escape($Global:version_wg) `
            -replace '\{#VersionMT\}',  [regex]::Escape($Global:version_lesta) `
            -replace '\{#VersionXVM\}', [regex]::Escape($Global:version_xvm) |
        Set-Content $destinationFile -Encoding UTF8
    }

    $langIss = Join-Path -Path $l10nResultDir -ChildPath "lang.iss"
    Add-Content -Path $langIss -Value "[Languages]"
    Add-Content -Path $langIss -Value "Name: `"en`"; MessagesFile: `"l10n_inno\en.islu,..\\~output\\installer_temp\\l10n_result\\en.islu`""

    Get-ChildItem -Path $l10nResultDir -Filter "*.islu" | ForEach-Object {
        $lang = $_.BaseName
        if ($lang -ne "en") {
            $langchg = "en"
            if ($lang -in @("ru", "be", "uk", "kk")) {
                $langchg = "ru"
            }
            if (Test-Path "$PSScriptRoot/l10n_inno/$lang.islu") {
                Add-Content -Path $langIss -Value "Name: `"$lang`"; MessagesFile: `"l10n_inno\\$lang.islu,..\\~output\\installer_temp\\l10n_result\\$lang.islu`""
            }
        }
    }
}


function Build-Run()
{
    $isccPath = "$PSScriptRoot/../src_build/bin/windows_i686/innosetup/ISCC.exe"

    if ($IsLinux) {
        Invoke-ProcessAndLog -Process "wine" -Arguments @($isccPath, "xvm.iss") -WorkingDirectory "$PSScriptRoot"
    } else {
        Invoke-ProcessAndLog -Process $isccPath -Arguments @("xvm.iss") -WorkingDirectory "$PSScriptRoot"
    }
}

function Build-Deploy()
{
    $outputDir = "$PSScriptRoot/../~output"
    $sourceFile = "$outputDir/setup_xvm.exe"
    
    $vcs_tag = Get-VcsLastTag
    $vcs_commits = Get-VcsCommitsCount
    $vcs_branch = Get-VcsBranch
    $vcs_hash = Get-VcsHash
    
    Copy-Item -Path $sourceFile -Destination "$outputDir/xvm_latest_$($vcs_branch).exe"
    Copy-Item -Path $sourceFile -Destination "$outputDir/xvm_$($vcs_tag)_$($vcs_commits)_$($vcs_branch)_$($vcs_hash).exe"

    Remove-Item -Path $sourceFile
}


Clean-Directories
Prepare-Defines
Prepare-Languages
Build-Run
Build-Deploy
Clean-Directories
