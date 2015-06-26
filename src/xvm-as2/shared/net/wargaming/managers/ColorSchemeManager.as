intrinsic class net.wargaming.managers.ColorSchemeManager
{
	static public var _instance : Object;
	static public var _colors : Object;
	public var _callbacks : Object;
	static public var SET_COLORS_EVENT : Object;
	static public var GET_COLORS_EVENT : Object;

	static public function get instance() : Object;


	public function ColorSchemeManager();

	static public function initialize();

	public function update();

	public function addChangeCallBack(scope, func_name);

	public function __notifyCallbacks();

	public function getScheme(schemeName);

	public function getAdjustMatrixFilter(schemeName);

	public function getAliasColor(schemeName);

	public function getRGB(schemeName);

	public function getTransform(schemeName);

	public function onSetColors();

}
