intrinsic class net.wargaming.controls.textlinemoving.TextMovingItem extends gfx.controls.Button
{
	public var useHandCursor : Object;
	public var discription : Object;
	public var _allowClick : Object;

	public function get allowClick() : Object;
	public function set allowClick(val) : Void;

	public function get id() : Object;
	public function set id(val) : Void;


	public function TextMovingItem();

	public function configUI();

	public function draw();

	public function resetState();

	public function handleClick(mouseIndex, button);

	public function handleMouseRollOver(mouseIndex);

	public function handleMousePress(mouseIndex, button);

}