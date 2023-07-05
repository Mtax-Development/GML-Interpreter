//  @function				interpret_variable_addition()
/// @argument				{StringParser} line
/// @returns				{InterpretedVariableAddition}
/// @description			Interpret the specified line and return data for a variable addition.
function interpret_variable_addition(_line)
{
	static _stringParser = new StringParser();
	
	var _name = undefined;
	var _value = undefined;
	
	if (_line.contains("+="))
	{
		var _part = _line.split("+=", false, true);
		_name = _stringParser.setParser(_part[0]).trim().ID;
		_value = ((_stringParser.setParser(_part[1]).replace(";").trim().containsAll("(", ")"))
				  ? interpret_function_call(_stringParser)
				  : interpret_value_string(_stringParser.ID));
	}
	else if (_line.contains("++"))
	{
		_name = _stringParser.setParser(_line).replace("++").replace(";").ID;
		_value = 1;
	}
	
	return new InterpretedVariableAddition(_name, _value);
}
