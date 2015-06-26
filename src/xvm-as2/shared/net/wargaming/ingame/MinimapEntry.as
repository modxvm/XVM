intrinsic class net.wargaming.ingame.MinimapEntry extends gfx.core.UIComponent
{
	public var hover : Object;
	static public var showVehicleNames : Object;
	public var m_type : Object;
	public var _vehicleName : Object;
	public var entryName : Object;
	public var vehicleClass : Object;
	public var markLabel : Object;
	public var isTeamKiller : Object;
	public var isDead : Object;
	public var isDeadPermanent : Object;
	public var isPostmortem : Object;
	public var isMarketLit : Object;
	static public var ms_lastLitEntry : Object;
	public var playingTimeoutId : Object;
	static public var isDebug : Object;
	public var _needInitSector : Object;

	public function get colorsManager() : Object;

	public function get colorSchemeName() : Object;

	public function get vehicleNameTextField() : Object;


	public function MinimapEntry();

	public function configUI();

	public function init(markerType, entryName, vehicleClass, markLabel, vehicleName);

	public function showAction(markLabel);

	public function showCameraDirectionLine();

	public function hideCameraDirectionLine();

	public function update();

	public function lightPlayer(visibility);

	public function playPlayer();

	static public function unhighlightLastEntry();

	public function getTextColorSchemeName();

	public function setEntryName(value);

	public function setVehicleClass(value);

	public function setDead(isPermanent);

	public function setPostmortem(isPostmortem);

	public function isTeamPoint();

	public function isFlagPoint();

	public function isRepairPoint();

	public function isResourcePoint();

	public function isBackMarker();

	public function isFortConsumables();

	public function updateType();

	public function showSector(deg1, deg2);

	public function hideSector();

	public function updateIfEntryIsPlayer();

	public function draw();

	public function initSectorLines();

	public function onSectorLine1Loaded();

	public function onSectorLine2Loaded();

	public function onCameraWithDirectionLoaded();

	public function onCameraWithDirectionIOError();

	public function getMinimap();

	public function onEnterFrameHandler();

	public function sectorLineLoaded(sectorLine, deg, callback);

	public function updateLinesScale(parentNormalScale);

	public function checkForSectorLines();

	public function initSectorContent();

	public function updateVehicleName();

	public function setVisible(value);

	public function resumeAnimation();

	public function stopAnimation();

	public function initFlagPoint();

	public function initRepairPoint();

}
