intrinsic class gfx.controls.ScrollIndicator extends gfx.core.UIComponent
{
	public var tabChildren : Object;
	public var direction : Object;
	public var minPosition : Object;
	public var maxPosition : Object;
	public var _position : Object;
	public var offsetTop : Object;
	public var offsetBottom : Object;
	public var isDragging : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get position() : Object;
	public function set position(value) : Void;

	public function get scrollTarget() : Object;
	public function set scrollTarget(value) : Void;

	public function get availableHeight() : Object;


	public function ScrollIndicator();

	public function setScrollProperties(pageSize, minPosition, maxPosition, pageScrollSize);

	public function update();

	public function toString();

	public function configUI();

	public function draw();

	public function updateThumb();

	public function onScroller();

	public function scrollerDelayUpdate();

}