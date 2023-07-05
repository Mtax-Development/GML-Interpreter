//  @function				InterpretedVariableMultiplication
/// @argument				{string} variable_name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} multiplication_value
/// @description			Container for data of variable multiplication operation in an interpreted
///							script. Allows change of current value of a previously declared variable
///							by the specified constant value or the current value of another operation.
function InterpretedVariableMultiplication(_variable_name, _multiplication_value) constructor
{
	static constructor = InterpretedVariableMultiplication;
	
	variable_name = _variable_name;
	multiplication_value = _multiplication_value;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the details of this operation.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _multiplication_value_text = "";
		
		if (instanceof(multiplication_value) == "InterpretedFunctionCall")
		{
			_multiplication_value_text = (((is_real(multiplication_value.function_index))
									 ? script_get_name(multiplication_value.function_index)
									 : string(multiplication_value.function_index)) + "(");
			
			if (is_array(multiplication_value.function_argument))
			{
				var _i = 0;
				repeat (array_length(multiplication_value.function_argument))
				{
					_multiplication_value_text += (((_i > 0) ? ", " : "") +
											 string(multiplication_value.function_argument[_i]));
				
					++_i;
				}
			}
			else
			{
				_multiplication_value_text += string(multiplication_value.function_argument);
			}
			
			_multiplication_value_text += ")";
		}
		else
		{
			_multiplication_value_text = string(multiplication_value);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((is_string(variable_name)) ? variable_name : string(variable_name)) + " += " +
				_multiplication_value_text + _constructor_name_bracket_close);
	}
}
