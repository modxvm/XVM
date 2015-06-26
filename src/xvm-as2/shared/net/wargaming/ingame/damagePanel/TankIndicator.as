intrinsic class net.wargaming.ingame.damagePanel.TankIndicator extends MovieClip
{
	public var _deviceStates : Object;
	public var _indicatorType : Object;

	public function TankIndicator();

	public function setup(indicatorType, yawLimits);

	public function updateState(entityName, state);

	public function updateAllStates(state);

	public function setGunConstraints(yawLimits);

	public function setVehicleDestroyed();

	public function reset();

	public function onArrivedConstraint(bool);

}