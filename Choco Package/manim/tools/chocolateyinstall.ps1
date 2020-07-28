$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x86.exe'
$url64      = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  checksum      = '0314451a7a95ec772556756e50c9650f1f222bd5912daa1f027aabe4b308adb6'
  checksumType  = 'sha256'
  checksum64    = '91f347b3499f664d4ac9c435f8327c25846fa27072471f35bab5719383f135d8'
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
    $oridir=$pwd
    $pydir= "$toolsDir\python.3.8.3.x64\python.3.8.3\tools"
    $manimdir = "'$toolsDir\python.3.8.3.x64\manim\'"
    #$manimpip = Resolve-Path -LiteralPath $manimdir -Relative
    cd $pydir
    python -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
    #python -m pip install $manimdir
    cd $oridir
    #dir $ChocolateyInstall
    $files = get-childitem $installDir -include *.exe -recurse
    foreach ($file in $files) {
      if (!($file -eq "manim.exe" -or $file -eq "manimcm.exe")){
        New-Item "$file.ignore" -type file -force | Out-Null
      }
    }
}
