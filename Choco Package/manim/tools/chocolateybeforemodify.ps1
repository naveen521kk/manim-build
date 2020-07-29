
$osBitness = Get-ProcessorBits
$pydirx86= "$env:ChocolateyPackageFolder\tools\python.3.8.3.x86\pythonx86.3.8.3\tools"
$pydirx64= "$env:ChocolateyPackageFolder\tools\python.3.8.3.x64\python.3.8.3\tools"
Try { 
Set-Location $pydirx86
./python.exe -m pip install -q --upgrade pip
./python.exe -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
Write-Output "Manim Updated to Master Branch"
}
Catch { 
Set-Location $pydirx64
./python.exe -m pip install -q --upgrade pip
./python.exe -m pip install -q https://github.com/ManimCommunity/manim/archive/master.zip
Write-Output "Manim Updated to Master Branch"}
         

