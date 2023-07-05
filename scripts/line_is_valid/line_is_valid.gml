//  @function				line_is_valid()
/// @argument				{StringParser} line
/// @returns				{bool}
/// @description			Check if the specified trimmed line contains interpretable code.
function line_is_valid(_line)
{
	return ((_line.getSize() > 0) and (!_line.startsWith("//")));
}
