intrinsic class net.wargaming.controls.buttons.SoundButton extends gfx.controls.Button
{
	public var constraints : Object;
	public var soundType : Object;
	public var soundId : Object;
	public var helpText : Object;
	public var helpDirection : Object;
	public var helpConnectorLength : Object;
	public var _disableFillPadding : Object;
	public var _paddingHorizontal : Object;
	public var _label : Object;

	public function get disableFillPadding() : Object;
	public function set disableFillPadding(value) : Void;

	public function get label() : Object;
	public function set label(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get paddingHorizontal() : Object;
	public function set paddingHorizontal(value) : Void;


	public function SoundButton();

	public function configUI();

	public function draw();

	public function setCaps(val);

	public function getCaps();

	public function showHelpLayout();

	public function closeHelpLayout();

	public function updateAfterStateChange();

	public function onSoundOver(e);

	public function onSoundOut(e);

	public function onSoundPress(e);

	public function playSound(state);

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

	public function calculateWidth();

	public function toString();

}
