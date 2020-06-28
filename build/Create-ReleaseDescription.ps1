$PSDefaultParameterValues['*:Encoding'] = 'utf8'
Set-Location $PSScriptRoot

$header_en = '<a href=\"https://gitlab.com/xvm/xvm/raw/master/release/doc/ChangeLog-en.md\">Full ChangeLog</a><br/><br/>'
$header_ru = '<a href=\"https://gitlab.com/xvm/xvm/raw/master/release/doc/ChangeLog-ru.md\">Полный список изменений</a><br/><br/>'

$changelog_en = ((Get-Content -Path ../release/doc/ChangeLog-en.md -Raw) -replace '\r','' -split '\n\n### XVM ')[0]
$changelog_ru = ((Get-Content -Path ../release/doc/ChangeLog-ru.md -Raw) -replace '\r','' -split '\n\n### XVM ')[0]

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
