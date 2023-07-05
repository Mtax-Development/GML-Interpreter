//  @function				interpret_repeat_loop()
/// @argument				{StringParser} line
/// @argument				{string[]} lineSet
/// @argument				{int} lineSet_position
/// @returns				[{InterpretedRepeatLoop}, {int}]
/// @description			Interpret the specified line and return data for the "repeat" loop and
///							amount of lines the loop occupied, to skip repeated interpretation.
function interpret_repeat_loop(_line, _lineSet, _lineSet_position)
{
	static _stringParser = new StringParser();
	
	var _iteration_count = interpret_value_string(_stringParser.setParser(_line).getBetween("(", ")"));
	var _statement_interpreted = "";
	var _statement_started = false;
	var _bracket_nest_level = 0;
	var _i = _lineSet_position;
	repeat (array_length(_lineSet) - _lineSet_position)
	{
		_stringParser.setParser(_lineSet[_i]);
		
		if (!_statement_started)
		{
			if (_stringParser.contains("{"))
			{
				_statement_started = true;
				++_bracket_nest_level;
			}
		}
		else
		{
			if (_stringParser.contains("{"))
			{
				++_bracket_nest_level;
			}
			
			if (_stringParser.contains("}"))
			{
				--_bracket_nest_level;
			}
			
			if (_bracket_nest_level > 0)
			{
				_statement_interpreted += (_stringParser.ID + "\n");
			}
			else
			{
				break;
			}
		}
		
		++_i;
	}
	
	return [new InterpretedRepeatLoop(_iteration_count, script_interpret(_statement_interpreted)),
			(_i - _lineSet_position)];
}
