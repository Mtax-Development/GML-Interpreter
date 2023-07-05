//  @function				write_function_pairing()
/// @argument				{string:path} path_target
/// @argument				{string[]} function_listing
/// @description			Prepare a useable GameMaker script file listing specified function names
///							paired with GameMaker function indexes and save it to the specified path.
function write_function_pairing(_path_target, _function_listing)
{
	var _tabulation = "\u0009";
	var _description = ("//  @function				get_function()" + "\n" +
						"/// @argument				{string} name" + "\n" +
						"/// @returns				{function}" + "\n" +
						"/// @description			Attempt returning an index of a function with " +
													"the specified name." + "\n");
	var _function_declaration = ("function get_function(_name)" + "\n" +
								 "{" + "\n" +
								 _tabulation + "switch (_name)" + "\n" +
								 _tabulation + "{" + "\n");
	var _result = (_description + _function_declaration);
	var _i = 0;
	repeat (array_length(_function_listing))
	{
		_result += (_tabulation + _tabulation + "case \"" + _function_listing[_i] + "\"" + ": " +
					"return " + _function_listing[_i] + ";" + " " + "break;" + "\n");
		
		++_i;
	}
	
	_result += (_tabulation + "}" + "\n" +
				"}" + "\n");
	
	var _stream = file_text_open_write(_path_target);
	{
		file_text_write_string(_stream, _result);
	}
	file_text_close(_stream);
}
