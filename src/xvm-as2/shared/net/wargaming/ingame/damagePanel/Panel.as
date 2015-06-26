intrinsic class net.wargaming.ingame.damagePanel.Panel extends MovieClip
{
	public var tankIndicator : Object;
	public var _maxHealth : Object;
	public var _deviceNames : Object;
	public var _isAutoRotationEnabled : Object;
	public var crewRenderers : Object;
	public var _crewItemMargin : Object;
	public var _crewItemWidth : Object;
	public var _crewTotalWidth : Object;
	static public var toolTip : Object;

	public function get deviceNames() : Object;


	public function Panel();

	public function clickToDeviceIcon(value);

	public function clickToTankmanIcon(value);

	public function clickToFireIcon();

	public function as_setup(health, indicatorType, crewLayout, yawLimits, hasTurretRotator, isAutoRotationOn);

	public function as_updateDeviceState(entityName, state);

	public function as_updateHealth(current);

	public function as_updateRepairingDevice(entityName, progress, secondsLeft);

	public function as_setPlayerInfo(fullName, playerName, clanName, regionName, vehicleTypeName);

	public function as_setCruiseMode(mode);

	public function as_updateSpeed(speed);

	public function as_setCrewDeactivated();

	public function as_setVehicleDestroyed();

	public function as_setFireInVehicle(bool);

	public function as_setAutoRotation(value);

	public function as_show(isShow);

	public function as_destroy();

	public function as_reset();

	public function onLoad();

	public function updateAllStates(state, forced);

	public function createMapping();

	public function doUpdateEntityState(entityName, state, forced);

	public function createCrewRenderers(names);

	public function removeCrewRenderers(names);

	public function createCrewRenderer(symbol, name, index);

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

}