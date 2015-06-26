intrinsic class net.wargaming.ingame.ServerInfo extends gfx.core.UIComponent
{
	public var _visible : Object;
	public var tooltipType : Object;
	public var tooltipFullData : Object;
	public var TYPE_UNAVAILABLE : Object;
	public var TYPE_CLUSTER : Object;
	public var TYPE_FULL : Object;
	static public var CURRENT_SERVER_TEXT_COLOR : Object;
	public var sizeIsInvalid : Object;
	public var _relativelyOwner : Object;

	public function get relativelyOwner() : Object;
	public function set relativelyOwner(value) : Void;


	public function ServerInfo();

	public function configUI();

	public function draw();

	public function setValues(statValues);

	public function showPlayersTooltip();

	public function hideTooltip();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

}