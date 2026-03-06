param(
    [string]$Root = ".",
    [string]$OutputRoot = ".\_pkg_extract"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$targetSwfNames = @(
    "battle.swf",
    "battleVehicleMarkersApp.swf",
    "frontline_battle.swf",
    "lobby.swf"
)

$targetSwfSet = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($name in $targetSwfNames) {
    [void]$targetSwfSet.Add($name)
}

$swcOutDir = Join-Path $OutputRoot "swc"
$swfOutDir = Join-Path $OutputRoot "swf"

New-Item -ItemType Directory -Force -Path $swcOutDir | Out-Null
New-Item -ItemType Directory -Force -Path $swfOutDir | Out-Null

function Get-SafeFileName {
    param([Parameter(Mandatory = $true)][string]$Name)

    $invalid = [System.IO.Path]::GetInvalidFileNameChars()
    $safe = $Name
    foreach ($ch in $invalid) {
        $safe = $safe.Replace($ch, '_')
    }
    return $safe
}

function Get-UniqueOutputPath {
    param(
        [Parameter(Mandatory = $true)][string]$Directory,
        [Parameter(Mandatory = $true)][string]$FileName,
        [Parameter(Mandatory = $true)][string]$PkgBaseName
    )

    $safeName = Get-SafeFileName $FileName
    $candidate = Join-Path $Directory $safeName
    if (-not (Test-Path -LiteralPath $candidate)) {
        return $candidate
    }

    $base = [System.IO.Path]::GetFileNameWithoutExtension($safeName)
    $ext  = [System.IO.Path]::GetExtension($safeName)
    $pkgSafe = Get-SafeFileName $PkgBaseName

    $candidate = Join-Path $Directory ("{0}__{1}{2}" -f $pkgSafe, $base, $ext)
    if (-not (Test-Path -LiteralPath $candidate)) {
        return $candidate
    }

    $i = 1
    while ($true) {
        $candidate = Join-Path $Directory ("{0}__{1}__{2}{3}" -f $pkgSafe, $base, $i, $ext)
        if (-not (Test-Path -LiteralPath $candidate)) {
            return $candidate
        }
        $i++
    }
}

function Extract-SelectedEntriesFromPkg {
    param(
        [Parameter(Mandatory = $true)][string]$PkgPath
    )

    $zip = $null
    $pkgBaseName = [System.IO.Path]::GetFileNameWithoutExtension($PkgPath)

    Write-Host "Processing: $PkgPath"

    try {
        $zip = [System.IO.Compression.ZipFile]::OpenRead($PkgPath)

        foreach ($entry in $zip.Entries) {
            if ([string]::IsNullOrWhiteSpace($entry.Name)) {
                continue
            }

            $entryName = $entry.Name
            $outDir = $null

            if ($entryName.EndsWith(".swc", [System.StringComparison]::OrdinalIgnoreCase)) {
                $outDir = $swcOutDir
            }
            elseif ($targetSwfSet.Contains($entryName)) {
                $outDir = $swfOutDir
            }
            else {
                continue
            }

            $destinationPath = Get-UniqueOutputPath -Directory $outDir -FileName $entryName -PkgBaseName $pkgBaseName
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $destinationPath, $false)

            Write-Host ("  Extracted: {0} -> {1}" -f $entry.FullName, $destinationPath)
        }
    }
    catch {
        Write-Warning "Failed to process '$PkgPath': $($_.Exception.Message)"
    }
    finally {
        if ($null -ne $zip) {
            $zip.Dispose()
        }
    }
}

$pkgFiles = @()
$pkgFiles += Get-ChildItem -Path $Root -Recurse -File -Filter "gui*.pkg"
$pkgFiles += Get-ChildItem -Path $Root -Recurse -File -Filter "frontline*.pkg"
$pkgFiles = $pkgFiles | Sort-Object FullName -Unique

if (-not $pkgFiles -or $pkgFiles.Count -eq 0) {
    Write-Host "No matching .pkg files found."
    exit 0
}

foreach ($pkg in $pkgFiles) {
    Extract-SelectedEntriesFromPkg -PkgPath $pkg.FullName
}

Write-Host ""
Write-Host "Done."
Write-Host "SWC: $([System.IO.Path]::GetFullPath($swcOutDir))"
Write-Host "SWF: $([System.IO.Path]::GetFullPath($swfOutDir))"