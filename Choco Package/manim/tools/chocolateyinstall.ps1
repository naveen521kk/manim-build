$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/naveen521kk/manim-build/releases/download/v0.1.0/windows.choco.build.py3.8.3.x86.exe'
$url64      = 'https://github.com/naveen521kk/manim-build/releases/download/v0.1.0/windows.choco.build.py3.8.3.x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  url64bit      = $url64
  checksum      = 'ce842e633b6104237badc3a5c295bf9943f96c1307ea8831ae2b65e4382e1a14'
  checksumType  = 'sha256'
  checksum64    = '8ee4e29916e305a10f80dbbc12b70d02866b2b7e6d67a3bb3b1709c983a0eeae'
  checksumType64= 'sha256'
}
$osBitness = Get-ProcessorBits
Install-ChocolateyZipPackage @packageArgs
if ( $osBitness -eq 32 -or $env:ChocolateyForceX86 -eq "true") {
    $pydir= "$toolsDir\python.3.8.3.x86\pythonx86.3.8.3\tools"
    Set-Location $pydir
    ./python.exe -m pip install -q --no-warn-script-location --upgrade pip
    ./python.exe -m pip install -q --no-warn-script-location "$toolsDir\python.3.8.3.x86\manim"
    ./python.exe -m pip install -q --no-warn-script-location https://github.com/ManimCommunity/manim/archive/master.zip
    $files = get-childitem $installDir -include *.exe -recurse

    foreach ($file in $files) {
      if (!($file.Name.Contains("manim.exe")) -and !($file.Name.Contains("manimcm.exe")) -and !($file.Name.Contains("python.exe"))) {
        #generate an ignore file
        New-Item "$file.ignore" -type file -force | Out-Null
      }
    }
}
else {
    $pydir= "$toolsDir\python.3.8.3.x64\python.3.8.3\tools"
    Set-Location $pydir
    ./python.exe -m pip install -q --no-warn-script-location --upgrade pip
    ./python.exe -m pip install -q --no-warn-script-location "$toolsDir\python.3.8.3.x64\manim"
    ./python.exe -m pip install -q --no-warn-script-location https://github.com/ManimCommunity/manim/archive/master.zip
    $files = get-childitem $installDir -include *.exe -recurse

    foreach ($file in $files) {
      if (!($file.Name.Contains("manim.exe")) -and !($file.Name.Contains("manimcm.exe")) -and !($file.Name.Contains("python.exe"))) {
        #generate an ignore file
        New-Item "$file.ignore" -type file -force | Out-Null
      }
    }
}