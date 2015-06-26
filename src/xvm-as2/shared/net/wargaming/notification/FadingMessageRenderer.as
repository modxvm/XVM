intrinsic class net.wargaming.notification.FadingMessageRenderer extends gfx.core.UIComponent
{
	public var _data : Object;
	public var _lifeTime : Object;
	public var _alphaSpeed : Object;
	public var _shown : Object;

	public function get data() : Object;
	public function set data(value) : Void;


	public function FadingMessageRenderer();

	public function setData(data);

	public function startShow();

	public function configUI();

	public function draw();

	public function close();

	public function populateData(initData);

	public function startVisibleLife();

	public function stopVisibleLife();

}