//  @function				InterpretedError
/// @argument				{string} message
/// @argument				{string} line
/// @description			Container for data of an error during script interpretation. Not intended
///							for use during script execution.
function InterpretedError(_message, _line) constructor
{
	constructor = InterpretedError;
	
	message = _message;
	line = _line;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the this error details.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		var _error_text = (string(message) + " --> " + string(line));
		
		return (_constructor_name + _constructor_name_bracket_open + _error_text +
				_constructor_name_bracket_close);
	}
}
