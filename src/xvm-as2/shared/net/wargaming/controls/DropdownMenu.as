intrinsic class net.wargaming.controls.DropdownMenu extends gfx.controls.DropdownMenu
{
	public var hit_mc : Object;
	public var soundType : Object;
	public var soundId : Object;

	public function get disabled() : Object;
	public function set disabled(value) : Void;

	public function get useHTML() : Object;
	public function set useHTML(value) : Void;

	public function get label() : Object;
	public function set label(value) : Void;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;


	public function DropdownMenu();

	public function scrollWheel(delta);

	public function createDropDown();

	public function configUI();

	public function updateAfterStateChange();

	public function onSoundOver(e);

	public function onSoundOut(e);

	public function onSoundPress(e);

	public function playSound(state);

	public function createNationFilter(natData);

	public function setStaticData(dataArray);

	public function setProp(prop);

}