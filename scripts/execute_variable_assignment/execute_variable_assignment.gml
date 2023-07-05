//  @function				execute_variable_assignment()
/// @argument				{string} name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} value
/// @argument				{bool} is_local
/// @description			Execute a variable assignment to a variable of the specified name in the
///							current scope or the subsidiary local scope. If the variable was initially
///							declared in the local scope, it will be first read there.
function execute_variable_assignment(_name, _value, _is_local)
{
	var _local_variable_scope = variable_struct_get(self, "var");
	var _scope = ((_is_local) ? _local_variable_scope
							  : ((variable_struct_exists(_local_variable_scope, _name))
								 ? _local_variable_scope : self));
	var _executed_value = ((instanceof(_value) == "InterpretedFunctionCall")
						   ? execute_function_call(_value.function_index, _value.function_argument)
						   : _value);
	
	variable_struct_set(_scope, _name, _executed_value);
}
