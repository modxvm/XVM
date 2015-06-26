intrinsic class net.wargaming.controls.SliderPointer extends gfx.core.UIComponent
{
	public var onRollOver : Object;
	public var _pointName : Object;
	public var _disabled : Object;
	public var _state : Object;

	public function get pointName() : Object;
	public function set pointName(val) : Void;

	public function set disabled(val) : Void;

	public function get state() : Object;
	public function set state(val) : Void;


	public function SliderPointer();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

}