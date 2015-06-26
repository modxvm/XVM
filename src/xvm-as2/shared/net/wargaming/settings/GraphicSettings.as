intrinsic class net.wargaming.settings.GraphicSettings extends gfx.core.UIComponent
{
	public var graphicsScrollBar : Object;
	public var graphicsPartsStartPos : Object;
	public var graphicsPartsOffsetTop : Object;
	public var graphicsPartsOffsetBottom : Object;

	public function GraphicSettings();

	public function configUI();

	public function onScroll(ev);

	public function onMouseWheel(delta, target);

	public function scrollWheel(delta);

	public function graphicsHeightInvalid();

}