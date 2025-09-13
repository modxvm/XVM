#!/usr/bin/env pwsh

# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2025 XVM Contributors

#
# Imports
#

Import-Module "$PSScriptRoot/../src_build/library.psm1" -Force -DisableNameChecking
Import-Module Posh-SSH



#
# Globals
#

if(!$env:XVMBUILD_UPLOAD_HOST){
    Write-Error "XVMBUILD_UPLOAD_HOST is not set"
    exit 1
}
$Global:ssh_nightly_host     = $env:XVMBUILD_UPLOAD_HOST

if(!$env:XVMBUILD_UPLOAD_USER){
    Write-Error "XVMBUILD_UPLOAD_USER is not set"
    exit 1
}
$Global:ssh_nightly_user     = $env:XVMBUILD_UPLOAD_USER

if(!$env:XVMBUILD_UPLOAD_PORT){
    Write-Error "XVMBUILD_UPLOAD_PORT is not set"
    exit 1
}
$Global:ssh_nightly_port     = $env:XVMBUILD_UPLOAD_PORT

if(!$env:XVMBUILD_UPLOAD_PASSWORD){
    Write-Error "XVMBUILD_UPLOAD_PASSWORD is not set"
    exit 1
}
$Global:ssh_nightly_password = $env:XVMBUILD_UPLOAD_PASSWORD

if(!$env:XVMBUILD_UPLOAD_PATH){
    Write-Error "XVMBUILD_UPLOAD_PATH is not set"
    exit 1
}
$Global:ssh_nightly_path      = $env:XVMBUILD_UPLOAD_PATH



#
# Helpers
#

function Invoke-SshCommandBuild {
    param($Command)
    $credential = New-Object System.Management.Automation.PSCredential($Global:ssh_nightly_user, (ConvertTo-SecureString $Global:ssh_nightly_password -AsPlainText -Force))
    $sshSession = New-SSHSession -ComputerName $Global:ssh_nightly_host -Port $Global:ssh_nightly_port -Credential $credential -AcceptKey -Verbose
    Invoke-SSHCommand -SSHSession $sshSession -Command $Command
    Remove-SSHSession -SSHSession $sshSession
}

function Invoke-SftpUpload {
    param($LocalPath, $RemotePath)
    $credential = New-Object System.Management.Automation.PSCredential($Global:ssh_nightly_user, (ConvertTo-SecureString $Global:ssh_nightly_password -AsPlainText -Force))
    $sftpSession = New-SFTPSession -ComputerName $Global:ssh_nightly_host -Port $Global:ssh_nightly_port -Credential $credential -AcceptKey -Verbose
    Set-SFTPItem -SFTPSession $sftpSession -Path $LocalPath -Destination $RemotePath -Force
    Remove-SFTPSession -SFTPSession $sftpSession
}



#
# Deploy
#

function Deploy-NightlyFiles {
    Write-Output "Deploy data"

    # get VCS info
    $vcs_branch = $(Get-VcsBranch) -replace '/','-'
    $vcs_commits = Get-VcsCommitsCount
    $vcs_hash = Get-VcsHash
    $vcs_tag = Get-VcsLastTag
    
    # create directory
    Invoke-SshCommandBuild -Command "mkdir -p ${$Global:ssh_nightly_path}/${vcs_branch}/"

    # upload zip
    $path_zip_local  = "$PSScriptRoot/../~output/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.zip"
    $path_zip_remote = "$Global:ssh_nightly_path/${vcs_branch}/"
    Invoke-SftpUpload -LocalPath $path_zip_local -RemotePath $path_zip_remote
        
    # upload installer
    $path_installer_local   = "$PSScriptRoot/../~output/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.exe"
    $path_installer_remote  = "$Global:ssh_nightly_path/${vcs_branch}/"
    Invoke-SftpUpload -LocalPath $path_installer_local -RemotePath $path_installer_remote
}

function Deploy-NightlyMeta {
    Write-Output "Deploy meta"

    $vcs_branch = $(Get-VcsBranch) -replace '/','-'
    $vcs_commits = Get-VcsCommitsCount
    $vcs_hash = Get-VcsHash
    $vcs_tag = Get-VcsLastTag
    $build_info = Get-Content -Raw -Path "$PSScriptRoot/../build.json" | ConvertFrom-Json

    # MODXVM meta
    $mxDate = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
    $mxSizeExe = (Get-Item -Path "$PSScriptRoot/../~output/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.exe").Length
    $mxSizeZip = (Get-Item -Path "$PSScriptRoot/../~output/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.zip").Length
    $mxUrlZip = "https://nightly.modxvm.com/download/${vcs_branch}/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.zip"
    $mxUrlExe = "https://nightly.modxvm.com/download/${vcs_branch}/xvm_${vcs_tag}_${vcs_commits}_${vcs_branch}_${vcs_hash}.exe"

    $path_meta_template    = "$PSScriptRoot/ci_deploy.json.template"
    $path_meta_local       = "$PSScriptRoot/../~output/dl_meta.json"
    $path_meta_remote      = "$Global:ssh_nightly_path/${vcs_branch}/"
    $path_meta_remote_root = "$Global:ssh_nightly_path/"
    
    $template = Get-Content -Path $path_meta_template -Raw
    $template -replace 'XVMBUILD_MX_DATE', $mxDate `
        -replace 'XVMBUILD_MX_SIZE_EXE', $mxSizeExe `
        -replace 'XVMBUILD_MX_SIZE_ZIP', $mxSizeZip `
        -replace 'REPOSITORY_BRANCH', $vcs_branch `
        -replace 'REPOSITORY_HASH', $vcs_hash `
        -replace 'XVMBUILD_XVM_VERSION', $vcs_tag `
        -replace 'REPOSITORY_COMMITS_NUMBER', $vcs_commits `
        -replace 'XVMBUILD_WOT_VERSION_wg', $build_info.game_version_wg `
        -replace 'XVMBUILD_WOT_VERSION_lesta', $build_info.game_version_lesta `
        -replace 'XVMBUILD_MX_URL_EXE', $mxUrlExe `
        -replace 'XVMBUILD_MX_URL_ZIP', $mxUrlZip | Set-Content -Path $path_meta_local

    Invoke-SftpUpload -LocalPath $path_meta_local -RemotePath $path_meta_remote
    if($vcs_branch -eq "master"){
        Invoke-SftpUpload -LocalPath $path_meta_local -RemotePath $path_meta_remote_root
    }
}

Deploy-NightlyFiles
Deploy-NightlyMeta
