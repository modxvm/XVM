intrinsic class net.wargaming.ingame.RepairPointIndicator extends gfx.core.UIComponent
{
	public var _iconValue : Object;
	public var _labelString : Object;
	static public var STATE_COOLDOWN : Object;
	static public var STATE_ACTIVE : Object;

	public function RepairPointIndicator();

	public function setIcon(value);

	public function setLabel(newLabel);

	public function configUI();

	public function applyIcon();

}