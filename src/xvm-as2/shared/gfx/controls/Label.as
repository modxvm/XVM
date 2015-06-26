intrinsic class gfx.controls.Label extends gfx.core.UIComponent
{
	public var _autoSize : Object;

	public function get textID() : Object;
	public function set textID(value) : Void;

	public function get text() : Object;
	public function set text(value) : Void;

	public function get htmlText() : Object;
	public function set htmlText(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get autoSize() : Object;
	public function set autoSize(value) : Void;


	public function Label();

	public function setSize(width, height);

	public function toString();

	public function configUI();

	public function calculateWidth();

	public function updateAfterStateChange();

	public function draw();

	public function setState();

}
