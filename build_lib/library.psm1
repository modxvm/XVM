# This file is part of the XVM Framework project.
#
# Copyright (c) 2017-2021 XVM Team.
#
# XVM Framework is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# XVM Framework is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

$xvm_pslib_version="2020.05.03"

function Build-AS3Proj($Project)
{
    if(${env:XVMBUILD_FDBUILD_FILEPATH} -eq $null)
    {
        Find-FDBuild -Required
    }

    if($(Get-OS) -eq "windows")
    {
        Invoke-Expression -Command "${env:XVMBUILD_FDBUILD_FILEPATH} -notrace -compiler:'${env:FLEX_HOME}' -cp:'' '$Project'"
    }
    else
    {
        if(${env:XVMBUILD_MONO_FILEPATH} -eq $null)
        {
            Find-Mono -Required | Out-Null
        }
        Invoke-Expression -Command "${env:XVMBUILD_MONO_FILEPATH} `"${env:XVMBUILD_FDBUILD_FILEPATH}`" -notrace -compiler:`"${env:FLEX_HOME}`" -cp:`"`" `"$Project`""
    }

    if($LASTEXITCODE -ne 0)
    {
        exit 1
    }
}

function Build-PythonFile($FilePath, $OutputDirectory, $OutputFileName = $null, [Switch] $UseHashTable)
{
    $python = Find-Python -Required

    $relativePath = $(Resolve-Path -Path $FilePath -Relative).Replace(".\","")

    if($UseHashTable -eq $true)
    {
        if(Test-Path "$OutputDirectory/")
        {
            if(!$hashtable.FileNeedUpdate($relativePath,$relativePath))
            {
                continue
            }
        }
    }

    Write-Output "  * ${relativePath}"

    & $python.Path -m py_compile "${FilePath}" | Out-Null

    if($(Test-Path "${OutputDirectory}") -eq $false)
    {
        New-Item -ItemType Directory "${OutputDirectory}" | Out-Null
    }

    Move-Item "${FilePath}c" "${OutputDirectory}" -Force

    if ($OutputFileName -ne $null) {
        $filename = Split-Path "${FilePath}c" -Leaf
        Move-Item (Join-Path "${OutputDirectory}" "${filename}") (Join-Path "${OutputDirectory}" "${OutputFileName}")
    }


    if($UseHashTable -eq $true)
    {
        $hashtable.UpdateFileHash($relativePath,$relativePath)
    }
}


function Build-PythonDirectory($FileDirectory, $OutputDirectory, [Switch] $UseHashTable)
{
    $dir_in = Resolve-Path $FileDirectory

    New-Item -Path $OutputDirectory -ItemType Directory -Force -ErrorAction SilentlyContinue
    $dir_out = Resolve-Path $OutputDirectory

    Push-Location -Path $dir_in

    foreach($file in $(Get-ChildItem -Path $dir_in -Filter "*.py" -Recurse))
    {
        $refpath = Resolve-Path $file.FullName -Relative
        $outdir = Split-Path $(Join-Path -Path $dir_out -ChildPath $refpath) -Parent

        Build-PythonFile -FilePath $file.FullName -OutputDirectory $outdir
    }

    Pop-Location
}

function Get-Architecture()
{
    $os = Get-OS

    if($os -eq "windows")
    {
        switch(${env:PROCESSOR_ARCHITECTURE})
        {
            AMD64
            {
                return "amd64"
            }

            x86
            {
                return "i686"
            }
        }
    }
    elseif($os -eq "linux")
    {
        switch ($(uname -m))
        {
            x86_64
            {
                return "amd64"
            }
        }
    }

    return "Unknown"
}

function Get-OS()
{
    if($PSVersionTable.PSEdition -ne "Core")
    {
        return "windows"
    }

    if($PSVersionTable.OS.StartsWith("Microsoft"))
    {
        return "windows"
    }

    if($PSVersionTable.OS.StartsWith("Linux"))
    {
        return "linux"
    }

    return "unknown"
}

function Get-MercurialRepoStats($Path)
{
    Find-Mercurial -Required

    if($Path -eq $null)
    {
        $Path = $PWD.Path
    }

    #shitty hack: add leading zeros to rev to fix WoT version comparison algorithm
    $rev = $(hg parent --template "{rev}")
    $rev_zerocount = 5 - $rev.Length
    while ($rev_zerocount -gt 0) {
        $rev = "0" + $rev
        $rev_zerocount --
    }

    return  @{
        "Author"      = $(hg parent --template "{author}")
        "Branch"      = $(hg parent --template "{branch}")
        "Date"        = $(hg parent --template "{date|isodate}")
        "Description" = $(hg parent --template "{desc}")
        "Hash"        = $(hg parent --template "{node|short}")
        "Revision"    = $rev
        "Tags"        = $(hg parent --template "{tags}")
    }
}

function Edit-Path ($Path, [switch] $Append, [switch] $Prepend)
{
    $os = Get-OS


    if($Append)
    {
        if($os -eq "windows")
        {
            ${env:PATH}="${env:PATH};${Path}"
        }
        else
        {
            ${env:PATH}="${env:PATH}:${Path}"
        }
    }

    if($Prepend)
    {
        if($os -eq "windows")
        {
            ${env:PATH}="${Path};${env:PATH}"
        }
        else
        {
            ${env:PATH}="${Path}:${env:PATH}"
        }
    }

}

function Find-Application([string] $Command, [Switch] $Required)
{
    $cmd = Get-Command -Name $Command -ErrorAction SilentlyContinue

    if($cmd)
    {
        return $cmd.Path
    }

    if($Required)
    {
        Write-Error -Message "$($Command) is required"
        exit 1
    }

    return $false
}

function Find-FDBuild([Switch] $Required)
{
    if(${env:XVMBUILD_FDBUILD_FILEPATH})
    {
        $path = Find-Application ${env:XVMBUILD_FDBUILD_FILEPATH} -Required:$false
    }

    if(!$path)
    {
        $path = Find-Application "fdbuild" -Required:$false
    }

    if(!$path)
    {
        Edit-Path -Path "${PSScriptRoot}/bin/msil/fdbuild/" -Prepend
        $path = Find-Application "fdbuild.exe" -Required:$Required
    }

    ${env:XVMBUILD_FDBUILD_FILEPATH} = $path
    return $path
}

function Find-Flex([Switch] $Required)
{
    $playerVersions = ("11.0", "11.1")
    $os = Get-OS
    $java = Find-Java -Required:$Required

    if($java -eq $null)
    {
        return $false
    }

    #flex_home
    if(${env:FLEX_HOME} -eq $null)
    {
        if($os -eq "windows")
        {
            ${env:FLEX_HOME}="${env:LOCALAPPDATA}/FlashDevelop/Apps/flexsdk/4.6.0"
        }
        else {
            ${env:FLEX_HOME}="/opt/apache-flex"
        }
    }

    if(!$(Test-Path ${env:FLEX_HOME}))
    {
        if($Required)
        {
            Write-Error "Apache Flex directory is not found"
            exit 1
        }
        return $false
    }

    Edit-Path -Path "${env:FLEX_HOME}/bin/" -Append

    #compc
    if($os -eq "windows")
    {
        ${env:XVMBUILD_COMPC_FILEPATH}=Join-Path "${env:FLEX_HOME}" "bin/compc.bat"
    }
    else
    {
        ${env:XVMBUILD_COMPC_FILEPATH}=Join-Path "${env:FLEX_HOME}" "bin/compc"
    }
    if(!$(Test-Path ${env:XVMBUILD_COMPC_FILEPATH}))
    {
        if($Required)
        {
            Write-Error "Apache Flex compc file is not found"
            exit 1
        }
        return $false
    }

    #playerglobal
    if(${env:PLAYERGLOBAL_HOME} -eq $null)
    {
        ${env:PLAYERGLOBAL_HOME} = Join-Path "${env:FLEX_HOME}" "frameworks/libs/player/"
    }

    foreach($playerVersion in $playerVersions)
    {
        $filepath = Join-Path "${env:PLAYERGLOBAL_HOME}" "${playerVersion}"
        $filepath = Join-Path "${filepath}" "playerglobal.swc"
        if(!(Test-Path $filepath))
        {
            New-Item -ItemType Directory -Path $(Split-Path -Parent $filepath) -ErrorAction SilentlyContinue

            Invoke-WebRequest -Uri "https://github.com/nexussays/playerglobal/raw/master/${playerVersion}/playerglobal.swc"  -OutFile $filepath
        }
    }

    return ${env:FLEX_HOME}
}

function Find-Git([Switch] $Required)
{
    return Find-Application "git" -Required:$Required
}

function Find-Java([Switch] $Required)
{
    return Find-Application "java" -Required:$Required
}

function Find-Mercurial([Switch] $Required)
{
    return Find-Application "hg" -Required:$Required
}

function Find-Mono([Switch] $Required)
{
    if(${env:XVMBUILD_MONO_FILEPATH})
    {
        if(Find-Application ${env:XVMBUILD_MONO_FILEPATH})
        {
            return $true
        }
    }

    $os = $(Get-OS)

    if($os -eq "windows")
    {
        return $false
    }

    $path = Find-Application "mono" -Required:$Required
    if(!$path)
    {
        return $false
    }

    ${env:XVMBUILD_MONO_FILEPATH} = $path

    return $path
}

function Find-Mtasc([Switch] $Required)
{
    return Find-Application "mtasc" -Required:$Required
}

function Find-Patch([Switch] $Required)
{
    $patchProgram =  Find-Application "patch" -Required:$false

    if(!$patchProgram)
    {
        $os = Get-OS
        if($os -eq "windows")
        {
            $patchDir="$PSScriptRoot/bin/${os}_i686/patch"
        }
        else
        {
            $patchDir="$PSScriptRoot/bin/${os}_${Get-Architecture}/patch"
        }

        Edit-Path -Path "${patchDir}" -Prepend

        $patchProgram = Find-Application "patch" -Required:$Required
    }
    return $patchProgram
}

function Find-Python([Switch] $Required)
{
    $appNames = @(
        "python2.7",
        "python2",

        "C:\Python27\python.exe",,
        "C:\Python27_32\python.exe",
        "C:\Python27_64\python.exe",

        "C:\Python\27\python.exe"
        "C:\Python\27_32\python.exe",
        "C:\Python\27_64\python.exe",

        "python"
    )

    $path = $null;

    foreach ($appname in $appNames) {
        $path = Find-Application $appname

        if(!$path){
            continue;
        }

        #Fix Windows 19.03 Windows Store install invitation
        if((Get-Item -Path $path).Length -eq 0){
            $path = $null
        }

        if($null -ne $path){
            break;
        }
    }

    if(!$path)
    {
        if($Required)
        {
            Write-Error -Message "Python is required"
            exit 1
        }
        return $false
    }

    $version = (Invoke-Expression "${path} -c 'import sys; print(sys.version)'") -replace "Python ",""

    if(!$version.StartsWith("2.7"))
    {
        Write-Error -Message "Python 2.7 is required, current version: ${version}"
        exit 1
    }

    $directory = Split-Path -Path $path

    Edit-Path -Path "${directory}" -Prepend

    return @{
        "Path" = $path
        "Directory" = $directory
        "Version" = $version
    }
}

function Find-Rabcdasm([Switch] $Required)
{
    $path =  Find-Application "rabcdasm" -Required:$false
    if(!$path)
    {
        $os = Get-OS
        if($os -eq "windows")
        {
            $rabcdasmDir="$PSScriptRoot/bin/${os}_i686/swf-disasm"
        }
        else
        {
            $rabcdasmDir="$PSScriptRoot/bin/${os}_$(Get-Architecture)/swf-disasm"
        }

        Edit-Path -Path "${rabcdasmDir}" -Prepend

        $path = Find-Application "rabcdasm" -Required:$Required
    }

    return $path
}

function Find-Unzip([Switch] $Required)
{
    return Find-Application "unzip" -Required:$Required
}

function Find-Wget([Switch] $Required)
{
    return Find-Application "wget" -Required:$Required
}

function Find-Zip([Switch] $Required)
{
    $zipProgram =  Find-Application "zip" -Required:$false

    if(!$zipProgram)
    {
        $os = Get-OS
        if($os -eq "windows")
        {
            $zipDir="$PSScriptRoot/bin/${os}_i686/zip"
        }
        else
        {
            $zipDir="$PSScriptRoot/bin/${os}_${Get-Architecture}/zip"
        }

        Edit-Path -Path "${zipDir}" -Prepend

        $zipProgram = Find-Application "zip" -Required:$Required
    }
    return $zipProgram
}

function Create-Zip($Directory, $CompressionLevel=0)
{
    Push-Location $Directory

    Find-Zip -Required | Out-Null
    zip -$CompressionLevel -q -X -r ./output.zip ./*

    Pop-Location
}

#region FileHashTable

function Get-FileHashTable($JsonPath)
{
    return [FileHashTable]::new($JsonPath)
}

function Sign-IsAvailable(){
    return $null -ne $(Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert)
}
function Sign-File($FilePath, $TimestampServer = "http://time.certum.pl/")
{
    $cert=Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert
    Set-AuthenticodeSignature -FilePath $FilePath -Certificate $cert -TimestampServer $TimestampServer
}

function Sign-Folder($Folder, $Filters = @("*.exe", "*.dll", "*.pyd"), $TimestampServer = "http://time.certum.pl/")
{
    foreach($filter in $Filters){
        $files = Get-ChildItem -Path $Folder -Filter $filter -Recurse -ErrorAction SilentlyContinue -Force

        foreach ($file in $files) {
            Sign-File -FilePath $file.FullName -TimestampServer $TimestampServer
        }
    }
}


class FileHashTable
{
    [String] $JsonFile = ""
    [hashtable] $Hashes = @{}


    FileHashTable([string] $JsonPath)
    {
        $this.JsonFile = $JsonPath
        $this.LoadJson()
    }

    LoadJson()
    {
        if(Test-Path -Path $this.JsonFile )
        {
            $records  = $(Get-Content -Path $this.JsonFile | ConvertFrom-Json).psobject.properties
            foreach($record in $records)
            {
                $this.Hashes.Add($record.Name,$record.Value)
            }
        }
    }

    SaveJson()
    {
        $dirPath = Split-Path -Parent $this.JsonFile
        if($(Test-Path "${dirPath}") -eq $false)
        {
            New-Item -ItemType Directory "$dirPath"
        }
        ConvertTo-Json $this.Hashes | Set-Content -Path $this.JsonFile
    }

    [bool] FileNeedUpdate($RelativePath, $FileLocation)
    {
        if($this.Hashes.ContainsKey($RelativePath))
        {
            $oldfile_hash = $this.Hashes.Get_Item($RelativePath)
            $file_hash = $(Get-FileHash -Path $FileLocation -Algorithm SHA256).Hash

            if($oldfile_hash -eq $file_hash)
            {
                return $false
            }
        }

        return $true
    }

    UpdateFileHash($RelativePath, $FileLocation)
    {
        $value =  $(Get-FileHash -Path $FileLocation -Algorithm SHA256).Hash
        if($this.Hashes.ContainsKey($RelativePath))
        {
            $this.Hashes[$RelativePath]=$value
        }
        else
        {
            $this.Hashes.Add($RelativePath,$value)
        }
    }
}

#endregion
