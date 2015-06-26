intrinsic class net.wargaming.ingame.RepairPointTimer extends gfx.core.UIComponent
{
	public var title : Object;
	static public var STATE_PROGRESS : Object;
	static public var STATE_COOLDOWN : Object;
	static public var STATE_NONE : Object;
	public var _state : Object;
	public var _intervalTimerID : Object;

	public function RepairPointTimer();

	public function show(seconds, state, titleString, descriptionString);

	public function hide();

	public function setTimerPosition(baseTime, percent, state, titleString, descriptionString);

	public function setTexts(titleString, descriptionString);

	public function setState(state);

	public function setTime(seconds);

	public function startTimer(seconds);

	public function stopTimer();

	public function timerUpdate();

}