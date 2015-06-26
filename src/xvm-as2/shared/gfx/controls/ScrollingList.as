intrinsic class gfx.controls.ScrollingList extends gfx.controls.CoreList
{
	public var _scrollBar : Object;
	public var wrapping : Object;
	public var autoRowCount : Object;
	public var _scrollPosition : Object;
	public var totalRenderers : Object;
	public var autoScrollBar : Object;
	public var margin : Object;
	public var paddingTop : Object;
	public var paddingBottom : Object;
	public var paddingLeft : Object;
	public var paddingRight : Object;
	public var thumbOffsetTop : Object;
	public var thumbOffsetBottom : Object;
	public var thumbSizeFactor : Object;

	public function get scrollBar() : Object;
	public function set scrollBar(value) : Void;

	public function get rowHeight() : Object;
	public function set rowHeight(value) : Void;

	public function get scrollPosition() : Object;
	public function set scrollPosition(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get rowCount() : Object;
	public function set rowCount(value) : Void;

	public function get availableWidth() : Object;


	public function ScrollingList();

	public function scrollToIndex(index);

	public function invalidateData();

	public function handleInput(details, pathToFocus);

	public function toString();

	public function configUI();

	public function draw();

	public function drawLayout(rendererWidth, rendererHeight);

	public function drawScrollBar();

	public function changeFocus();

	public function populateData(data);

	public function handleScroll(event);

	public function updateScrollBar();

	public function getRendererAt(index);

	public function scrollWheel(delta);

	public function setState();

}