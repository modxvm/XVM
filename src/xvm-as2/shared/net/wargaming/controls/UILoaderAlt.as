intrinsic class net.wargaming.controls.UILoaderAlt extends gfx.controls.UILoader
{
	public var _source : Object;
	public var _sourceAlt : Object;
	public var _loadFailed : Object;
	public var _loading : Object;

	public function get source() : Object;
	public function set source(value) : Void;

	public function get sourceAlt() : Object;
	public function set sourceAlt(value) : Void;


	public function UILoaderAlt();

	public function unload();

	public function setProperties(obj);

	public function toString();

	public function configUI();

	public function onLoadError(target_mc, errorCode, httpStatus);

	public function onLoadComplete();

	public function onLoadInit();

	public function cancel();

}