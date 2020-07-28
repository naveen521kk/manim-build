$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x86.exe'
$url64      = 'https://github.com/naveen521kk/manim-build/releases/download/0.0.0.1/build.3.8.3.x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  checksum      = '0314451A7A95EC772556756E50C9650F1F222BD5912DAA1F027AABE4B308ADB6'
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
    dir
    ./python.exe -m pip install --upgrade pip
    ./python.exe -m pip install "$toolsDir\python.3.8.3.x64\manim"
    #python -m pip install $manimdir
    #cd $oridir
    #dir $ChocolateyInstall
    #$files = get-childitem $toolsDir -include *.exe -recurse
    #foreach ($file in $files) {
    #  if (!($file -eq "manim.exe" -or $file -eq "manimcm.exe")){
    #   New-Item "$file.ignore" -type file -force | Out-Null
    #  }else{
    #    echo "No"
    #  }
    #}
}
