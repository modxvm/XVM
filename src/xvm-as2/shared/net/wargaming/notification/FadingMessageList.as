intrinsic class net.wargaming.notification.FadingMessageList extends gfx.core.UIComponent
{
	public var _itemRenderer : Object;
	public var _stackLength : Object;
	public var _direction : Object;
	public var _lifeTime : Object;
	public var _alphaSpeed : Object;

	public function get stackLength() : Object;
	public function set stackLength(value) : Void;

	public function get direction() : Object;
	public function set direction(value) : Void;

	public function get messageLifeTime() : Object;
	public function set messageLifeTime(value) : Void;

	public function get messageAlphaSpeed() : Object;
	public function set messageAlphaSpeed(value) : Void;


	public function FadingMessageList();

	public function pushMessage(messageData);

	public function clear();

	public function configUI();

	public function draw();

	public function getItemRenderer(messageData);

	public function createItemRenderer(messageData, index);

	public function onDrawRenderer(event);

}
