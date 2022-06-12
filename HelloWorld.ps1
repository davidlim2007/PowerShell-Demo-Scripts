$code = @"
using System;
namespace HelloWorld
{
	public class Program
	{
		public static void Main()
        {
			Console.WriteLine("Hello world!");
		}
	}
}
"@
 
Add-Type -TypeDefinition $code -Language CSharp
[HelloWorld.Program]::Main()