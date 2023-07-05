//  @function				InterpretedVariable
/// @argument				{string} name
/// @description			Container for a variable name of an interpreted script. Allows access to
///							the current value of given variable in its scope during script execution.
function InterpretedVariable(_name) constructor
{
	static constructor = InterpretedVariable;
	
	name = _name;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the name of the variable.
	static toString = function()
	{
		return (instanceof(self) + "(" + name + ")");
	}
}
