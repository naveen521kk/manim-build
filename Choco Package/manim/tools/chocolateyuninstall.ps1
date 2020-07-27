# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f='c:\path\to\thisFile.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f


$ErrorActionPreference = 'Stop';
$osBitness = Get-ProcessorBits
if ( $osBitness -eq 64 ) {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x64.exe"
}
else {
  Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "build.3.8.3.x86.exe"
}
Uninstall-ChocolateyEnvironmentVariable # 0.9.10+ - https://chocolatey.org/docs/helpers-uninstall-chocolatey-environment-variable 
