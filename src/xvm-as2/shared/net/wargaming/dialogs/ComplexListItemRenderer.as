intrinsic class net.wargaming.dialogs.ComplexListItemRenderer extends gfx.controls.ListItemRenderer
{
	public var getNextHighestDepth : Object;
	public var _itemRenderer : Object;
	public var renderersArr : Object;
	public var eventLengs : Object;

	public function ComplexListItemRenderer();

	public function configUI();

	public function getRenderers();

	public function setData(data);

	public function createItemRenderers(length);

	public function createItemRenderer(index);

	public function updateHandler(even);

	public function drawLayout();

	public function draw();

	public function setSize(width, height);

}