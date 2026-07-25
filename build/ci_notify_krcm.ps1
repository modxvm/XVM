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
# Globals / env validation
#

if(!$env:XVMBUILD_IPB_SERVER -and -not $DryRun){
    Write-Error "XVMBUILD_IPB_SERVER is not set"
    exit 1
}
$Global:ipb_server     = $env:XVMBUILD_IPB_SERVER

if(!$env:XVMBUILD_IPB_APIKEY -and -not $DryRun){
    Write-Error "XVMBUILD_IPB_APIKEY is not set"
    exit 1
}
$Global:ipb_apikey     = $env:XVMBUILD_IPB_APIKEY

if(!$env:XVMBUILD_IPB_USERID -and -not $DryRun){
    Write-Error "XVMBUILD_IPB_USERID is not set"
    exit 1
}
$Global:ipb_userid     = $env:XVMBUILD_IPB_USERID


if(!$env:XVMBUILD_IPB_TOPICID -and -not $DryRun){
    Write-Error "XVMBUILD_IPB_TOPICID is not set"
    exit 1
}
$Global:ipb_topicid     = $env:XVMBUILD_IPB_TOPICID



#
# Helpers
#

function HtmlEncode {
  param([string]$Text)
  if ($null -eq $Text) { return "" }
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
    [Parameter(Mandatory)][string]$Tag,
    [Parameter(Mandatory)][string]$Commits,
    [Parameter(Mandatory)][string]$Branch,
    [Parameter(Mandatory)][string]$Hash
  )
  $Branch = $Branch -replace '/','-'
  $baseName = "xvm_{0}_{1}_{2}_{3}{4}" -f $Tag, $Commits, $Branch, $Hash, $script:flavour_suffix
  [pscustomobject]@{
    Zip = "https://nightly.modxvm.com/download/$Branch/$baseName.zip"
    Exe = "https://nightly.modxvm.com/download/$Branch/$baseName.exe"
  }
}

function Build-IpbHtml {
  param(
    [Parameter(Mandatory)] $RepoStats,
    [Parameter(Mandatory)] $Urls,
    [Parameter(Mandatory)] $GameVersions
  )

  $author  = HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%an')
  $subject = HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%s')
  $body    = HtmlEncode (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%b')
  $date    = Get-Date (Get-VcsCommitText -RepositoryPath $script:repository_path -Format '%ci') `
    -Format "dd.MM.yyyy HH:mm (UTC)"

    $commitUrl = "https://gitlab.com/xvm/xvm/commit/$($RepoStats.Hash)"

    return @"
<b>Build: </b> <a href='$commitUrl'>$($RepoStats.Tag)_$($RepoStats.Commits) (branch $($RepoStats.Branch))</a><br/>
<b>WoT Version:</b> $($GameVersions.game_version_wg) (WG) / $($GameVersions.game_version_lesta) (Lesta)<br/>
<b>Date:</b> $date<br/>
<b>Download: </b> <a href='$($Urls.Zip)'>.zip archive</a> | <a href='$($Urls.Exe)'>.exe installer</a><br/>
<b>Author:</b> $author<br/>
<b>Description:</b> $subject<br/>
<pre>$body</pre>
<hr/>
"@
}

function Send-IpbPost {
  param([Parameter(Mandatory)][string]$Html)

  $uri  = "$($Global:ipb_server)/api/forums/posts"
  $body = @{
    key    = $Global:ipb_apikey
    author = $Global:ipb_userid
    topic  = $Global:ipb_topicid
    post   = $Html
  }
  $headers = @{ 'User-Agent' = 'XVM Build Server' }

  try {
    $resp = Invoke-RestMethod -Method Post -Uri $uri `
      -Headers $headers `
      -ContentType 'application/x-www-form-urlencoded' `
      -Body $body `
      -TimeoutSec 2 `
      -SkipCertificateCheck

    # IPB returns the created post JSON on success; treat any non-object as error-ish.
    if (-not $resp) {
      Write-Error "Empty response from IPB API."
      exit 1
    }
  }
  catch {
    Write-Error "Failed to post to IPB: $($_.Exception.Message)"
    exit 1
  }
}

#
# Notify
#
$versions = Get-Content "$PSScriptRoot/../build.json" -Raw | ConvertFrom-Json
$stats    = Get-RepoStats
$urls     = Build-ArtifactUrls -Tag $stats.Tag -Commits $stats.Commits -Branch $stats.Branch -Hash $stats.Hash
$html     = Build-IpbHtml -RepoStats $stats -Urls $urls -GameVersions $versions
if ($DryRun) { Write-Output $html }
else {
  Send-IpbPost -Html $html
  Write-Host "IPB notification posted for $($stats.Tag)_$($stats.Commits) on branch $($stats.Branch)."
}
