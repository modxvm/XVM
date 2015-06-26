intrinsic class net.wargaming.managers.BasePopUpsDispatcher
{
	public var context : Object;
	public var ns : Object;
	public var pendingMsgDialogArgs : Object;

	public function BasePopUpsDispatcher();

	public function initialize(context);

	public function showMessageDialog();

	public function showInformationDialog(dialog, messageEx, command);

	public function showConfirmDialog(dialog, customMessage, submitCallBack, cancelCallBack);

	public function showVoiceChatInitFailedDialog();

	public function showVoiceChatInitSuccededDialog();

	public function showPendingMsgDialog();

	public function onSubmitDataFromMessageDialog(event);

}