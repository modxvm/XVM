intrinsic class gfx.controls.DropdownMenu extends gfx.controls.Button
{
	public var __set__dataProvider : Object;
	public var isOpen : Object;
	public var direction : Object;
	public var _dropdownWidth : Object;
	public var _rowCount : Object;
	public var _labelField : Object;
	public var _selectedIndex : Object;
	public var margin : Object;
	public var paddingTop : Object;
	public var paddingBottom : Object;
	public var paddingLeft : Object;
	public var paddingRight : Object;
	public var thumbOffsetTop : Object;
	public var thumbOffsetBottom : Object;
	public var thumbSizeFactor : Object;
	public var offsetX : Object;
	public var offsetY : Object;
	public var extent : Object;
	public var _dropdown : Object;

	public function get dropdown() : Object;
	public function set dropdown(value) : Void;

	public function get itemRenderer() : Object;
	public function set itemRenderer(value) : Void;

	public function get scrollBar() : Object;
	public function set scrollBar(value) : Void;

	public function get dropdownWidth() : Object;
	public function set dropdownWidth(value) : Void;

	public function get rowCount() : Object;
	public function set rowCount(value) : Void;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(value) : Void;

	public function get labelField() : Object;
	public function set labelField(value) : Void;

	public function get labelFunction() : Object;
	public function set labelFunction(value) : Void;


	public function DropdownMenu();

	public function itemToLabel(item);

	public function open();

	public function close();

	public function invalidateData();

	public function setSize(width, height);

	public function handleInput(details, pathToFocus);

	public function removeMovieClip();

	public function toString();

	public function createDropDown();

	public function openImpl();

	public function configUI();

	public function changeFocus();

	public function updateSelectedItem();

	public function updateLabel();

	public function populateText(item);

	public function handleChange(event);

	public function onDataChange(event);

	public function toggleMenu(event);

	public function handleStageClick(event);

	public function hitTest(x, y, shapeFlag);

}