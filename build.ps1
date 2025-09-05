#!/usr/bin/env pwsh

Import-Module "$PSScriptRoot/src_build/library.psm1" -Force -DisableNameChecking

# Read game versions from build.json
$buildConfigFile = Join-Path -Path $PSScriptRoot -ChildPath "build.json"
$buildConfig = Get-Content -Path $buildConfigFile | ConvertFrom-Json
$game_version_lesta = $buildConfig.game_version_lesta
$game_version_wg = $buildConfig.game_version_wg

Build-Packages -PackageDirectory "$PSScriptRoot/src/" -OutputDirectory "$PSScriptRoot/~output"

function Download-Translations($L10nDir) {
    $url = "https://translate.modxvm.com/downloads/xvm-client/xvm-client-l10n_json.zip"
    $tempDir = Join-Path -Path $PSScriptRoot -ChildPath "~output/temp_l10n"
    $zipFile = Join-Path -Path $tempDir -ChildPath "l10n.zip"

    if (Test-Path -Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
    New-Item -Path $tempDir -ItemType Directory -Force | Out-Null

    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $tempDir -Force

    Remove-Item -Path (Join-Path -Path $tempDir -ChildPath "ru.xc") -Force

    New-Item -Path $L10nDir -ItemType Directory -Force | Out-Null
    Copy-Item -Path "$tempDir/*" -Destination $L10nDir -Recurse -Force

    Remove-Item -Path $tempDir -Recurse -Force
}

function Copy-Deploy($OutputDirectory, $ThirdPartyDir, $ConfigsDir, $ReleaseDir, $LestaVersion, $WgVersion, $Version) {
    Write-Output "Copying deploy files..."
    
    $sourceDir = "$OutputDirectory/deploy"
    $deployFullDir = "$OutputDirectory/deploy_full"
    $lestaDir = "$deployFullDir/lesta/mods/$LestaVersion"
    $wgDir = "$deployFullDir/wg/mods/$WgVersion"
    
    # Clean up previous deployment
    if (Test-Path -Path $deployFullDir) {
        Remove-Item -Path $deployFullDir -Recurse -Force
    }

    # Create destination directories
    New-Item -Path $lestaDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path $wgDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

    $lestaResModsDir = "$deployFullDir/lesta/res_mods/$LestaVersion"
    $wgResModsDir = "$deployFullDir/wg/res_mods/$WgVersion"
    New-Item -Path $lestaResModsDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path $wgResModsDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    
    # Copy .wotmod files to wg directory
    Get-ChildItem -Path $sourceDir, $ThirdPartyDir -Filter "*.wotmod" -Recurse | ForEach-Object {
        $relativePath = $_.Directory.FullName.Substring($sourceDir.Length)
        if ($_.Directory.FullName.StartsWith($ThirdPartyDir)) {
            $relativePath = $_.Directory.FullName.Substring($ThirdPartyDir.Length)
        }
        $destinationPath = Join-Path -Path $wgDir -ChildPath $relativePath
        New-Item -Path $destinationPath -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
        Copy-Item -Path $_.FullName -Destination $destinationPath -Force
    }
    
    # Copy .mtmod files to lesta directory
    Get-ChildItem -Path $sourceDir, $ThirdPartyDir -Filter "*.mtmod" -Recurse | ForEach-Object {
        $relativePath = $_.Directory.FullName.Substring($sourceDir.Length)
        if ($_.Directory.FullName.StartsWith($ThirdPartyDir)) {
            $relativePath = $_.Directory.FullName.Substring($ThirdPartyDir.Length)
        }
        $destinationPath = Join-Path -Path $lestaDir -ChildPath $relativePath
        New-Item -Path $destinationPath -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
        Copy-Item -Path $_.FullName -Destination $destinationPath -Force
    }
    
    # Copy configs
    $lestaConfigsDir = "$deployFullDir/lesta/res_mods/configs/xvm"
    $wgConfigsDir = "$deployFullDir/wg/res_mods/configs/xvm"
    New-Item -Path $lestaConfigsDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path $wgConfigsDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    Copy-Item -Path "$ConfigsDir/*" -Destination $lestaConfigsDir -Recurse -Force
    Copy-Item -Path "$ConfigsDir/*" -Destination $wgConfigsDir -Recurse -Force

    # Copy release folders
    $lestaSharedDir = "$deployFullDir/lesta/res_mods/mods/shared_resources/xvm"
    $wgSharedDir = "$deployFullDir/wg/res_mods/mods/shared_resources/xvm"
    New-Item -Path $lestaSharedDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item -Path $wgSharedDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    Get-ChildItem -Path $ReleaseDir -Directory | Where-Object { $_.Name -ne "configs" } | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $lestaSharedDir -Recurse -Force
        Copy-Item -Path $_.FullName -Destination $wgSharedDir -Recurse -Force
    }

    # Download and unpack translations
    Download-Translations -L10nDir "$lestaSharedDir/l10n"
    Download-Translations -L10nDir "$wgSharedDir/l10n"

    $vcs_tag = Get-VcsLastTag
    $vcs_commits = Get-VcsCommitsCount
    $vcs_branch = Get-VcsBranch
    $vcs_hash = Get-VcsHash
    
    $zipFilePath = Join-Path -Path $OutputDirectory -ChildPath "xvm_$($vcs_tag)_$($vcs_commits)_$($vcs_branch)_$($vcs_hash).zip"
    if (Test-Path -Path $zipFilePath) {
        Remove-Item -Path $zipFilePath -Force
    }
    Create-Zip -Directory $deployFullDir -OutputFile $zipFilePath -CompressionLevel 9
}

$xvm_version = Get-VcsVersionString

Copy-Deploy -OutputDirectory "$PSScriptRoot/~output" -ThirdPartyDir "$PSScriptRoot/3rdparty_packages" -ConfigsDir "$PSScriptRoot/release/configs" -ReleaseDir "$PSScriptRoot/release" -LestaVersion $game_version_lesta -WgVersion $game_version_wg -Version $xvm_version

