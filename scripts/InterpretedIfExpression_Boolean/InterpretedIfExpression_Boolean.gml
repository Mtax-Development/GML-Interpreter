//  @function				InterpretedIfExpression_Boolean
/// @argument				{any} value
/// @description			Container for a boolean expression in an "if" statement of an interpreted
///							script. Allows for checking if its current value is boolean true to decide
///							if the statement content should be executed.
function InterpretedIfExpression_Boolean(_value) constructor
{
	static constructor = InterpretedIfExpression_Boolean;
	
	value = _value;

	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the value of the expresion.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		
		return (_constructor_name + _constructor_name_bracket_open + string(value) +
				_constructor_name_bracket_close);
	}
}
