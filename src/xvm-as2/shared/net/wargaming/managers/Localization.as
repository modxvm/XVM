intrinsic class net.wargaming.managers.Localization
{
	public function Localization();

	static public function gold(value);

	static public function integer(value);

	static public function float(value);

	static public function niceNumber(value);

	static public function parseFormattedInteger(value);

	static public function shortTime(value);

	static public function longTime(value);

	static public function shortDate(value);

	static public function longDate(value);

	static public function makeString(key, param);

	static public function getDate(value);

	static public function getNumber(value);

}