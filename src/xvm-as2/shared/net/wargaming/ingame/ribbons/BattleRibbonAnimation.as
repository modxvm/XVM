intrinsic class net.wargaming.ingame.ribbons.BattleRibbonAnimation extends MovieClip
{
	public var onEnterFrame : Object;
	static public var SHOWING_COMPLETE : Object;
	static public var HIDE : Object;
	static public var SHOW_LBL : Object;
	static public var SHOW_END_LBL : Object;
	static public var STATIC_LBL : Object;
	static public var STATIC_END_LBL : Object;
	static public var CHANGE_LBL : Object;
	static public var CHANGE_END_LBL : Object;
	static public var HIDE_LBL : Object;
	static public var HIDE_END_LBL : Object;

	public function get currentType() : Object;

	public function get isRunning() : Object;


	public function BattleRibbonAnimation();

	public function onEnterFrameHandler();

	public function setRibbon(ribbon, type, title, count);

	public function setRibbonFrom(src, dest);

	public function reset();

	public function show(type, title, count);

	public function hide();

	public function change(type, title, count);

	public function incCount(value);

}