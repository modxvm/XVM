intrinsic class net.wargaming.controls.TextInput extends gfx.controls.TextInput
{
	public var textField : Object;
	public var _extractEscapes : Object;

	public function get extractEscapes() : Object;
	public function set extractEscapes(value) : Void;


	public function TextInput();

	public function updateTextField();

	public function onKillFocus();

	public function onSetFocus();

	public function onUnload();

	public function configUI();

	public function onTextChange(args);

}