intrinsic class gfx.core.UIComponent extends MovieClip
{
	public var _width : Object;
	public var initialized : Object;
	public var __width : Object;
	public var __height : Object;
	public var _disabled : Object;
	public var _focused : Object;
	public var _displayFocus : Object;
	public var sizeIsInvalid : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get visible() : Object;
	public function set visible(value) : Void;

	public function get width() : Object;
	public function set width(value) : Void;

	public function get height() : Object;
	public function set height(value) : Void;

	public function get focused() : Object;
	public function set focused(value) : Void;

	public function get displayFocus() : Object;
	public function set displayFocus(value) : Void;


	public function UIComponent();

	public function onLoad();

	static public function createInstance(context, symbol, name, depth, initObj);

	public function setSize(width, height);

	public function handleInput(details, pathToFocus);

	public function invalidate();

	public function validateNow();

	public function toString();

	public function configUI();

	public function initSize();

	public function draw();

	public function changeFocus();

	public function onMouseWheel(delta, target);

	public function scrollWheel(delta);

}