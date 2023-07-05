//  @function				interpret_variable_substraction()
/// @argument				{StringParser} line
/// @returns				{InterpretedVariableSubstraction}
/// @description			Interpret the specified line and return data for a variable substraction.
function interpret_variable_substraction(_line)
{
	static _stringParser = new StringParser();
	
	var _name = undefined;
	var _value = undefined;
	
	if (_line.contains("-="))
	{
		var _part = _line.split("-=", false, true);
		_name = _stringParser.setParser(_part[0]).trim().ID;
		_value = ((_stringParser.setParser(_part[1]).replace(";").trim().containsAll("(", ")"))
				  ? interpret_function_call(_stringParser)
				  : interpret_value_string(_stringParser.ID));
	}
	else if (_line.contains("--"))
	{
		_name = _stringParser.setParser(_line).replace("--").replace(";").ID;
		_value = 1;
	}
	
	return new InterpretedVariableSubstraction(_name, _value);
}
