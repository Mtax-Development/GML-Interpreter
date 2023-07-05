//  @function				script_interpret()
/// @argument				{string} script
/// @returns				{constructor[]} | On error: {undefined}
/// @description			Venture through the specified GameMaker Language script with an interpreter
///							syntax tree. Constructors representing ordered calls and their data will be
///							returned in an array. If the parsed script contains an error, the operation
///							stops and the first error found is reported.
function script_interpret(_script)
{
	static _stringParser = new StringParser();
	static _line = new StringParser();
	
	var _lineSet = _stringParser.setParser(_script).split("\n");
	var _lineSet_size = array_length(_lineSet);
	var _call = [];
	var _i = 0;
	repeat (_lineSet_size)
	{
		//|Shorten the loop after lines were skipped.
		if (_i >= _lineSet_size)
		{
			break;
		}
		
		//|Prepare the line and remove non-applicable symbols.
		_line.setParser(_lineSet[_i]).trim().trim(";").trim();
		
		//|Interpreter syntax tree.
		if (!line_is_valid(_line)) {}
		else if (_line.getSubstringCount("=") == 1)
		{
			switch (_line.getChar(_line.getSubstringPosition("=") - 1))
			{
				case "+": array_push(_call, interpret_variable_addition(_line)); break;
				case "-": array_push(_call, interpret_variable_substraction(_line)); break;
				case "*": array_push(_call, interpret_variable_multiplication(_line)); break;
				case "/": array_push(_call, interpret_variable_division(_line)); break;
				default: array_push(_call, interpret_variable_assignment(_line)); break;
			}
		}
		else if (_line.contains("++"))
		{
			array_push(_call, interpret_variable_addition(_line));
		}
		else if (_line.contains("--"))
		{
			array_push(_call, interpret_variable_substraction(_line));
		}
		else if (_line.startsWith("if ", "if("))
		{
			var _parse_result = interpret_if_statement(_line, _lineSet, _i);
			_i += _parse_result[1];
			
			array_push(_call, _parse_result[0]);
		}
		else if (_line.startsWith("repeat ", "repeat("))
		{
			var _parse_result = interpret_repeat_loop(_line, _lineSet, _i);
			_i += _parse_result[1];
			
			array_push(_call, _parse_result[0]);
		}
		else if (_line.containsAll("(", ")"))
		{
			array_push(_call, interpret_function_call(_line));
		}
		
		//|Error handling.
		var _call_position_last = (array_length(_call) - 1);
		
		if ((_call_position_last >= 0)
		and (_call[_call_position_last].constructor == InterpretedError))
		{
			new ErrorReport().report([self, "script_interpret()"],
									 _call[_call_position_last].toString(true));
			
			//|Return in case of error.
			return undefined;
		}
		
		++_i;
	}
	
	//|Return in case of success.
	return _call;
}
