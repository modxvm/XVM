intrinsic class gfx.controls.ProgressBar extends gfx.controls.StatusIndicator
{
	public var targetClip : Object;
	public var _mode : Object;

	public function get target() : Object;
	public function set target(value) : Void;

	public function get mode() : Object;
	public function set mode(value) : Void;

	public function get percentLoaded() : Object;


	public function ProgressBar();

	public function setProgress(loaded, total);

	public function toString();

	public function configUI();

	public function setPercent(percent);

	public function setUpTarget();

	public function pollTarget();

	public function handleProgress(event);

	public function handleComplete();

}