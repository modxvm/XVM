intrinsic class gfx.controls.UILoader extends gfx.core.UIComponent
{
	public var invalidate : Object;
	public var _maintainAspectRatio : Object;
	public var _autoSize : Object;
	public var _visiblilityBeforeLoad : Object;

	public function get autoSize() : Object;
	public function set autoSize(value) : Void;

	public function get source() : Object;
	public function set source(value) : Void;

	public function get maintainAspectRatio() : Object;
	public function set maintainAspectRatio(value) : Void;

	public function get content() : Object;

	public function get percentLoaded() : Object;


	public function UILoader();

	public function unload();

	public function toString();

	public function configUI();

	public function load(url);

	public function draw();

	public function onLoadError();

	public function onLoadComplete();

	public function checkProgress();

}