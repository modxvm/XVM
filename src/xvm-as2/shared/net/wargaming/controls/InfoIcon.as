intrinsic class net.wargaming.controls.InfoIcon extends gfx.core.UIComponent
{
	public var _parent : Object;
	static public var TYPE_INFO : Object;
	public var INVALIDATE_ICO : Object;
	static public var CHECK_BOX_MARGIN : Object;
	static public var LABEL_MARGIN : Object;
	public var icoTypeStr : Object;
	public var tooltipStr : Object;

	public function get icoType() : Object;
	public function set icoType(val) : Void;

	public function get tooltip() : Object;
	public function set tooltip(val) : Void;


	public function InfoIcon();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

	public function configUI();

	public function draw();

	public function toString();

}