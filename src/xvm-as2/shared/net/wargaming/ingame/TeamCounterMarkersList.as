intrinsic class net.wargaming.ingame.TeamCounterMarkersList extends gfx.core.UIComponent
{
	public var vIdToRenderer : Object;
	static public var ALIGN_LEFT : Object;
	static public var ALIGN_RIGHT : Object;
	public var _itemRenderer : Object;
	public var _align : Object;
	public var _markerType : Object;
	public var _gap : Object;
	public var reflowing : Object;
	public var _dataProviderDirty : Object;
	public var _initWidth : Object;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;

	public function get align() : Object;

	public function get markerType() : Object;


	public function TeamCounterMarkersList();

	public function clear();

	public function handleInput(details, pathToFocus);

	public function configUI();

	public function cleanupRenderers();

	public function drawRenderers(resetPrevData);

	public function createItemRenderer(data, resetPrevData);

	public function setUpRenderer(clip);

}