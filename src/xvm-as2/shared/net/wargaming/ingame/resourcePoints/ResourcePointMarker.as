intrinsic class net.wargaming.ingame.resourcePoints.ResourcePointMarker extends MovieClip
{
	public var marker : Object;
	public var _isLoaded : Object;
	public var _pointIdx : Object;
	public var _state : Object;
	public var _progress : Object;

	public function ResourcePointMarker();

	public function onLoad();

	public function as_init(pointIdx, newState, progress);

	public function as_setState(newState);

	public function setState(newState);

	public function as_setProgress(value);

	public function setProgress(value);

	public function as_onSettingsChanged();

}