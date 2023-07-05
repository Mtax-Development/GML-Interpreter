//  @function				InterpretedVariablDivision
/// @argument				{string} variable_name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} division_value
/// @description			Container for data of variable division operation in an interpreted script.
///							Allows change of current value of a previously declared variable by the
///							specified constant value or the current value of another operation.
function InterpretedVariableDivision(_variable_name, _division_value) constructor
{
	static constructor = InterpretedVariableDivision;
	
	variable_name = _variable_name;
	division_value = _division_value;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the details of this operation.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _division_value_text = "";
		
		if (instanceof(division_value) == "InterpretedFunctionCall")
		{
			_division_value_text = (((is_real(division_value.function_index))
									 ? script_get_name(division_value.function_index)
									 : string(division_value.function_index)) + "(");
			
			if (is_array(division_value.function_argument))
			{
				var _i = 0;
				repeat (array_length(division_value.function_argument))
				{
					_division_value_text += (((_i > 0) ? ", " : "") +
											 string(division_value.function_argument[_i]));
				
					++_i;
				}
			}
			else
			{
				_division_value_text += string(division_value.function_argument);
			}
			
			_division_value_text += ")";
		}
		else
		{
			_division_value_text = string(division_value);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((is_string(variable_name)) ? variable_name : string(variable_name)) + " += " +
				_division_value_text + _constructor_name_bracket_close);
	}
}
