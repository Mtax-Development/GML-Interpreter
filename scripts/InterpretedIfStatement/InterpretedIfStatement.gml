//  @function				InterpretedIfStatement
/// @argument				{constructor[]} expression_interpreted
/// @argument				{constructor[]} statement_interpreted
/// @description			Container for an "if" statement of an interpreted script. Contains data of
///							the expression controlling when the statement executes and the content of
///							the statement.
function InterpretedIfStatement(_expression_interpreted, _statement_interpreted) constructor
{
	static constructor = InterpretedIfStatement;
	
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
			var _expression_string = "";
			var _statement_string = "";
			
			if (is_array(expression_interpreted))
			{
				var _i = 0;
				repeat (array_length(expression_interpreted))
				{
					_expression_string += (((_i > 0) ? " " : "") + "(" +
										   ((string_copy(instanceof(expression_interpreted[_i]), 1,
										     24) == "InterpretedIfExpression_")
										    ? expression_interpreted[_i].toString(true)
										    : string(expression_interpreted[_i])) + ")");
					
					++_i;
				}
				
				if (_i > 1)
				{
					_expression_string = ("(" + _expression_string + ")");
				}
			}
			else
			{
				_expression_string = string(expression_interpreted);
			}
			
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
			
			return ("if " + "(" + _expression_string + ")" + "\n" +
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
