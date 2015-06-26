intrinsic class gfx.controls.ButtonBar extends gfx.core.UIComponent
{
	public var renderers : Object;
	public var _itemRenderer : Object;
	public var _spacing : Object;
	public var _direction : Object;
	public var _selectedIndex : Object;
	public var _autoSize : Object;
	public var _buttonWidth : Object;
	public var _labelField : Object;
	public var reflowing : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;

	public function get itemRenderer() : Object;
	public function set itemRenderer(value) : Void;

	public function get spacing() : Object;
	public function set spacing(value) : Void;

	public function get direction() : Object;
	public function set direction(value) : Void;

	public function get autoSize() : Object;
	public function set autoSize(value) : Void;

	public function get buttonWidth() : Object;
	public function set buttonWidth(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get selectedItem() : Object;

	public function get data() : Object;

	public function get labelField() : Object;
	public function set labelField(value) : Void;

	public function get labelFunction() : Object;
	public function set labelFunction(value) : Void;


	public function ButtonBar();

	public function itemToLabel(item);

	public function handleInput(details, pathToFocus);

	public function toString();

	public function draw();

	public function drawLayout();

	public function createRenderer(index);

	public function handleItemClick(event);

	public function selectItem(index);

	public function changeFocus();

}