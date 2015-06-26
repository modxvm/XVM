intrinsic class gfx.controls.TileList extends gfx.controls.CoreList
{
	public var _scrollBar : Object;
	public var wrapping : Object;
	public var autoRowCount : Object;
	public var _direction : Object;
	public var _scrollPosition : Object;
	public var totalRows : Object;
	public var totalColumns : Object;
	public var autoScrollBar : Object;
	public var externalColumnCount : Object;
	public var margin : Object;

	public function get scrollBar() : Object;
	public function set scrollBar(value) : Void;

	public function get rowHeight() : Object;
	public function set rowHeight(value) : Void;

	public function get columnWidth() : Object;
	public function set columnWidth(value) : Void;

	public function get rowCount() : Object;
	public function set rowCount(value) : Void;

	public function get columnCount() : Object;
	public function set columnCount(value) : Void;

	public function get direction() : Object;
	public function set direction(value) : Void;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get scrollPosition() : Object;
	public function set scrollPosition(value) : Void;

	public function get availableWidth() : Object;

	public function get availableHeight() : Object;


	public function TileList();

	public function scrollToIndex(index);

	public function invalidateData();

	public function setRendererList(value, newColumnCount);

	public function handleInput(details, pathToFocus);

	public function toString();

	public function configUI();

	public function draw();

	public function drawLayout(rendererWidth, rendererHeight);

	public function changeFocus();

	public function populateData(data);

	public function getRendererAt(index);

	public function handleScroll(event);

	public function drawScrollBar();

	public function updateScrollBar();

	public function scrollWheel(delta);

	public function setState();

}