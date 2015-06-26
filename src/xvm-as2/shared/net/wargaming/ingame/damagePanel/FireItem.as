intrinsic class net.wargaming.ingame.damagePanel.FireItem extends gfx.core.UIComponent
{
	public var onPress : Object;
	public var _state : Object;

	public function FireItem();

	public function reset();

	public function activate(value);

	public function configUI();

	public function setState(state);

	public function handleMousePress(mouseIndex, button);

}