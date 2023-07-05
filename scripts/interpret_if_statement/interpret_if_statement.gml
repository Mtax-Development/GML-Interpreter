//  @function				interpret_if_statement()
/// @argument				{StringParser} line
/// @argument				{string[]} lineSet
/// @argument				{int} lineSet_position
/// @returns				[{InterpretedIfStatement}, {int}]
/// @description			Interpret the specified line and return data for the "if" statement and
///							amount of lines the statement occupied, to skip repeated interpretation.
function interpret_if_statement(_line, _lineSet, _lineSet_position)
{
	static _stringParser = new StringParser();
	
	var _expression_part = array(_stringParser.setParser(_line).getBetween("(", ")", undefined, true));
	var _expression_interpreted = [];
	var _i = 0;
	repeat (array_length(_expression_part))
	{
		_stringParser.setParser(_expression_part[_i]);
		
		if (_stringParser.contains("=="))
		{
			var _comparison = [_stringParser.setParser(_stringParser.setParser(_expression_part[_i])
															  .getBetween("(", "==")).trim().ID,
							   _stringParser.setParser(_stringParser.setParser(_expression_part[_i])
															  .getBetween("==", ")")).trim().ID];
			
			array_push(_expression_interpreted,
					   new InterpretedIfExpression_Comparison(interpret_value_string(_comparison[0]),
															  interpret_value_string(_comparison[1])));
		}
		else
		{
			var _value = _stringParser.getBetween("(", ")");
			
			array_push(_expression_interpreted,
					   new InterpretedIfExpression_Boolean(interpret_value_string(_value)));
		}
		
		++_i;
	}
	
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
	
	return [new InterpretedIfStatement(_expression_interpreted,
									   script_interpret(_statement_interpreted)),
			(_i - _lineSet_position)];
}
