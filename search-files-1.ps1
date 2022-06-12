##
## On command line paramerters, see :
## How to handle command-line arguments in PowerShell
## https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
##
param 
(
    [Parameter(Mandatory=$true)]
    [ValidateScript(
	{ 
		Test-Path -Path $_ 
	})]
    [string]$path
)

Write-Host "The Path =" $path

## For more info on Get-ChildItem, see :
## https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2
##
$search_pattern = $path + "\*.ini" 
Get-ChildItem -Path $search_pattern -Recurse | Select-String -Pattern 'PORT'

