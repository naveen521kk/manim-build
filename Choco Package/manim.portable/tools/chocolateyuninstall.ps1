﻿$ErrorActionPreference = 'Stop';
$osBitness = Get-ProcessorBits
if ( $osBitness -eq 32 -or $env:ChocolateyForceX86 -eq "true") {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x86.exe"
}
else {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x64.exe"
}
