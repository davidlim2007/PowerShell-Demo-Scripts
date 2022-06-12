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
    [string]$path,

    [Parameter(Mandatory=$true)]
    [string]$file_search_pattern,

    [Parameter(Mandatory=$true)]
    [string]$search_text,

    [string]$case_sensitive = "NO"
)

Write-Host "path =" $path
Write-Host "file_search_pattern =" $file_search_pattern
Write-Host "search_text =" $search_text

## For more info on Get-ChildItem, see :
## https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2
##
$file_search_pattern = $path + "\" + $file_search_pattern
if ($case_sensitive -eq "YES")
{
    Get-ChildItem -Path $file_search_pattern -Recurse | Select-String -Pattern $search_text -CaseSensitive
}
else
{
    Get-ChildItem -Path $file_search_pattern -Recurse | Select-String -Pattern $search_text
}


