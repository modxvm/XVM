#!/usr/bin/env pwsh

param(
    [string] $ComponentId,
    [string] $Type,
    [string] $Mode,
    [string] $Option,
    [string[]] $Flavours = @('Lesta', 'WG'),
    [switch] $Clean
)

$ErrorActionPreference = 'Stop'
Import-Module "$PSScriptRoot/src_build/library.psm1" -Force -DisableNameChecking

Build-ConfiguredProject -ProjectDirectory $PSScriptRoot -ComponentId $ComponentId -Type $Type `
    -Mode $Mode -Option $Option -Flavours $Flavours -Clean:$Clean
