intrinsic class gfx.controls.ButtonGroup extends gfx.events.EventDispatcher
{
	public var scope : Object;
	public var name : Object;

	public function get length() : Object;

	public function get data() : Object;


	public function ButtonGroup(name, scope);

	public function addButton(button);

	public function removeButton(button);

	public function indexOf(button);

	public function getButtonAt(index);

	public function setSelectedButton(button);

	public function toString();

	public function handleSelect(event);

	public function handleClick(event);

}