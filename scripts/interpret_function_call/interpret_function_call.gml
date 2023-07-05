//  @function				interpret_function_call()
/// @argument				{StringParser} line
/// @returns				{InterpretedFunctionCall}
/// @description			Interpret the specified line and return data for a function call.
function interpret_function_call(_line)
{
	static _stringParser = new StringParser();
	
	var _function = get_function(_line.split("(")[0]);
	var _argument = [];
	var _argument_string = array(_stringParser.setParser(_line.getBetween("(", ")")).split(","));
	var _i = 0;
	repeat (array_length(_argument_string))
	{
		array_push(_argument, interpret_value_string(_argument_string[_i]));
		
		++_i;
	}
		
	return new InterpretedFunctionCall(_function, _argument);
}
