intrinsic class net.wargaming.controls.HelpLayout extends gfx.core.UIComponent
{
	public var _yscale : Object;
	static public var modalBackground : Object;
	public var _text : Object;
	public var _direction : Object;
	public var _borderWidth : Object;
	public var _borderHeight : Object;
	public var _connectorLength : Object;
	static public var hlMainSource : Object;
	static public var hlBorderSource : Object;
	static public var hlConnectorSource : Object;

	public function HelpLayout();

	static public function create(context, initProperties, relativeTo);

	static public function createBackground(context);

	static public function destroy(helpLayout);

	static public function destroyBackground();

	public function configUI();

	public function draw();

	public function setConnectorPosition();

	public function setTextFieldPosition();

}