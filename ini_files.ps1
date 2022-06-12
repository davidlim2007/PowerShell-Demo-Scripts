## References :
## https://karatos.com/art?id=d0b72fb9-16fd-49ec-8c4b-614a8c036bb7
## https://gist.github.com/mklement0/006c2352ddae7bb05693be028240f5b6
## 
## Good reference : Add-Type [https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-7.2]
##
## On how to run a PowerShell Script File from the Command Line, refer to : https://ss64.com/nt/syntax-run.html
## The following is take from the site :
<#

Run a PowerShell script

    To run a PowerShell script from the CMD shell:

    C:\> powershell -file "c:\batch\demo.ps1"

    With arguments:

    C:\> powershell -file "c:\batch\demo.ps1" filename1.txt Testing

    If the arguments need quotes you will need to triple them so they are escaped:

    C:\> powershell -file "c:\batch\demo.ps1" """\Path To\filename1.txt""" """A Test string"""

    When calling PowerShell from CMD be aware that a comma is a CMD delimiter, this makes it impossible to pass an array of comma separated values to PowerShell. item1,item2,item3 is treated the same as item1 item2 item3

#>
##
## On declaring PowerShell Script Variables, see :
## about_Variables [https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.2]
##

# Create helper type [WinApiHelper.IniFile], which wraps P/Invoke calls to the Get/WritePrivateProfileString()
# Windows API functions.
$CSharpSourceCodes = @"

using System.Text;
using System.Runtime.InteropServices;

public class IniFileHelper
{
        [DllImport("Kernel32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true)]
        public extern static uint GetPrivateProfileString
        (
            string strAppName,
            string strKeyName,
            string strDefault,
            StringBuilder strReturnedString,
            uint size,
            string IniFileName
        );

        [DllImport("Kernel32.dll", CallingConvention = CallingConvention.StdCall, SetLastError = true, CharSet = CharSet.Ansi)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool WritePrivateProfileString
            (
              [In] [MarshalAs(UnmanagedType.LPStr)] string lpAppName,
              [In] [MarshalAs(UnmanagedType.LPStr)] string lpKeyName,
              [In] [MarshalAs(UnmanagedType.LPStr)] string lpString,
              [In] [MarshalAs(UnmanagedType.LPStr)] string lpFileName
            );
}

"@ 

Add-Type -TypeDefinition $CSharpSourceCodes

#Define configuration
$section = "server"
$filePath = ".\test.ini"
$key = "ip"
$val = "192.168.0.100"
$retVal = New-Object System.Text.StringBuilder (32)

#Generate or modify configuration files
## The $null will re-direct the output of the call to [IniFileHelper]::WritePrivateProfileString
## to a null (i.e. to throw it away).
##
## See : How do I avoid getting data printed to stdout in my return value?
## https://stackoverflow.com/questions/4660966/how-do-i-avoid-getting-data-printed-to-stdout-in-my-return-value
##
$null=[IniFileHelper]::WritePrivateProfileString($section, $key, $val, $filePath)

#View configuration file
$null=[IniFileHelper]::GetPrivateProfileString($section, $key, "", $retVal, 32, $filePath)
Write-Host $key "=" $retVal.tostring()
