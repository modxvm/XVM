$PSDefaultParameterValues['*:Encoding'] = 'utf8'
Set-Location $PSScriptRoot

function Get-LastVersionInfoHtml($filename) {
    $output = ((Get-Content -Path $filename -Raw) -replace '\r','' -split '\n\n### XVM ')[0]

    #skip empty lines
    $output = $output -replace '\r','' -replace '\n\n',"`n" -replace '______________________________',''
  
    #fix version header
    $output = $output -replace '^\s*?###\s?(.*)','<h3>$1</h3>'

    #fix group header
    $output = $output -replace '\n\s*?####\s*(.*)',"`n<h4>`$1</h4>"

    #add first level ul
    $output = $output -replace "</h4>`n","</h4>`n  <ul>`n"
    $output = $output -replace "<h4>","  </ul>`n<h4>"
    $output = $output -replace "</h3>`n  </ul>","<h3>`n"
    $output += "  </ul>"

    #add first level li
    $output = $output -replace "`n  \* (.*)","`n    <li>`$1</li>"

    #add second level ul li
    $output = $output -replace "`n    \*(.*)","`n    <ul>`n       <li>`$1</li>`n    </ul>"

    #replace `` with <b></b>
    $output = $output -replace '`(.*?)`','<code>$1</code>'

    return $output
}

function Get-LastVersionInfoTxt($filename) {
    $output = ((Get-Content -Path $filename -Raw) -replace '\r','' -split '\n\n### XVM ')[0]

    #skip empty lines
    $output = $output -replace '\r','' -replace '`','' -replace '\n\n',"`n"

    #fix version header
    $output = $output -replace '### XVM','XVM'

    #fix group header
    $output = $output -replace '  ####','* '
    $output = $output -replace '      ','    * '
    
    return $output
}

$changelog_en = Get-LastVersionInfoHtml "../release/doc/ChangeLog-en.md"
$changelog_ru = Get-LastVersionInfoHtml "../release/doc/ChangeLog-ru.md"

Write-Output $changelog_en
Write-Output $changelog_ru

(Get-Content -Path ../build/xvm-build.conf -Raw) -match '\nexport XVMBUILD_WOT_VERSION=\$\{TARGET_VERSION:-(.*?)\}' | Out-Null
$version_wot = $Matches[1]

(Get-Content -Path ../build/xvm-build.conf -Raw) -match '\nexport XVMBUILD_XVM_VERSION=\$\{XVM_VERSION:-(.*?)\}' | Out-Null
$version_xvm = $Matches[1]

$obj = @{
    title = "XVM "+$version_xvm
    type = "zip archive"
    wot_version = $version_wot
    descr_en = ($changelog_en -replace "\n","" -replace "\\n",'<br/>' -replace '"','\"')
    descr_ru = ($changelog_ru -replace "\n","" -replace "\\n",'<br/>' -replace '"','\"')
    md_5 = ""
}

Out-File -FilePath ("xvm-"+$version_xvm+".zip.json") -Encoding "UTF8" -InputObject (ConvertTo-Json $obj | % { [System.Text.RegularExpressions.Regex]::Unescape($_) })

$obj.type = "exe installer"

Out-File -FilePath("xvm-"+$version_xvm+".exe.json") -Encoding "UTF8" -InputObject (ConvertTo-Json $obj | % { [System.Text.RegularExpressions.Regex]::Unescape($_) })
