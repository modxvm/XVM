intrinsic class net.wargaming.ingame.PlayersPanelTypeButton extends gfx.controls.Button
{
	public var addEventListener : Object;

	public function get type() : Object;
	public function set type(value) : Void;

	public function get tooltip() : Object;
	public function set tooltip(value) : Void;


	public function PlayersPanelTypeButton();

	public function configUI();

	public function showTooltip();

	public function hideTooltip();

}