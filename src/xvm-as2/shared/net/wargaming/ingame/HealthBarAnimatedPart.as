intrinsic class net.wargaming.ingame.HealthBarAnimatedPart extends gfx.core.UIComponent
{
	static public var SPLASH_DURATION : Object;
	static public var SHOW_STATE : Object;
	static public var ACTIVE_STATE : Object;
	static public var HIDE_STATE : Object;
	static public var INACTIVE_STATE : Object;
	static public var IMITATION_STATE : Object;
	public var tweenState : Object;
	public var _isPlaying : Object;
	public var _pendingVisibility : Object;

	public function set visible(value) : Void;


	public function HealthBarAnimatedPart();

	public function configUI();

	public function playShowTween();

	public function setState();

	public function onTweenComplete(isShow);

	public function inActiveState();

	public function playHideTween();

	public function setFlag(flag);

}
