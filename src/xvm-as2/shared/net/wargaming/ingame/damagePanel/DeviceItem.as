intrinsic class net.wargaming.ingame.damagePanel.DeviceItem extends net.wargaming.ingame.damagePanel.EntityItem
{
	public var m_entityName : Object;
	public var deviceName : Object;

	public function DeviceItem();

	public function configUI();

	public function handleDamageIconClick(entityName, entityState);

}