intrinsic class net.wargaming.ingame.Minimap extends net.wargaming.ingame.base.MinimapEntity
{
	public var foregroundHR : Object;
	public var onSizeChangeCallback : Object;
	public var _markersInvalid : Object;
	public var m_sizeIndex : Object;
	static public var MINIMAP_SIZE : Object;
	static public var MINIMAP_STEP : Object;
	static public var TEXT_CORN_OFFSET : Object;
	static public var CELLS_COUNT : Object;
	static public var MARKERS_SCALING : Object;
	static public var NORMAL_LEADING : Object;
	static public var MNP_SIZE_UP : Object;
	static public var MNP_SIZE_DOWN : Object;
	static public var MNP_VISIBLE : Object;
	static public var MNP_SETUP_SIZE : Object;
	static public var MNP_SETUP_ALPHA : Object;
	static public var MNP_ENTRY_INITED : Object;
	static public var MNP_SET_SHOW_VEHICLE_NAME : Object;
	static public var CTRLR_SETSIZE_METHOD : Object;
	static public var CTRLR_ONCLICK_METHOD : Object;
	static public var CTRLR_SCALE_MARKERS : Object;

	public function get foregroundVisibleWidth() : Object;

	public function get foregroundVisibleHeight() : Object;


	public function Minimap();

	public function configUI();

	public function onSetShowVehicleName(visibility);

	public function normalizeTextFieldScaling(textField);

	public function draw();

	public function scaleMarkers(percent);

	public function updateContent();

	public function getRowsNames();

	public function updateColsNames(colsNamesXOffset, colsNamesYOffset, colsNamesWidth, size);

	public function updateRowsNames();

	public function zoomIsNormal();

	public function initRowsNames();

	public function updateContentBeforeDraw(leftBorderSpace, topBorderSpace, rightBorderSpace, bottomBorderSpace);

	public function defaultScaleSprite(destinationSprite, ethaloneSprite);

	public function updatePlayerMessangersPanel();

	public function setupSize(size, stageHeight, stageWidth);

	public function setupAlpha(mAlpha);

	public function correctSizeIndex(sizeIndex, stageHeight, stageWidth);

	public function sizeUp();

	public function onEntryInited();

	public function sizeDown();

	public function invalidateMarkers();

	public function setVisible();

	public function onRecreateDevice(width, height, left, top);

	public function onMouseDown(button, target, mouseIdx, x, y, dblClick);

}