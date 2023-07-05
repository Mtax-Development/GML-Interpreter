//  @function				execute_call_lines()
/// @argument				{struct} scope
/// @argument				{constructor[]} call
/// @description			Execute the specified interpreted calls in order as the specified struct.
function execute_call_lines(_scope, _call)
{
	with (_scope)
	{
		var _i = 0;
		repeat (array_length(_call))
		{
			switch (_call[_i].constructor)
			{
				case InterpretedVariableAssignment:
					execute_variable_assignment(_call[_i].variable_name, _call[_i].variable_value,
												_call[_i].variable_is_local);
				break;
				case InterpretedVariableAddition:
					execute_variable_addition(_call[_i].variable_name, _call[_i].addition_value);
				break;
				case InterpretedVariableSubstraction:
					execute_variable_substraction(_call[_i].variable_name,
												  _call[_i].substraction_value);
				break;
				case InterpretedVariableMultiplication:
					execute_variable_multiplication(_call[_i].variable_name,
													_call[_i].multiplication_value);
				break;
				case InterpretedVariableDivision:
					execute_variable_division(_call[_i].variable_name, _call[_i].division_value);
				break;
				case InterpretedFunctionCall:
					execute_function_call(_call[_i].function_index, _call[_i].function_argument);
				break;
				case InterpretedIfStatement:
					execute_if_statement(_scope, _call[_i].expression_interpreted,
										 _call[_i].statement_interpreted);
				break;
				case InterpretedRepeatLoop:
					execute_repeat_loop(_scope, _call[_i].expression_interpreted,
										_call[_i].statement_interpreted);
				break;
			}
			
			++_i;
		}
	}
}
