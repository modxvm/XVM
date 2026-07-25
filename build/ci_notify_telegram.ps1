#!/usr/bin/env pwsh
# SPDX-License-Identifier: LGPL-3.0-or-later
# Copyright (c) 2013-2026 XVM Contributors

param(
    [string[]] $Flavours = @('Lesta', 'WG'),
    [switch] $DryRun
)

$ErrorActionPreference = 'Stop'

#
# Imports
#
Import-Module "$PSScriptRoot/../src_build/library.psm1" -Force -DisableNameChecking
$script:repository_path = [System.IO.Path]::GetFullPath("$PSScriptRoot/..")
$script:flavours = @(Resolve-BuildFlavours $Flavours)
$script:flavour_suffix = $script:flavours.Count -eq 1 ? "_$($script:flavours[0])" : ''



#
# Globals 
#

if(!$env:TELEGRAM_TOKEN -and -not $DryRun){
    Write-Error "TELEGRAM_TOKEN is not set"
    exit 1
}
$Global:telegram_token     = $env:TELEGRAM_TOKEN

if(!$env:TELEGRAM_CHAT_ID -and -not $DryRun){
    Write-Error "TELEGRAM_CHAT_ID is not set"
    exit 1
}
$Global:telegram_chatid     = $env:TELEGRAM_CHAT_ID



#
# Helpers
#

function HtmlEncode {
    param([string]$Text)
    if ($null -eq $Text) { 
        return "" 
    }
    $Text -replace '&','&amp;' -replace '<','&lt;' -replace '>','&gt;'
}



function Get-RepoStats {
    $branch  = Get-VcsBranch -RepositoryPath $script:repository_path
    $tag     = Get-VcsLastTag -RepositoryPath $script:repository_path
    $commits = Get-VcsCommitsCount -RepositoryPath $script:repository_path -Tag $tag
    $hash    = Get-VcsHash -RepositoryPath $script:repository_path
    return @{
        Branch  = "$branch".Trim()
        Commits = "$commits".Trim()
        Hash    = "$hash".Trim()
        Tag     = "$tag".Trim()
    }
}

function Build-ArtifactUrls {
    param(
        [Parameter(Mandatory)] [string]$Tag,
        [Parameter(Mandatory)] [string]$Commits,
        [Parameter(Mandatory)] [string]$Branch,
        [Parameter(Mandatory)] [string]$Hash
    )
    $Branch = $Branch -replace '/','-'
    $baseName = "xvm_{0}_{1}_{2}_{3}{4}" -f $Tag, $Commits, $Branch, $Hash, $script:flavour_suffix
    [pscustomobject]@{
        Zip = "https://nightly.modxvm.com/download/$Branch/$baseName.zip"
        Exe = "https://nightly.modxvm.com/download/$Branch/$baseName.exe"
    }
}

function Build-TelegramHtml {
    param(
        [Parameter(Mandatory)] $RepoStats,
        [Parameter(Mandatory)] $Urls,
        [Parameter(Mandatory)] $GameVersions
    )
    $author = HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%an')
    $subject= HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%s')
    $body   = HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%b')
    $date   = Get-Date (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%ci') `
        -Format "dd.MM.yyyy HH:mm (UTC)"

    # Try to link to commit/branch like GitHub/GitLab; if paths differ in your forge, tweak below.
    $commitUrl = "https://gitlab.com/xvm/xvm/commit/$($RepoStats.Hash)"
    $branchUrl = "https://gitlab.com/xvm/xvm/tree/$($RepoStats.Branch)"

    return @"
<b>Build:</b> <a href='$commitUrl'>$($RepoStats.Tag)_$($RepoStats.Commits) (branch $($RepoStats.Branch))</a>
<b>WoT version:</b> $($GameVersions.game_version_wg) (WG) / $($GameVersions.game_version_lesta) (Lesta)
<b>Date:</b> $date
<b>Download:</b> <a href='$($Urls.Zip)'>.zip archive</a> | <a href='$($Urls.Exe)'>.exe installer</a>
<b>Author:</b> $author
<b>Description:</b> $subject
<pre>$body</pre>
"@
}

function Send-TelegramHtmlMessage {
    param([Parameter(Mandatory)][string]$Html)
    $uri  = "https://api.telegram.org/bot$($Global:telegram_token)/sendMessage"
    $body = @{
        chat_id                  = $Global:telegram_chatid
        text                     = $Html
        parse_mode               = "HTML"
        disable_web_page_preview = $true
    }
    try {
        $resp = Invoke-RestMethod -Method Post -Uri $uri -Body $body
        if (-not $resp.ok) {
            Write-Error "Telegram API error: $($resp | ConvertTo-Json -Depth 5)"
            exit 1
        }
    }
    catch {
        Write-Error "Failed to send Telegram message: $($_.Exception.Message)"
        exit 1
    }
}


#
# Notify
#

$versions = Get-Content "$PSScriptRoot/../build.json" -Raw | ConvertFrom-Json
$stats = Get-RepoStats
$urls  = Build-ArtifactUrls -Tag $stats.Tag -Commits $stats.Commits -Branch $stats.Branch -Hash $stats.Hash
$html  = Build-TelegramHtml -RepoStats $stats -Urls $urls -GameVersions $versions
if ($DryRun) { Write-Output $html }
else { Send-TelegramHtmlMessage -Html $html }
