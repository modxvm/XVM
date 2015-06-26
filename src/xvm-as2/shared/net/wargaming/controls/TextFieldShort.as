intrinsic class net.wargaming.controls.TextFieldShort extends gfx.controls.ListItemRenderer
{
	public var textField : Object;
	public var _textColor : Object;
	public var _short : Object;
	public var _altToolTip : Object;
	public var handleKeyboard : Object;

	public function get textFont() : Object;
	public function set textFont(value) : Void;

	public function get useHtml() : Object;
	public function set useHtml(value) : Void;

	public function get tooltipOnShort() : Object;
	public function set tooltipOnShort(value) : Void;

	public function get textSize() : Object;
	public function set textSize(value) : Void;

	public function get textAlign() : Object;
	public function set textAlign(value) : Void;

	public function get textColor() : Object;
	public function set textColor(value) : Void;

	public function get shadowColor() : Object;
	public function set shadowColor(value) : Void;

	public function get toolTip() : Object;
	public function set toolTip(value) : Void;

	public function get altToolTip() : Object;
	public function set altToolTip(value) : Void;

	public function get text() : Object;
	public function set text(value) : Void;

	public function get label() : Object;
	public function set label(value) : Void;


	public function TextFieldShort();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function configUI();

	public function draw();

	public function toString();

	public function handleInput(details, pathToFocus);

}