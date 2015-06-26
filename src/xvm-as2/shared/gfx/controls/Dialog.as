intrinsic class gfx.controls.Dialog extends gfx.core.UIComponent
{
	public var _name : Object;
	static public var currentDialog : Object;
	static public var open : Object;

	public function Dialog();

	static public function show(context, linkage, props, modal);

	static public function hide();

	static public function closeDialog(event);

	static public function blockInteraction();

	public function toString();

	public function configUI();

	public function populateUI();

	public function handleClose(event);

	public function handleSubmit(event);

	public function getSubmitData();

}