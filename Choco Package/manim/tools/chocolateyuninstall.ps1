$ErrorActionPreference = 'Stop';
$osBitness = Get-ProcessorBits
if ( $osBitness -eq 64 ) {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x64.exe"
}
else {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x86.exe"
}
