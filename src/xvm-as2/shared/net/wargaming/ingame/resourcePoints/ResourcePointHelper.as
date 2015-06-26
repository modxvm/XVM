intrinsic class net.wargaming.ingame.resourcePoints.ResourcePointHelper
{
	static public var _instance : Object;
	static public var SHADOW_DEFAULT_ANGLE : Object;
	static public var SHADOW_DEFAULT_DISTANCE : Object;
	static public var SHADOW_DEFAULT_COLOR : Object;
	static public var SHADOW_DEFAULT_ALPHA : Object;
	static public var SHADOW_DEFAULT_BLUR : Object;
	static public var SHADOW_DEFAULT_STRENGTH : Object;
	static public var SHADOW_DEFAULT_QUALITY : Object;
	static public var SHADOW_DEFAULT_INNER : Object;
	static public var SHADOW_DEFAULT_KNOCKOUT : Object;
	static public var SHADOW_DEFAULT_HIDE_OBJ : Object;
	static public var COLOR_SCHEME_OWN_MINING : Object;
	static public var COLOR_SCHEME_ENEMY_MINING : Object;
	static public var COLOR_SCHEME_COOLDOWN : Object;
	static public var COLOR_SCHEME_READY : Object;
	static public var INACTIVE_POINT_SCHEME_NAME : Object;
	static public var ENEMY_POINT_SCHEME_NAME : Object;
	static public var ALLY_POINT_SCHEME_NAME : Object;
	static public var READY_POINT_SCHEME_NAME : Object;
	static public var ALLY_FREEZE_SCHEME_NAME : Object;
	static public var ENEMY_FREEZE_SCHEME_NAME : Object;
	static public var CONFLICT_SCHEME_NAME : Object;
	static public var ITEM_LINKAGE : Object;
	static public var FONT_SIZE : Object;
	static public var ICON_NAME : Object;

	static public function get instance() : Object;


	public function ResourcePointHelper();

	public function getColorNameByState(state);

	public function createPointMarker(container, pointIdx);

	public function createShadow();

	public function getTextColor(state);

}