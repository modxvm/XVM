intrinsic class gfx.controls.Slider extends gfx.core.UIComponent
{
	public var tabChildren : Object;
	public var liveDragging : Object;
	public var state : Object;
	public var _minimum : Object;
	public var _maximum : Object;
	public var _value : Object;
	public var _snapInterval : Object;
	public var _snapping : Object;
	public var offsetLeft : Object;
	public var offsetRight : Object;

	public function get maximum() : Object;
	public function set maximum(value) : Void;

	public function get minimum() : Object;
	public function set minimum(value) : Void;

	public function get value() : Object;
	public function set value(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get position() : Object;
	public function set position(value) : Void;

	public function get snapping() : Object;
	public function set snapping(value) : Void;

	public function get snapInterval() : Object;
	public function set snapInterval(value) : Void;


	public function Slider();

	public function handleInput(details, pathToFocus);

	public function toString();

	public function configUI();

	public function draw();

	public function changeFocus();

	public function updateThumb();

	public function beginDrag(event);

	public function doDrag();

	public function endDrag();

	public function trackPress(e);

	public function lockValue(value);

	public function scrollWheel(delta);

}