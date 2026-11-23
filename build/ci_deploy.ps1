#!/usr/bin/env pwsh

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2026 XVM Contributors

param(
    [string[]] $Flavours = @('Lesta', 'WG')
)

$ErrorActionPreference = 'Stop'
# Check SSH/SFTP exit codes explicitly without changing the build module's Git handling.
$PSNativeCommandUseErrorActionPreference = $false

Import-Module "$PSScriptRoot/../src_build/library.psm1" -Force -DisableNameChecking
$flavours = @(Resolve-BuildFlavours $Flavours)
$flavour_suffix = $flavours.Count -eq 1 ? "_$($flavours[0])" : ''

foreach ($name in @('XVMBUILD_UPLOAD_HOST', 'XVMBUILD_UPLOAD_USER', 'XVMBUILD_UPLOAD_PORT', 'XVMBUILD_UPLOAD_PATH')) {
    if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($name))) {
        throw "$name is not set"
    }
}

$ssh = (Get-Command ssh -CommandType Application -TotalCount 1).Source
$sftp = (Get-Command sftp -CommandType Application -TotalCount 1).Source
$sshHost = $env:XVMBUILD_UPLOAD_HOST.Trim('[', ']')
$sftpHost = $sshHost.Contains(':') ? "[$sshHost]" : $sshHost
$nullDevice = $IsWindows ? 'NUL' : '/dev/null'
$sshOptions = @(
    '-F', 'none',
    '-o', "User=$env:XVMBUILD_UPLOAD_USER",
    '-o', "Port=$env:XVMBUILD_UPLOAD_PORT",
    '-o', 'ConnectTimeout=15',
    '-o', 'StrictHostKeyChecking=no',
    '-o', 'GlobalKnownHostsFile=none',
    '-o', "UserKnownHostsFile=$nullDevice"
)

function New-SftpPutCommand([string] $LocalPath, [string] $RemoteDirectory) {
    if ($IsWindows) {
        $LocalPath = $LocalPath.Replace('\', '/')
    }
    if ($LocalPath -match '[\r\n]' -or $RemoteDirectory -match '[\r\n]') {
        throw 'SFTP batch paths must not contain line breaks'
    }
    $local = $LocalPath.Replace('\', '\\').Replace('"', '\"')
    $remote = $RemoteDirectory.Replace('\', '\\').Replace('"', '\"')
    'put -- "{0}" "{1}"' -f $local, $remote
}

function Invoke-SftpBatch([string[]] $Commands) {
    # In password mode, the earlier BatchMode=no takes precedence over sftp -b's BatchMode=yes.
    $Commands | & $sftp @sshOptions -b - -- $sftpHost
    if ($LASTEXITCODE -ne 0) {
        throw "sftp upload failed (exit code $LASTEXITCODE)"
    }
}

function Publish-Nightly {
    $repository = "$PSScriptRoot/.."
    $vcs_branch = (Get-VcsBranch -RepositoryPath $repository) -replace '/', '-'
    $vcs_tag = Get-VcsLastTag -RepositoryPath $repository
    $vcs_commits = Get-VcsCommitsCount -RepositoryPath $repository -Tag $vcs_tag
    $vcs_hash = Get-VcsHash -RepositoryPath $repository
    $artifactName = "xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}${flavour_suffix}"
    $outputDirectory = [System.IO.Path]::GetFullPath("$repository/~output")
    $remoteRoot = $env:XVMBUILD_UPLOAD_PATH.TrimEnd('/') + '/'
    $remoteBranch = "$remoteRoot$vcs_branch/"

    Write-Output 'Deploy data'
    $zip = Get-Item -LiteralPath "$outputDirectory/$artifactName.zip"
    $installer = Get-Item -LiteralPath "$outputDirectory/$artifactName.exe"
    $artifactCommands = @(
        New-SftpPutCommand $zip.FullName $remoteBranch
        New-SftpPutCommand $installer.FullName $remoteBranch
    )
    # SSH executes the command through a remote shell, so quote the entire directory path.
    $quotedBranch = "'" + $remoteBranch.Replace("'", "'\''") + "'"
    & $ssh @sshOptions -n -- $sshHost "mkdir -p -- $quotedBranch"
    if ($LASTEXITCODE -ne 0) {
        throw "ssh remote mkdir failed (exit code $LASTEXITCODE)"
    }
    Invoke-SftpBatch $artifactCommands

    Write-Output 'Deploy meta'
    $build_info = Get-Content -LiteralPath "$repository/build.json" -Raw | ConvertFrom-Json
    $versionWg = 'wg' -in $flavours ? $build_info.game_version_wg : ''
    $versionLesta = 'lesta' -in $flavours ? $build_info.game_version_lesta : ''
    $mxDate = Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz'
    $mxUrl = "https://nightly.modxvm.com/download/$vcs_branch/$artifactName"
    $path_meta_local = "$outputDirectory/dl_meta${flavour_suffix}.json"

    $template = Get-Content -LiteralPath "$PSScriptRoot/ci_deploy.json.template" -Raw
    $template -replace 'XVMBUILD_MX_DATE', $mxDate `
        -replace 'XVMBUILD_MX_SIZE_EXE', $installer.Length `
        -replace 'XVMBUILD_MX_SIZE_ZIP', $zip.Length `
        -replace 'REPOSITORY_BRANCH', $vcs_branch `
        -replace 'REPOSITORY_HASH', $vcs_hash `
        -replace 'XVMBUILD_XVM_VERSION', $vcs_tag `
        -replace 'REPOSITORY_COMMITS_NUMBER', $vcs_commits `
        -replace 'XVMBUILD_WOT_VERSION_wg', $versionWg `
        -replace 'XVMBUILD_WOT_VERSION_lesta', $versionLesta `
        -replace 'XVMBUILD_MX_URL_EXE', "$mxUrl.exe" `
        -replace 'XVMBUILD_MX_URL_ZIP', "$mxUrl.zip" | Set-Content -LiteralPath $path_meta_local

    $metaCommands = @(New-SftpPutCommand $path_meta_local $remoteBranch)
    if ($vcs_branch -eq 'master') {
        $metaCommands += New-SftpPutCommand $path_meta_local $remoteRoot
    }
    Invoke-SftpBatch $metaCommands
}

if ($env:XVMBUILD_UPLOAD_PASSWORD) {
    if ($IsWindows) {
        throw 'Password authentication requires a Unix runner with OpenSSH 8.4 or newer'
    }
    $sshOptions += @('-o', 'BatchMode=no', '-o', 'PreferredAuthentications=password,keyboard-interactive', '-o', 'NumberOfPasswordPrompts=1')
    $originalAskPass = $env:SSH_ASKPASS
    $originalAskPassRequire = $env:SSH_ASKPASS_REQUIRE
    $askPassDirectory = [System.IO.Directory]::CreateTempSubdirectory('xvm-askpass-')
    try {
        $askPass = Join-Path $askPassDirectory.FullName 'askpass'
        # Only the helper code is written to disk; the password stays in the environment.
        $helper = @'
#!/bin/sh
case "$1" in
    *[Pp]assword*) printf '%s\n' "$XVMBUILD_UPLOAD_PASSWORD" ;;
    *) exit 1 ;;
esac
'@
        [System.IO.File]::WriteAllText($askPass, $helper.Replace("`r`n", "`n") + "`n")
        [System.IO.File]::SetUnixFileMode($askPass, [System.IO.UnixFileMode]'UserRead, UserExecute')
        $env:SSH_ASKPASS = $askPass
        $env:SSH_ASKPASS_REQUIRE = 'force'
        Publish-Nightly
    }
    finally {
        $env:SSH_ASKPASS = $originalAskPass
        $env:SSH_ASKPASS_REQUIRE = $originalAskPassRequire
        $askPassDirectory.Delete($true)
    }
}
else {
    if (!$env:XVMBUILD_UPLOAD_PRIVATE_KEY) {
        throw 'Set XVMBUILD_UPLOAD_PASSWORD or XVMBUILD_UPLOAD_PRIVATE_KEY'
    }
    if (!(Test-Path -LiteralPath $env:XVMBUILD_UPLOAD_PRIVATE_KEY -PathType Leaf)) {
        throw 'XVMBUILD_UPLOAD_PRIVATE_KEY must point to a file (use a GitLab CI/CD variable of type File)'
    }
    $privateKey = (Get-Item -LiteralPath $env:XVMBUILD_UPLOAD_PRIVATE_KEY).FullName
    if (!$IsWindows) {
        [System.IO.File]::SetUnixFileMode($privateKey, [System.IO.UnixFileMode]'UserRead, UserWrite')
    }
    $sshOptions += @('-i', $privateKey, '-o', 'BatchMode=yes', '-o', 'IdentitiesOnly=yes')
    Publish-Nightly
}
