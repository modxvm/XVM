intrinsic class net.wargaming.Dialog extends gfx.controls.Dialog
{
	public var dispatchEvent : Object;
	static public var nextDialogArgs : Object;
	static public var reopenDialogFuncs : Object;
	static public var stageWidth : Object;
	static public var stageHeight : Object;
	public var enableEscapeHandle : Object;
	public var mustReopen : Object;

	public function Dialog();

	static public function show(context, linkage, props, modal, store);

	static public function hide();

	static public function rebuildWithCurrentSize();

	static public function rebuild(w, h);

	static public function showNextDialog();

	public function handleInput(details, pathToFocus);

	public function dialogIsCreated();

	public function dialogDispose();

}