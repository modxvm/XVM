intrinsic class net.wargaming.managers.BattlePopUpsDispatcher extends net.wargaming.managers.BasePopUpsDispatcher
{
	public var ns : Object;
	static public var __get__instance : Object;
	static public var _instance : Object;
	static public var REPLAY_DIALOG : Object;

	static public function get instance() : Object;


	public function BattlePopUpsDispatcher();

	public function showMessageDialog();

	public function showInformationDialog(dialog, messageEx, command);

	public function informationDialog(dialog, messageEx, command);

	public function showConfirmDialog(dialog, messageEx, submitCallBack, cancelCallBack);

	public function showVoiceChatInitFailedDialog();

	public function showVoiceChatInitSuccededDialog();

	public function beforeDialogShow();

	public function handleCloseDialog();

}