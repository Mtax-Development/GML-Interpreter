//  @function				create_function_listing()
/// @argument				{string:path} path_source?
/// @returns				{string[]}
/// @description			Return a string array with names of built-in GameMaker functions, using an
///							approach decided by whether a path to a text file was specified:
///							 - Path was specified: Each line in the file will be parsed and added as a
///							   function name if the name contains an opening curly bracket.
///							 - Path not specified: An attempt of iterating through GameMaker function
///							   indexes will be performed to return their names. This will produce
///							   different results depending on the version of GameMaker.
function create_function_listing(_path_source)
{
	var _stringParser = new StringParser();
	var _uniqueName = ds_list_create();
	var _result = [];
	
	if (is_string(_path_source))
	{
		var _lineSet = _stringParser.setParser(file_to_string(_path_source)).split("\n");
		var _i = 0;
		repeat (array_length(_lineSet))
		{
			_stringParser.setParser(_lineSet[_i]).trim();
			
			if ((_stringParser.contains("(")) and (!_stringParser.contains("#", "&", "/"))
			and (!_stringParser.contains("gml_pragma")))
			{
				var _function_name = _stringParser.split("(")[0];
				
				if (!(ds_list_find_index(_uniqueName, _function_name) >= 0))
				{
					ds_list_add(_uniqueName, _function_name);
					array_push(_result, _function_name);	
				}
			}
		
			++_i;
		}
	}
	else
	{
		var _function_name = undefined;
		var _function_name_previous = undefined;
		var _i = 0;
		while (true)
		{
			_function_name = script_get_name(_i);
			
			if (is_string(_function_name))
			{
				if (_function_name != _function_name_previous)
				{
					_stringParser.setParser(_function_name);
					
					if ((!(ds_list_find_index(_uniqueName, _function_name) >= 0))
					and (!_stringParser.contains(" ", "@", "$", "yoyo", "gml_pragma"))
					and (_function_name == string_lower(_function_name)))
					{
						ds_list_add(_uniqueName, _stringParser.ID);
						array_push(_result, _stringParser.ID);
					}
				}
				else
				{
					var _result_position_last = (array_length(_result) - 1);
					
					if (_function_name_previous == _result[_result_position_last])
					{
						array_delete(_result, _result_position_last, 1);
					}
					
					break;
				}
			}
			else
			{
				break;
			}
			
			_function_name_previous = _function_name;
			
			++_i;
		}
	}
	
	ds_list_destroy(_uniqueName);
	
	return _result;
}
