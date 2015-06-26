intrinsic class net.wargaming.ingame.resourcePoints.BaseResourcePointItem extends MovieClip
{
	public var getNextHighestDepth : Object;
	static public var COLOR_BLIND_NAME : Object;
	static public var COOLDOWN_NAME : Object;
	static public var READY_NAME : Object;
	static public var OWN_NAME : Object;
	static public var ENEMY_NAME : Object;
	static public var ENEMY_BLIND_NAME : Object;
	static public var CONFLICT_NAME : Object;
	static public var CONFLICT_BLIND_NAME : Object;
	static public var ENEMY_FREEZE_NAME : Object;
	static public var ENEMY_FREEZE_BLIND_NAME : Object;
	static public var OWN_FREEZE_NAME : Object;
	static public var OWN_FREEZE_BLIND_NAME : Object;
	static public var NORMAL_ANIM_NAME : Object;
	static public var COOLDOWN_ANIM_NAME : Object;
	static public var PERCENT_KOEF : Object;
	static public var FIRST_FRAME : Object;
	static public var ANIM_DURATION : Object;
	public var _state : Object;
	public var _progress : Object;

	public function get state() : Object;
	public function set state(newState) : Void;

	public function get progress() : Object;
	public function set progress(value) : Void;

	public function get cooldown() : Object;

	public function get current() : Object;
	public function set current(value) : Void;


	public function BaseResourcePointItem();

	public function init(pointIdx);

	public function onChangeSettings();

	public function getEnemyItem();

	public function getOwnFreezeItem();

	public function getEnemyFreezeItem();

	public function getConflictItem();

}