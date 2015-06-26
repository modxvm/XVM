intrinsic class net.wargaming.controls.VehicleActionMarker extends gfx.core.UIComponent
{
	public var invalidate : Object;
	public var __actionBitMask : Object;
	public var __team : Object;

	public function get action() : Object;
	public function set action(bitMask) : Void;

	public function get team() : Object;
	public function set team(value) : Void;


	public function VehicleActionMarker();

	public function draw();

}