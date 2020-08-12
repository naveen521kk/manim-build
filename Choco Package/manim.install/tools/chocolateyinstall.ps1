$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$manimExtractDir="$toolsDir\Manim"
python -m pip install -i https://test.pypi.org/simple/ -q pycairo

Get-ChocolateyWebFile `
  -PackageName "Manim" `
  -FileFullPath $toolsDir `
  -Url "https://github.com/ManimCommunity/manim/archive/master.zip"

Get-ChocolateyUnzip `
  -FileFullPath $toolsDir\manim.zip `
  -Destination  $manimExtractDir`
  
python -m pip install -q $manimExtractDir
