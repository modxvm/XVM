intrinsic class net.wargaming.controls.SliderStepper extends net.wargaming.controls.Slider
{
	public var __set__dataProvider : Object;

	public function get labelField() : Object;
	public function set labelField(val) : Void;

	public function get valuesField() : Object;
	public function set valuesField(val) : Void;

	public function get dataProvider() : Object;
	public function set dataProvider(value) : Void;

	public function get selectedIndex() : Object;
	public function set selectedIndex(val) : Void;

	public function get labelID() : Object;
	public function set labelID(value) : Void;

	public function get activeIds() : Object;
	public function set activeIds(value) : Void;

	public function get useScrollWheel() : Object;
	public function set useScrollWheel(value) : Void;

	public function get activeInvert() : Object;
	public function set activeInvert(value) : Void;

	public function get label() : Object;
	public function set label(value) : Void;

	public function get value() : Object;
	public function set value(val) : Void;


	public function SliderStepper();

	public function configUI();

	public function invalidateData();

	public function draw();

	public function populateData(data);

	public function setData(data);

	public function clearData();

	public function onPointOver(ev);

	public function onPointOut(ev);

	public function onPointPress(ev);

	public function onDataChange(event);

	public function updateLabel();

	public function doDrag();

	public function scrollWheel(delta);

	public function trackPress(e);

	public function handleInput(details, pathToFocus);

	public function getIsActiveStep(stepNum);

	public function invalidActiveValue();

	public function invalidateValue();

	public function updateValuesLabel(dataItem);

}