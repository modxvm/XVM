intrinsic class net.wargaming.dialogs.SlidingScrollingList extends gfx.controls.ScrollingList
{
	public var useHandCursor : Object;
	public var autoScrollBar : Object;
	public var wasResized : Object;
	public var eventLengs : Object;
	public var downMargin : Object;
	public var wasDrawn : Object;

	public function get visibleHight() : Object;

	public function get availableWidth() : Object;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get scrollPosition() : Object;
	public function set scrollPosition(value) : Void;


	public function SlidingScrollingList();

	public function configUI();

	public function getRenderers();

	public function draw();

	public function drawRenderers(totalRenderers);

	public function drawLayout(rendererWidth);

	public function updateHandler(even);

	public function drawScrollBar();

	public function updateScrollBar();

	public function invalidateData();

	public function populateData(data);

	public function updateRenderes();

	public function handleScroll(event);

	public function scrollWheel(delta);

	public function closedOpenedDD();

	public function handleInput();

}