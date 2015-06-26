intrinsic class net.wargaming.ingame.FlagCTFIndicator extends gfx.core.UIComponent
{
	public var _iconValue : Object;
	public var _labelString : Object;
	public var _cooldownState : Object;
	static public var COOLDOWN_STATE : Object;

	public function FlagCTFIndicator();

	public function setIcon(value);

	public function setLabel(newLabel);

	public function configUI();

	public function updateCooldownVisibility();

	public function updateLabelTF();

}