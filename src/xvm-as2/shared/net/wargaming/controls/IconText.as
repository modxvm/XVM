intrinsic class net.wargaming.controls.IconText extends gfx.core.UIComponent
{
	public var textField : Object;
	public var _iconPosition : Object;
	public var _fitIconPosition : Object;
	public var _textAlign : Object;
	public var _textFont : Object;
	public var _textSize : Object;
	public var _textColor : Object;
	public var _toolTip : Object;
	public var xCorrect : Object;
	public var _textFieldYOffset : Object;

	public function get iconPosition() : Object;
	public function set iconPosition(value) : Void;

	public function get fitIconPosition() : Object;
	public function set fitIconPosition(value) : Void;

	public function get textAlign() : Object;
	public function set textAlign(value) : Void;

	public function get textFont() : Object;
	public function set textFont(value) : Void;

	public function get textSize() : Object;
	public function set textSize(value) : Void;

	public function get textColor() : Object;
	public function set textColor(value) : Void;

	public function get toolTip() : Object;
	public function set toolTip(value) : Void;

	public function get text() : Object;
	public function set text(value) : Void;

	public function get icon() : Object;
	public function set icon(value) : Void;

	public function get textFieldYOffset() : Object;
	public function set textFieldYOffset(val) : Void;


	public function IconText();

	public function configUI();

	public function draw();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

}