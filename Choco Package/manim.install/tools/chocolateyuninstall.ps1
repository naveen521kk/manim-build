$ErrorActionPreference = 'Stop';
$InstallLocation = Get-ToolsLocation
. $toolsPath\helpers.ps1
Uninstall-ChocolateyPath "$InstallLocation\pango"
python -m pip uninstall -y -q manimce

