##
## On command line parameters, see :
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



