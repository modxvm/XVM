class net.wargaming.notification.DelayedMessageDialog extends net.wargaming.notification.MessageDialog
{
    var delayBtn, delayLabel, getSubmitData, dispatchEvent;
    function DelayedMessageDialog()
    {
        super();
    } // End of the function
    static function show(dialog, focusSubmit)
    {
        var _loc4 = {title: "#dialogs:" + dialog + "/title", message: "#dialogs:" + dialog + "/message", submitLabel: "#dialogs:" + dialog + "/submit", delayLabel: "#dialogs:" + dialog + "/delay", cancelLabel: "#dialogs:" + dialog + "/cancel"};
        if (typeof(focusSubmit) == "boolean")
        {
            _loc4.focusSubmit = focusSubmit;
        } // end if
        net.wargaming.managers.ToolTipManager.hide();
        var _loc3 = net.wargaming.Dialog.show(_root, net.wargaming.notification.DelayedMessageDialog.messageDialogSource, _loc4, true);
        _loc3.addEventListener("delay", net.wargaming.notification.DelayedMessageDialog, "closeDialog");
        return (_loc3);
    } // End of the function
    static function closeDialog(event)
    {
        gfx.controls.Dialog.hide();
        net.wargaming.Dialog.showNextDialog();
    } // End of the function
    function configUI()
    {
        if (delayBtn != null)
        {
            delayBtn.addEventListener("click", this, "handleDelay");
        } // end if
        super.configUI();
    } // End of the function
    function populateUI()
    {
        super.populateUI();
        if (delayBtn != null)
        {
            if (delayLabel)
            {
                delayBtn.label = delayLabel;
            } // end if
        } // end if
    } // End of the function
    function handleDelay(event)
    {
        this.dispatchEvent({type: "delay", data: this.getSubmitData()});
    } // End of the function
    static var messageDialogSource = "DelayedMessageDialog";
} // End of Class
