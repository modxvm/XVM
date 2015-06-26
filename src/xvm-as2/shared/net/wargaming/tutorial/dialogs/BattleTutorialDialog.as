intrinsic class net.wargaming.tutorial.dialogs.BattleTutorialDialog extends net.wargaming.Dialog
{
	public var enableEscapeHandle : Object;

	public function BattleTutorialDialog();

	static public function show(context, source, props);

	public function configUI();

	public function draw();

	public function populateUI();

	public function handleSubmit(event);

	public function handleClose(event);

}