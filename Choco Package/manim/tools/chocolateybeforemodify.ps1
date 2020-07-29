
$osBitness = Get-ProcessorBits
if ( $osBitness -eq 32 -or $env:ChocolateyForceX86 -eq "true") {
  $pydir= "$env:ChocolateyPackageFolder\tools\python.3.8.3.x86\pythonx86.3.8.3\tools"
} else {
  $pydir= "$env:ChocolateyPackageFolder\tools\python.3.8.3.x64\python.3.8.3\tools"
}
Set-Location $pydir
./python.exe -m pip install -q --upgrade pip
./python.exe -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
Write-Output "Manim Updated to Master Branch"
