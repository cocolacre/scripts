//https://www.youtube.com/watch?v=dY6jR52fFWo
using System.CodeDom.Compiler;
using Microsoft.CSharp;

public class CompilerTest {
	public object RunCode (string userCode) {
	CSharpCodeProvider provider = new CSharpCodeProvider ();
	CompilerResults results = provider.CompileAssemblyFromSource (new CompileParameters (), userCode);
	System.Type classType = results.CompiledAssembly.GetType("MyClass");
	System.Reflection.MethodInfo method = classType.GetMethod("MyMethod");
	
	return method.Invoke (null, null);
	}
}
