intrinsic class net.wargaming.notification.MessageDialog extends net.wargaming.Dialog
{
	public var dragBar : Object;
	static public var messageDialogSource : Object;
	public var sumbitVisible : Object;
	public var focusSubmit : Object;
	public var dragable : Object;
	public var html : Object;

	public function MessageDialog();

	static public function show(dialog, focusSubmit, sumbitVisible, store);

	public function configUI();

	public function draw();

	public function populateUI();

}