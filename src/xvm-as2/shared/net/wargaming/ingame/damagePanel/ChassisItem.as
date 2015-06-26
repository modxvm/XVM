intrinsic class net.wargaming.ingame.damagePanel.ChassisItem extends net.wargaming.ingame.damagePanel.EntityItem
{
	public var trackStates : Object;
	public var deviceName : Object;

	public function ChassisItem();

	public function invalidateData(entityName, state, forced);

	public function configUI();

	public function handleDamageIconClick(entityName, entityState);

}