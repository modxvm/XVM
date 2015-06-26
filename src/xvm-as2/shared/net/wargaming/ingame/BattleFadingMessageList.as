intrinsic class net.wargaming.ingame.BattleFadingMessageList extends net.wargaming.notification.FadingMessageList
{
	public var _renderersCollection : Object;
	public var _renderersColorMap : Object;
	public var _defaultRenderer : Object;
	public var _externalPrefix : Object;
	public var _showUniqueOnly : Object;

	public function get renderersCollection() : Object;
	public function set renderersCollection(collection) : Void;

	public function get externalPrefix() : Object;
	public function set externalPrefix(value) : Void;


	public function BattleFadingMessageList();

	public function configUI();

	public function buildRendererMap();

	public function getItemRenderer(messageData);

	public function onRefreshUI();

	public function onClear();

	public function onPopulateUI(maxLinesCount, direction, lifeTime, alphaSpeed, showUniqueOnly);

	public function onShowMessage(key, message, color);

}