//  @function				InterpretedVariableAddition
/// @argument				{string} variable_name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} addition_value
/// @description			Container for data of variable addition operation in an interpreted script.
///							Allows change of current value of a previously declared variable by the
///							specified constant value or the current value of another operation.
function InterpretedVariableAddition(_variable_name, _addition_value) constructor
{
	static constructor = InterpretedVariableAddition;
	
	variable_name = _variable_name;
	addition_value = _addition_value;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the details of this operation.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _addition_value_text = "";
		
		if (instanceof(addition_value) == "InterpretedFunctionCall")
		{
			_addition_value_text = (((is_real(addition_value.function_index))
									 ? script_get_name(addition_value.function_index)
									 : string(addition_value.function_index)) + "(");
			
			if (is_array(addition_value.function_argument))
			{
				var _i = 0;
				repeat (array_length(addition_value.function_argument))
				{
					_addition_value_text += (((_i > 0) ? ", " : "") +
											 string(addition_value.function_argument[_i]));
				
					++_i;
				}
			}
			else
			{
				_addition_value_text += string(addition_value.function_argument);
			}
			
			_addition_value_text += ")";
		}
		else
		{
			_addition_value_text = string(addition_value);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((is_string(variable_name)) ? variable_name : string(variable_name)) + " += " +
				_addition_value_text + _constructor_name_bracket_close);
	}
}
