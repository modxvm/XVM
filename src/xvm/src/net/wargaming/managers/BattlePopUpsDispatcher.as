class net.wargaming.managers.BattlePopUpsDispatcher extends net.wargaming.managers.BasePopUpsDispatcher
{
    var ns, context;
    static var __get__instance;
    function BattlePopUpsDispatcher()
    {
        super();
        ns = "battle";
    } // End of the function
    static function get instance()
    {
        if (net.wargaming.managers.BattlePopUpsDispatcher._instance == null)
        {
            _instance = new net.wargaming.managers.BattlePopUpsDispatcher();
        } // end if
        return (net.wargaming.managers.BattlePopUpsDispatcher._instance);
    } // End of the function
    function showMessageDialog()
    {
        super.showMessageDialog.apply(this, arguments);
        this.beforeDialogShow();
    } // End of the function
    function showInformationDialog(dialog, messageEx, command)
    {
        super.showInformationDialog(dialog, messageEx, command);
        this.beforeDialogShow();
    } // End of the function
    function showConfirmDialog(dialog, messageEx, submitCallBack, cancelCallBack)
    {
        super.showConfirmDialog(dialog, messageEx, submitCallBack, cancelCallBack);
        this.beforeDialogShow();
    } // End of the function
    function showVoiceChatInitFailedDialog()
    {
        net.wargaming.notification.MessageDialog.show("voiceChatInitFailed", true, false);
        this.beforeDialogShow();
    } // End of the function
    function showVoiceChatInitSuccededDialog()
    {
    } // End of the function
    function beforeDialogShow()
    {
        var _loc2 = gfx.controls.Dialog.currentDialog;
        if (_loc2 != null && !context.disableShowCursor)
        {
            _loc2.addEventListener("submit", this, "handleCloseDialog");
            _loc2.addEventListener("close", this, "handleCloseDialog");
            context.showCursor();
            context.disableShowCursor = true;
        } // end if
    } // End of the function
    function handleCloseDialog()
    {
        context.disableShowCursor = false;
        context.hideCursor();
    } // End of the function
    static var _instance = net.wargaming.managers.BattlePopUpsDispatcher.__get__instance();
} // End of Class
