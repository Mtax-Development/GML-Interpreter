if ((!is_string(script_path)) or (string_length(script_path) <= 0))
{
	exit;
}
show_message(string_length(script_path));
var _script = file_to_string(script_path);

if (string_length(_script) > 0)
{
	var _interpretation = script_interpret(_script);
	
	if (is_array(_interpretation))
	{
		script_execute_interpretation(scope, _interpretation);
	}
}
