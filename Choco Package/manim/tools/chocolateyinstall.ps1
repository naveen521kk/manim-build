$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x86.exe'
$url64      = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  checksum      = '91F347B3499F664D4AC9C435F8327C25846FA27072471F35BAB5719383F135D8'
  checksumType  = 'sha256'
  checksum64    = '0314451A7A95EC772556756E50C9650F1F222BD5912DAA1F027AABE4B308ADB6'
  checksumType64= 'sha256'
}
$osBitness = Get-ProcessorBits
Install-ChocolateyZipPackage @packageArgs

if ( $osBitness -eq 32 ) {
    Install-ChocolateyPath $toolsDir'\pythonx86.3.8.3\tools\Scripts' 'Machine'
    dir $toolsDir
    dir $ChocolateyInstall
}
else {
    Install-ChocolateyPath $toolsDir'\python.3.8.3\tools\Scripts' 'Machine'
    dir $toolsDir
    tree $toolsDir
    $oridir=$pwd
    $pydir= $toolsDir+'\python.3.8.3.x64\python.3.8.3\tools'
    $manimdir = $toolsDir+'\manim'
    cd $pydir
    python -m pip install $manimdir
    cd $oridir
    dir $ChocolateyInstall
}
