intrinsic class net.wargaming.ingame.ribbons.BattleRibbonTitleAnimation extends MovieClip
{
	public var onEnterFrame : Object;
	static public var INCREASE_COMPLETE : Object;
	static public var NORMAL_LBL : Object;
	static public var CHANGE_COUNT_LBL : Object;
	static public var CHANGE_COUNT_END_LBL : Object;

	public function get title() : Object;

	public function get count() : Object;


	public function BattleRibbonTitleAnimation();

	public function getCurTitle();

	public function startIncAnimation();

	public function onEnterFrameHandler();

	public function reset(title, count);

	public function incCount(value);

	public function isChangeState();

}