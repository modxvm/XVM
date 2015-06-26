intrinsic class net.wargaming.messenger.controls.BattleHistoryButton extends net.wargaming.controls.buttons.SoundButton
{
	public var upArrow : Object;
	public var _arrowDirection : Object;

	public function get arrowDirection() : Object;
	public function set arrowDirection(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;


	public function BattleHistoryButton();

	public function onMousePressHandler(obj);

	public function draw();

	public function updateArrowState();

}