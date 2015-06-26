intrinsic class net.wargaming.ingame.VehicleActionMarker extends gfx.core.UIComponent
{
	public var currentRenderer : Object;
	public var _actionRendererMap : Object;

	public function VehicleActionMarker();

	public function showAction(actionName);

	public function isPlaying();

	public function stopAction();

	public function configUI();

	public function removeActionRenderer();

	public function createActionRenderer(itemRenderer);

}