//  @function				InterpretedIfExpression_Comparison
/// @argument				{any} left
/// @argument				{any} right
/// @description			Container for a comprasion expression in an "if" statement of an interpreted
///							script. Allows for comparing the current value of its both sides to decide
///							if the statement content should be executed.
function InterpretedIfExpression_Comparison(_left, _right) constructor
{
	static constructor = InterpretedIfExpression_Comparison;
	
	left = _left;
	right = _right;

	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as both sides of the expression.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		
		return (_constructor_name + _constructor_name_bracket_open + string(left) + " == " +
				string(right) + _constructor_name_bracket_close);
	}
}
