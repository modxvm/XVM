intrinsic class net.wargaming.tutorial.items.TutorialMask extends gfx.core.UIComponent
{
	public var invalidate : Object;
	public var maskProps : Object;
	public var isMaskVisible : Object;
	static public var ALPHA_DURATION_MODIFER : Object;
	static public var ALPHA_MODE : Object;
	static public var IMMEDIATELY_MODE : Object;

	public function TutorialMask();

	public function moveToAndResize(x, y, hitWidth, hitHeight);

	public function reset();

	public function doVisible(mode);

	public function doUnvisible(mode);

	public function onTweenComplete();

	public function configUI();

	public function draw();

}