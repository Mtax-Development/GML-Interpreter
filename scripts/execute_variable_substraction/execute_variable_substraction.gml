//  @function				execute_variable_substraction()
/// @argument				{string} name
/// @argument				{InterpretedVariable|InterpretedFunctionCall|any} value
/// @description			Execute a variable substraction from a variable of the specified name in
///							the current scope or the subsidiary local scope. If the variable was
///							initially declared in the local scope, it will be first read there.
function execute_variable_substraction(_name, _value)
{
	var _local_variable_scope = variable_struct_get(self, "var");
	var _scope = ((variable_struct_exists(_local_variable_scope, _name)) ? _local_variable_scope : self);
	var _current_value = variable_struct_get(_scope, _name);
	var _substracting_value = ((instanceof(_value) == "InterpretedFunctionCall")
							   ? execute_function_call(_value.function_index, _value.function_argument)
							   : get_interpreted_value(_value));
	
	variable_struct_set(_scope, _name, (_current_value - _substracting_value));
}
