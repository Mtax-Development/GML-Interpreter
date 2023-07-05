//  @function				interpret_variable_assignment()
/// @argument				{StringParser} line
/// @returns				{InterpretedVariableAssignment} | On error: {InterpretedError}
/// @description			Interpret the specified line and return data for a variable assignment.
function interpret_variable_assignment(_line)
{
	static _stringParser = new StringParser();
	
	var _variable_is_local = false;
	var _part = _line.split("=", false, true);
	var _name = "";
	
	_stringParser.setParser(_part[0]).trim();
	
	if (_stringParser.startsWith("var "))
	{
		_name = _stringParser.replace("var ").ID;
		_variable_is_local = true;
	}
	
	var _name = _stringParser.ID;
	var _value = _stringParser.setParser(_part[1]).replace(";").trim().ID;
	
	if (_name != "var")
	{
		return new InterpretedVariableAssignment(_name, ((_stringParser.containsAll("(", ")"))
														 ? interpret_function_call(_stringParser)
														 : interpret_value_string(_value)),
												 _variable_is_local);
	}
	else
	{
		return new InterpretedError("Malformed assignment", _line.ID);
	}
}
