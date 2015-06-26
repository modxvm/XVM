intrinsic class net.wargaming.ingame.StaticObjectMarker extends gfx.core.UIComponent
{
	public var initialized : Object;
	public var shapeName : Object;
	public var minDistance : Object;
	public var aplhaZone : Object;
	public var distance : Object;
	public var isHide : Object;
	public var isShow : Object;
	static public var APLHA_SPEED : Object;

	public function StaticObjectMarker();

	public function init(shape, minDistance, maxDistance, distance);

	public function setDistance(value);

	public function configUI();

	public function setInitialAlpha(value);

	public function doAlphaAnimation(value);

	public function setDistanceText(value);

}