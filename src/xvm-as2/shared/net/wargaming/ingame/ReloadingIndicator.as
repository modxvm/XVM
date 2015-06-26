intrinsic class net.wargaming.ingame.ReloadingIndicator extends gfx.core.UIComponent
{
	public var contentContainer : Object;
	static public var FRACTIONAL_SIGNS : Object;
	public var _time : Object;

	public function ReloadingIndicator();

	public function setup(alphaValue);

	public function updateTime(time, isInProgress);

	public function externalFormat();

	public function internalFormat();

	public function checkEIAvailable();

}