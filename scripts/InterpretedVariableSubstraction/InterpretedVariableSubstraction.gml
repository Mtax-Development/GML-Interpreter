//  @function				InterpretedVariableSubstraction
/// @argument				{string} variable_name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} substraction_value
/// @description			Container for data of variable substraction operation in an interpreted
///							script. Allows change of current value of a previously declared variable
///							by the specified constant value or the current value of another operation.
function InterpretedVariableSubstraction(_variable_name, _substraction_value) constructor
{
	static constructor = InterpretedVariableSubstraction;
	
	variable_name = _variable_name;
	substraction_value = _substraction_value;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the details of this operation.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _substraction_value_text = "";
		
		if (instanceof(substraction_value) == "InterpretedFunctionCall")
		{
			_substraction_value_text = (((is_real(substraction_value.function_index))
									 ? script_get_name(substraction_value.function_index)
									 : string(substraction_value.function_index)) + "(");
			
			if (is_array(substraction_value.function_argument))
			{
				var _i = 0;
				repeat (array_length(substraction_value.function_argument))
				{
					_substraction_value_text += (((_i > 0) ? ", " : "") +
											 string(substraction_value.function_argument[_i]));
				
					++_i;
				}
			}
			else
			{
				_substraction_value_text += string(substraction_value.function_argument);
			}
			
			_substraction_value_text += ")";
		}
		else
		{
			_substraction_value_text = string(substraction_value);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((is_string(variable_name)) ? variable_name : string(variable_name)) + " += " +
				_substraction_value_text + _constructor_name_bracket_close);
	}
}
