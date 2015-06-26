intrinsic class net.wargaming.utils.StringUtils
{
	public var _loc4 : Object;
	public var _loc3 : Object;
	public var _loc1 : Object;
	public var _loc11 : Object;
	public var _loc14 : Object;
	public var _loc1 : Object;
	public var _loc9 : Object;
	public var _loc7 : Object;
	public var _loc10 : Object;

	public function StringUtils();

	static public function init();

	static public function getWrappedText(textField, data, splitSymbol, breakSymbol);

	static public function putWrappedText(str, textFields);

	static public function keyToString(key);

	static public function stringToKey(key_string);

	static public function keyToUserString(key);

	static public function searchAndReplace(holder, searchfor, replacement);

	static public function stripWhitespace(text, options);

	static public function formatPlayerName(tf, nick, clan, region, igrType, prefix, suffix);

}