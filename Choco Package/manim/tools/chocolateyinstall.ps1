
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/naveen521kk/manim-build/releases/download/v0.1.0/Manim_1.0x86.exe'
$url64      = 'https://github.com/naveen521kk/manim-build/releases/download/v0.1.0/Manim_1.0x64.exe'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'manim*'

  checksum      = '91F347B3499F664D4AC9C435F8327C25846FA27072471F35BAB5719383F135D8'
  checksumType  = 'sha256'
  checksum64    = '0314451A7A95EC772556756E50C9650F1F222BD5912DAA1F027AABE4B308ADB6'
  checksumType64= 'sha256'
  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}
$osBitness = Get-ProcessorBits
Install-ChocolateyPackage @packageArgs
#if ( $osBitness -eq 32 ) {
 #   Install-ChocolateyPath $toolsDir'\pythonx86.3.8.3\tools\Scripts' 'Machine'
#}
#else {
 #   Install-ChocolateyPath $toolsDir'\python.3.8.3\tools\Scripts' 'Machine'
#}










