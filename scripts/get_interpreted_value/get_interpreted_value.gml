//  @function				get_interpreted_value()
/// @argument				{InterpretedVariable|any} value
/// @description			Return the specified value if it is a static written value. If that value is
///							a reference to a variable in an interpreted script, return the current value
///							of the variable with its name by searching for a local variable first.
function get_interpreted_value(_value)
{
	if (instanceof(_value) == "InterpretedVariable")
	{
		var _local_variable_scope = variable_struct_get(self, "var");
		
		return ((variable_struct_exists(_local_variable_scope, _value.name))
				? variable_struct_get(_local_variable_scope, _value.name)
				: variable_struct_get(self, _value.name));
	}
	else
	{
		return _value;
	}
}
