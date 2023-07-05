//  @function				debug_read_interpreted_call()
/// @argument				{constructor[]} call
/// @returns				{string}
/// @description			Return a string containing representations of interpreted script
///							constructors to imitate code they were interpreted from.
function debug_read_interpreted_call(_call)
{
	if (is_array(_call))
	{
		var _call_string = "";
		var _i = 0;
		repeat (array_length(_call))
		{
			_call_string += ((_i > 0 ? "\n" : "") + ((is_struct(_call[_i])) ? _call[_i].toString(true)
																			: string(_call[_i])));
			
			++_i;
		}
		
		return _call_string;
	}
	else
	{
		return string(_call);
	}
}
