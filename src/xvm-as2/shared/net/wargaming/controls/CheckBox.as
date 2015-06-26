intrinsic class net.wargaming.controls.CheckBox extends gfx.controls.CheckBox
{
	public var waiting_mc : Object;
	public var soundType : Object;
	public var soundId : Object;
	public var _waiting : Object;
	public var _icoPosIsIvalid : Object;
	public var infoIcon : Object;

	public function get waiting() : Object;
	public function set waiting(value) : Void;

	public function set visible(value) : Void;


	public function CheckBox();

	public function configUI();

	public function onSoundOver(e);

	public function onSoundOut(e);

	public function onSoundPress(e);

	public function playSound(state);

	public function draw();

	public function setIco(val);

	public function updateAfterStateChange();

	public function updateInfoIcoPosition();

	public function UpdateVisabilityIco();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

	public function handlePress();

}