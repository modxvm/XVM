intrinsic class net.wargaming.controls.Slider extends gfx.controls.Slider
{
	public var track : Object;
	public var _undefined : Object;
	public var _trackWidth : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get undefinedDisabled() : Object;
	public function set undefinedDisabled(value) : Void;


	public function Slider();

	public function configUI();

	public function onSliderOver(event);

	public function onSliderOut(event);

	public function onSliderPress(event);

	public function scrollWheel(delta);

	public function updateThumb();

	public function updateTrackWidth();

	public function toString();

}