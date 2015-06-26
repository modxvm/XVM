intrinsic class gfx.controls.StatusIndicator extends gfx.core.UIComponent
{
	public var _maximum : Object;
	public var _minimum : Object;
	public var _value : Object;

	public function get maximum() : Object;
	public function set maximum(value) : Void;

	public function get minimum() : Object;
	public function set minimum(value) : Void;

	public function get value() : Object;
	public function set value(value) : Void;

	public function get position() : Object;
	public function set position(value) : Void;


	public function StatusIndicator();

	public function toString();

	public function configUI();

	public function draw();

	public function updatePosition();

}
