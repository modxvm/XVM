if ($env:XVMBUILD_FLAVOUR -eq "wg") {
    $env:XVMBUILD_VERSION_CLIENT = "1.22.1.0"
} elseif ($env:XVMBUILD_FLAVOUR -eq "lesta") {
    $env:XVMBUILD_VERSION_CLIENT = "1.22.1.0"
} else{
    Write-Output "unknown flavour"
    exit 1
}

$env:XVMBUILD_VERSION_MOD = "10.8.0"
