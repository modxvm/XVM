intrinsic class net.wargaming.controls.ProgressBar extends gfx.controls.ProgressBar
{
	public var divisor_mc : Object;
	public var _flashing : Object;
	public var _divisor : Object;

	public function get flashing() : Object;
	public function set flashing(value) : Void;


	public function ProgressBar();

	public function setDivisor(loaded, total);

	public function toString();

	public function setProgress(loaded, total);

}