intrinsic class net.wargaming.controls.buttons.ContentTabBar extends net.wargaming.controls.ButtonBarEx
{
	public var reflowing : Object;
	static public var INVALID_LAYOUT : Object;
	static public var INVALID_SEPARATOR_VISIBLE : Object;
	static public var INVALID_RENDERERS : Object;
	public var _minRendererWidth : Object;
	public var _showSeparator : Object;
	public var _centerTabs : Object;

	public function set dataProvider(value) : Void;

	public function set selectedIndex(value) : Void;

	public function get minRendererWidth() : Object;
	public function set minRendererWidth(value) : Void;

	public function get showSeparator() : Object;
	public function set showSeparator(value) : Void;

	public function get centerTabs() : Object;
	public function set centerTabs(value) : Void;


	public function ContentTabBar();

	public function configUI();

	public function initSelectedIndex();

	public function draw();

	public function drawLayout();

	public function populateRenderer(i);

	public function createRenderer(index);

	public function doCenterTabs();

	public function updateSelectionIndicator();

	public function calculateRendererWidth();

	public function toString();

}