intrinsic class net.wargaming.notification.DelayedMessageDialog extends net.wargaming.notification.MessageDialog
{
	public var delayBtn : Object;
	static public var messageDialogSource : Object;
	static public var showDelay : Object;

	public function DelayedMessageDialog();

	static public function show(dialog, focusSubmit, _showDelay);

	static public function closeDialog(event);

	public function configUI();

	public function populateUI();

	public function handleDelay(event);

}