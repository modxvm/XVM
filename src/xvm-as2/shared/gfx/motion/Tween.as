intrinsic class gfx.motion.Tween extends MovieClip
{
	public var _loc4 : Object;
	static public var _instance : Object;

	public function Tween();

	static public function linearEase(t, b, c, d);

	static public function init();

	public function tweenTo(duration, props, ease);

	public function tweenFrom(duration, props, ease);

	public function tweenEnd(jumpToEnd);

	public function tween__start(duration, props, ease, startProps);

	public function tween__to(position);

	public function tween__run();

}