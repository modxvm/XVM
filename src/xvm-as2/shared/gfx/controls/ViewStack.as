intrinsic class gfx.controls.ViewStack extends gfx.core.UIComponent
{
	public var cachedViews : Object;
	public var cache : Object;
	public var depth : Object;

	public function get targetGroup() : Object;
	public function set targetGroup(value) : Void;


	public function ViewStack();

	public function show(linkage, cache);

	public function precache(linkages);

	public function toString();

	public function configUI();

	public function draw();

	public function createView(linkage, cache);

	public function changeView(event);

}