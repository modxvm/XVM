intrinsic class net.wargaming.controls.LabelEx extends gfx.controls.Label
{
	public var onRollOver : Object;
	public var _postfix : Object;
	public var _icoPosIsIvalid : Object;
	public var infoIcon : Object;
	public var _showPrefixOnDisableSatate : Object;

	public function get postfix() : Object;
	public function set postfix(value) : Void;

	public function get showPrefixOnDisableSatate() : Object;
	public function set showPrefixOnDisableSatate(value) : Void;

	public function get text() : Object;
	public function set text(value) : Void;

	public function get htmlText() : Object;
	public function set htmlText(value) : Void;

	public function set visible(value) : Void;


	public function LabelEx();

	public function configUI();

	public function updateText();

	public function updateAfterStateChange();

	public function toString();

	public function handleMouseRollOver(mouseIndex);

	public function handleMouseRollOut(mouseIndex);

	public function handleMousePress(mouseIndex, button);

	public function draw();

	public function setIco(val);

	public function updateInfoIcoPosition();

	public function UpdateVisabilityIco();

}