intrinsic class gfx.controls.TextInput extends gfx.core.UIComponent
{
	public var _disabled : Object;
	public var defaultText : Object;
	public var _text : Object;
	public var _maxChars : Object;
	public var _noTranslate : Object;
	public var _editable : Object;
	public var actAsButton : Object;
	public var hscroll : Object;
	public var changeLock : Object;

	public function get textID() : Object;
	public function set textID(value) : Void;

	public function get text() : Object;
	public function set text(value) : Void;

	public function get htmlText() : Object;
	public function set htmlText(value) : Void;

	public function get editable() : Object;
	public function set editable(value) : Void;

	public function get password() : Object;
	public function set password(value) : Void;

	public function get maxChars() : Object;
	public function set maxChars(value) : Void;

	public function get noTranslate() : Object;
	public function set noTranslate(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get length() : Object;


	public function TextInput();

	public function appendText(text);

	public function appendHtml(text);

	public function handleInput(details, pathToFocus);

	public function toString();

	public function configUI();

	public function setState();

	public function setMouseHandlers();

	public function handleMousePress(mouseIndex, button);

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function draw();

	public function changeFocus();

	public function updateText();

	public function updateTextField();

	public function onChanged(target);

}