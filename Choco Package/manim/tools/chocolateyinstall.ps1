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
echo $env:ChocolateyForceX86
if ( $osBitness -eq 32 -or $env:ChocolateyForceX86 -eq "true") {
    echo "32-bit"
    $pydir= "$toolsDir\python.3.8.3.x86\pythonx86.3.8.3\tools"
    Set-Location $pydir
    ./python.exe -m pip install -q --upgrade pip
    ./python.exe -m pip install -q "$toolsDir\python.3.8.3.x86\manim"
    ./python.exe -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
    $files = get-childitem $installDir -include *.exe -recurse

    foreach ($file in $files) {
      if (!($file.Name.Contains("manim.exe")) -and !($file.Name.Contains("manimcm.exe")) -and !($file.Name.Contains("python.exe"))) {
        #generate an ignore file
        New-Item "$file.ignore" -type file -force | Out-Null
      }
    }
}
else {
    echo "64-bit"
    $pydir= "$toolsDir\python.3.8.3.x64\python.3.8.3\tools"
    Set-Location $pydir
    ./python.exe -m pip install -q --upgrade pip
    ./python.exe -m pip install -q "$toolsDir\python.3.8.3.x64\manim"
    ./python.exe -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
    $files = get-childitem $installDir -include *.exe -recurse

    foreach ($file in $files) {
      if (!($file.Name.Contains("manim.exe")) -and !($file.Name.Contains("manimcm.exe")) -and !($file.Name.Contains("python.exe"))) {
        #generate an ignore file
        New-Item "$file.ignore" -type file -force | Out-Null
      }
    }
}
