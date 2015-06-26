intrinsic class net.wargaming.controls.ButtonBarEx extends gfx.controls.ButtonBar
{
	public var _visible : Object;
	public var _paddingHorizontal : Object;

	public function get paddingHorizontal() : Object;
	public function set paddingHorizontal(value) : Void;


	public function ButtonBarEx();

	public function draw();

	public function disableButton(index, value);

	public function drawLayout();

	public function createRenderer(index);

	public function toString();

}