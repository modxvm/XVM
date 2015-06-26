intrinsic class net.wargaming.ingame.FortConsumablesMarker extends gfx.core.UIComponent
{
	public var marker : Object;
	public var bgShadow : Object;
	public var timerTF : Object;
	public var defaultTF : Object;
	public var _orderType : Object;
	public var _timer : Object;
	public var _defaultPostfix : Object;

	public function FortConsumablesMarker();

	public function init(orderType, timer, postfix);

	public function initAllElements();

	public function initIconFrames();

	public function updateDefaultText();

	public function updateTimerText();

	public function updateTimer(time);

}