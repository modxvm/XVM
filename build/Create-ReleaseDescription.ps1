Set-Location $PSScriptRoot

$header_en = '<a href=\"https://bitbucket.org/XVM/xvm/src/default/release/doc/ChangeLog-en.txt\">Full ChangeLog</a><br/><br/>'
$header_ru = '<a href=\"https://bitbucket.org/XVM/xvm/src/default/release/doc/ChangeLog-ru.txt\">Полный список изменений</a><br/><br/>'

$changelog_en = ((Get-Content -Path ../release/doc/ChangeLog-en.txt -Raw) -replace '\r','' -split '\n\nXVM-')[0]
$changelog_ru = ((Get-Content -Path ../release/doc/ChangeLog-ru.txt -Raw) -replace '\r','' -split '\n\nXVM-')[0]

(Get-Content -Path ../build/xvm-build.conf -Raw) -match '\nexport XVMBUILD_WOT_VERSION=\$\{TARGET_VERSION:-(.*?)\}' | Out-Null
$version_wot = $Matches[1]

(Get-Content -Path ../build/xvm-build.conf -Raw) -match '\nexport XVMBUILD_XVM_VERSION=\$\{XVM_VERSION:-(.*?)\}' | Out-Null
$version_xvm = $Matches[1]

$obj = @{
    title = "XVM "+$version_xvm
    type = "zip archive"
    wot_version = $version_wot
    descr_en = $header_en + ($changelog_en -replace "\n",'<br/>' -replace '"','\"')
    descr_ru = $header_ru + ($changelog_ru -replace "\n",'<br/>' -replace '"','\"')
    md_5 = ""
}

Out-File -FilePath ("xvm-"+$version_xvm+".zip.json") -Encoding "UTF8" -InputObject (ConvertTo-Json $obj | % { [System.Text.RegularExpressions.Regex]::Unescape($_) })

$obj.type = "exe installer"

Out-File -FilePath("xvm-"+$version_xvm+".exe.json") -Encoding "UTF8" -InputObject (ConvertTo-Json $obj | % { [System.Text.RegularExpressions.Regex]::Unescape($_) })
