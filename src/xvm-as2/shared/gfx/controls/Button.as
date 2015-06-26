intrinsic class gfx.controls.Button extends gfx.core.UIComponent
{
	public var _disabled : Object;
	public var state : Object;
	public var toggle : Object;
	public var doubleClickEnabled : Object;
	public var autoRepeat : Object;
	public var lockDragStateChange : Object;
	public var _selected : Object;
	public var _autoSize : Object;
	public var _disableFocus : Object;
	public var _disableConstraints : Object;
	public var doubleClickDuration : Object;
	public var buttonRepeatDuration : Object;
	public var buttonRepeatDelay : Object;
	public var pressedByKeyboard : Object;
	public var stateMap : Object;

	public function get labelID() : Object;
	public function set labelID(value) : Void;

	public function get label() : Object;
	public function set label(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get selected() : Object;
	public function set selected(value) : Void;

	public function get groupName() : Object;
	public function set groupName(value) : Void;

	public function get group() : Object;
	public function set group(value) : Void;

	public function get disableFocus() : Object;
	public function set disableFocus(value) : Void;

	public function get disableConstraints() : Object;
	public function set disableConstraints(value) : Void;

	public function get autoSize() : Object;
	public function set autoSize(value) : Void;


	public function Button();

	public function setSize(width, height);

	public function handleInput(details, pathToFocus);

	public function toString();

	public function configUI();

	public function draw();

	public function updateAfterStateChange();

	public function calculateWidth();

	public function setState(state);

	public function getStatePrefixes();

	public function changeFocus();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

	public function handlePress();

	public function handleMouseRelease(mouseIndex, button);

	public function handleRelease();

	public function handleClick(mouseIndex, button);

	public function handleDragOver(mouseIndex);

	public function handleDragOut(mouseIndex);

	public function handleReleaseOutside(mouseIndex, button);

	public function doubleClickExpired();

	public function beginButtonRepeat(mouseIndex, button);

	public function handleButtonRepeat(mouseIndex, button);

	public function clearRepeatInterval();

}