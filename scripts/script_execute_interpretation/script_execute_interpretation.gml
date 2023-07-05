//  @function				script_execute_interpretation()
/// @argument				{struct} scope
/// @argument				{constructor[]} call
/// @description			Execute interpreted GameMaker Language script contained in the specified
///							call array. The call execution is performed through the specified struct,
///							acting as the scope of the script. If any call is invalid, the execution
///							is stopped and the error is reported.
function script_execute_interpretation(_scope, _call)
{
	try
	{
		variable_struct_set(_scope, "var", {});
		execute_call_lines(_scope, _call);
		variable_struct_remove(_scope, "var");
	}
	catch (_exception)
	{
		new ErrorReport().report([self, "script_execute_interpretation()"], _exception.message);
		
		if (is_struct(_scope))
		{
			variable_struct_remove(_scope, "var");
		}
	}
}
