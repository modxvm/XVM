intrinsic class net.wargaming.controls.BitmapFill extends gfx.core.UIComponent
{
	public var pos : Object;
	public var _src : Object;
	public var repeat : Object;
	public var startPos : Object;

	public function get source() : Object;
	public function set source(value) : Void;

	public function get setBitmap() : Object;
	public function set setBitmap(value) : Void;

	public function get width() : Object;
	public function set width(w) : Void;

	public function get height() : Object;
	public function set height(h) : Void;


	public function BitmapFill();

	public function createPos();

	public function configUI();

	public function draw();

	public function setSize(w, h);

}