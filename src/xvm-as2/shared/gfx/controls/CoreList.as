intrinsic class gfx.controls.CoreList extends gfx.core.UIComponent
{
	public var renderers : Object;
	public var _itemRenderer : Object;
	public var _selectedIndex : Object;
	public var _labelField : Object;
	public var externalRenderers : Object;
	public var deferredScrollIndex : Object;

	public function get itemRenderer() : Object;
	public function set itemRenderer(value) : Void;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get labelField() : Object;
	public function set labelField(value) : Void;

	public function get labelFunction() : Object;
	public function set labelFunction(value) : Void;

	public function get availableWidth() : Object;

	public function get availableHeight() : Object;

	public function get rendererInstanceName() : Object;
	public function set rendererInstanceName(value) : Void;


	public function CoreList();

	public function scrollToIndex(index);

	public function itemToLabel(item);

	public function invalidateData();

	public function setRendererList(value);

	public function toString();

	public function configUI();

	public function createItemRenderer(index);

	public function setUpRenderer(clip);

	public function createItemRenderers(startIndex, endIndex);

	public function draw();

	public function drawRenderers(totalRenderers);

	public function getRendererAt(index);

	public function resetRenderers();

	public function drawLayout(rendererWidth, rendererHeight);

	public function onDataChange(event);

	public function dispatchItemEvent(event);

	public function handleItemClick(event);

}