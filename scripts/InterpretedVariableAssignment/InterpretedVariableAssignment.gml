//  @function				InterpretedVariableAssignment
/// @argument				{string} variable_name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} variable_value
/// @argument				{bool} variable_is_local
/// @description			Container for data of variable assignment operation in an interpreted
///							script. Allows assignment of the current value of the specified constant
///							value or the current value of another operation. The declaration of that
///							variable can be specified to a subsidiary local scope. In that case, the 
///							variable is saved only for the duration the interpreted script execution.
function InterpretedVariableAssignment(_variable_name, _variable_value, _variable_is_local) constructor
{
	static constructor = InterpretedVariableAssignment;
	
	variable_name = _variable_name;
	variable_value = _variable_value;
	variable_is_local = _variable_is_local;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the details of the variable assignment.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _variable_value_text = "";
		
		if (instanceof(variable_value) == "InterpretedFunctionCall")
		{
			_variable_value_text = (((is_real(variable_value.function_index))
									 ? script_get_name(variable_value.function_index)
									 : string(variable_value.function_index)) + "(");
			
			if (is_array(variable_value.function_argument))
			{
				var _i = 0;
				repeat (array_length(variable_value.function_argument))
				{
					_variable_value_text += (((_i > 0) ? ", " : "") +
											 string(variable_value.function_argument[_i]));
				
					++_i;
				}
			}
			else
			{
				_variable_value_text += string(variable_value.function_argument);
			}
			
			_variable_value_text += ")";
		}
		else
		{
			_variable_value_text = string(variable_value);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((variable_is_local) ? "var " : "") +
				((is_string(variable_name)) ? variable_name : string(variable_name)) + " = " +
				_variable_value_text + _constructor_name_bracket_close);
	}
}
