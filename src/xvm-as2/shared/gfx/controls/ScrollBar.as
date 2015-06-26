intrinsic class gfx.controls.ScrollBar extends gfx.controls.ScrollIndicator
{
	public var _disabled : Object;
	public var trackScrollPageSize : Object;
	public var _trackMode : Object;
	public var trackScrollPosition : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get position() : Object;
	public function set position(value) : Void;

	public function get trackMode() : Object;
	public function set trackMode(value) : Void;

	public function get availableHeight() : Object;


	public function ScrollBar();

	public function toString();

	public function configUI();

	public function draw();

	public function updateThumb();

	public function scrollUp();

	public function scrollDown();

	public function beginDrag();

	public function doDrag();

	public function endDrag();

	public function beginTrackScroll(e);

	public function trackScroll();

	public function updateScrollTarget();

	public function scrollWheel(delta);

}