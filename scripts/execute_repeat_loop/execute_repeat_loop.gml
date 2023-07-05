//  @function				execute_repeat_loop()
/// @argument				{struct} scope
/// @argument				{constructor[]} expression
/// @argument				{constructor[]} statement
/// @description			Execute the "repeat" loop of an interpreted script. The content of the
///							statement is executed in the specified scope, only after the current
///							value of the expression allows for at least one iteration.
function execute_repeat_loop(_scope, _expression, _statement)
{
	var _iterations = get_interpreted_value(_expression);
	
	repeat (_iterations)
	{
		execute_call_lines(_scope, _statement);
	}
}
