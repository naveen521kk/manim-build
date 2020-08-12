$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$manimExtractDir=Join-Path $toolsDir "manim"
python -m pip install -i https://test.pypi.org/simple/ -q pycairo

Get-ChocolateyWebFile `
  -PackageName "manim" `
  -FileFullPath "$toolsDir\manim.zip" `
  -Url "https://github.com/ManimCommunity/manim/archive/master.zip"
  
python -m pip install -q $manimExtractDir
