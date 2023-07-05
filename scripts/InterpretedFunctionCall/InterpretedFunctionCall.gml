//  @function				InterpretedFunction
/// @argument				{int:function} function_index
/// @argument				{any[]} function_argument
/// @description			Container for the function index and arguments of an interpreted script.
///							Allows for execution of the given function and its arguments, which can
///							include references to variables previously declared in the execution scope.
function InterpretedFunctionCall(_function_index, _function_argument) constructor
{
	static constructor = InterpretedFunctionCall;
	
	function_index = _function_index;
	function_argument = _function_argument;
	
	// @returns				{string}
	// @description			Create a string representing this constructor.
	//						Overrides the string() conversion.
	//						Content will be represented as the name of the function and argument
	//						listing.
	static toString = function(_short = false)
	{
		var _constructor_name = ((_short) ? "" : instanceof(self));
		var _constructor_name_bracket_open = ((_short) ? "" : "(");
		var _constructor_name_bracket_close = ((_short) ? "" : ")");
		
		var _function_argument_text = "";
		
		if (is_array(function_argument))
		{
			var _i = 0;
			repeat (array_length(function_argument))
			{
				_function_argument_text += (((_i > 0) ? ", " : "") + string(function_argument[_i]));
				
				++_i;
			}
		}
		else
		{
			_function_argument_text = string(undefined);
		}
		
		return (_constructor_name + _constructor_name_bracket_open +
				((is_real(function_index)) ? script_get_name(function_index)
										   : string(function_index)) +
				"(" + _function_argument_text + ")" + _constructor_name_bracket_close);
	}
}
