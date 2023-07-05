//  @function				interpret_value_string()
/// @argument				{string} string
/// @returns				{real|string|bool|InterpretedVariable}
/// @description			Interpret the specified string and return either its constant value or
///							a constructor containing name of the variable, the current value of which
///							can be read or modified during execution.
function interpret_value_string(_string)
{
	static _stringParser = new StringParser();
	
	var _value = _stringParser.setParser(_string).trim().ID;
	var _value_length = string_length(_value);
	
	if (string_digits(_value) == _value)
	{
		return real(_value);
	}
	else if ((_value_length >= 3) and (string_char_at(_value, 1) == "\"")
	and (string_char_at(_value, _value_length) == "\""))
	{
		return string_copy(_value, 2, (_value_length - 2));
	}
	else
	{
		switch (_value)
		{
			case "true": return true; break;
			case "false": return false; break;
			default: return new InterpretedVariable(_value); break;
		}
	}
}
