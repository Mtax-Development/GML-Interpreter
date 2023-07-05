//  @function				InterpretedRepeatLoop
/// @argument				{constructor[]} expression_interpreted
/// @argument				{constructor[]} statement_interpreted
/// @description			Container for a "repeat" loop of an interpreted script. Contains data of
///							the expression controlling the number of iterations and the content of
///							the statement.
function InterpretedRepeatLoop(_expression_interpreted, _statement_interpreted) constructor
{
	static constructor = InterpretedRepeatLoop;
	
	expression_interpreted = _expression_interpreted;
	statement_interpreted = _statement_interpreted;

	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the expression and statement pair.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		
		if (_short)
		{
			var _tabulation = string_repeat(" ", 4);
			var _statement_string = "";
			
			if (is_array(statement_interpreted))
			{
				var _i = 0;
				repeat (array_length(statement_interpreted))
				{
					_statement_string += (_tabulation + ((_i > 0) ? "\n" : "") +
										  ((is_struct(statement_interpreted[_i]))
										   ? statement_interpreted[_i].toString(true)
										   : string(statement_interpreted[_i])));
					
					++_i;
				}
			}
			else
			{
				_statement_string = (_tabulation + string(statement_interpreted));
			}
			
			return ("repeat " + "(" + string(expression_interpreted) + ")" + "\n" +
					"{" + "\n" +
					_statement_string + "\n" +
					"}");
		}
		else
		{
			return (_constructor_name + _constructor_name_bracket_close +
					"expression: " + string(expression_interpreted) + ", " +
					"statement: " + string(statement_interpreted) + _constructor_name_bracket_close);
		}
	}
}
