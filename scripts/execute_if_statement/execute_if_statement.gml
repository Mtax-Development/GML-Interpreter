//  @function				execute_if_statement()
/// @argument				{struct} scope
/// @argument				{constructor[]} expression
/// @argument				{constructor[]} statement
/// @description			Execute the "if" statement of an interpreted script. The content of the
///							statement is executed in the specified scope, only after the current
///							values of the expressions match their required result.
function execute_if_statement(_scope, _expression, _statement)
{
	var _expression_executes = true;
	var _i = 0;
	repeat (array_length(_expression))
	{
		switch (_expression[_i].constructor)
		{
			case InterpretedIfExpression_Comparison:
				_expression_executes = (get_interpreted_value(_expression[_i].left) ==
										get_interpreted_value(_expression[_i].right));
			break;
			case InterpretedIfExpression_Boolean:
				_expression_executes = (get_interpreted_value(_expression[_i].value) ? true : false);
			break;
		}
		
		if (!_expression_executes)
		{
			return;
		}
		
		++_i;
	}
	
	execute_call_lines(_scope, _statement);
}
