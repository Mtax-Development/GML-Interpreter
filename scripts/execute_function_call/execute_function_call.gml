//  @function				execute_Function_call()
/// @argument				{int:function} function
/// @argument				{any[]} argument
/// @description			Execute a function with the specified index in the current scope and
///							provide the current value of the specified arguments to it.
function execute_function_call(_function, _argument)
{
	var _argument_count = array_length(_argument);
	var _argument_parsed = array_create(_argument_count, undefined);
	var _i = 0;
	repeat (_argument_count)
	{
		_argument_parsed[_i] = get_interpreted_value(_argument[_i]);
		
		++_i;
	}
	
	return script_execute_ext(_function, _argument_parsed);
}
