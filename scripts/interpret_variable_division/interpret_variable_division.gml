//  @function				interpret_variable_division()
/// @argument				{StringParser} line
/// @returns				{InterpretedVariableDivision}
/// @description			Interpret the specified line and return data for a variable division.
function interpret_variable_division(_line)
{
	static _stringParser = new StringParser();
	
	var _name = undefined;
	var _value = undefined;
	
	var _part = _line.split("/=", false, true);
	_name = _stringParser.setParser(_part[0]).trim().ID;
	_value = ((_stringParser.setParser(_part[1]).replace(";").trim().containsAll("(", ")"))
			  ? interpret_function_call(_stringParser) : interpret_value_string(_stringParser.ID));
	
	return new InterpretedVariableDivision(_name, _value);
}
