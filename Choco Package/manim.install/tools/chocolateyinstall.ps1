$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$manimExtractDir="$toolsDir\manim"
python -m pip install -i https://test.pypi.org/simple/ -q pycairo

Get-ChocolateyWebFile `
  -PackageName "manim" `
  -FileFullPath "$toolsDir\manim.zip" `
  -Url "https://github.com/ManimCommunity/manim/archive/master.zip"

Get-ChocolateyUnzip `
  -FileFullPath $toolsDir\manim.zip `
  -Destination  $manimExtractDir`
  
python -m pip install -q $manimExtractDir
