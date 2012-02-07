class net.wargaming.managers.BasePopUpsDispatcher
{
    var context;
    function BasePopUpsDispatcher()
    {
        super();
    } // End of the function
    function initialize(context)
    {
        this.context = context;
        gfx.io.GameDelegate.addCallBack(ns + ".showMessageDialog", this, "showMessageDialog");
        gfx.io.GameDelegate.addCallBack(ns + ".showInformationDialog", this, "showInformationDialog");
        gfx.io.GameDelegate.addCallBack(ns + ".showConfirmDialog", this, "showConfirmDialog");
        gfx.io.GameDelegate.addCallBack("VoiceChat.initFailed", this, "showVoiceChatInitFailedDialog");
        gfx.io.GameDelegate.addCallBack("VoiceChat.initSucceded", this, "showVoiceChatInitSuccededDialog");
    } // End of the function
    function showMessageDialog()
    {
        if (gfx.controls.Dialog.currentDialog != null && gfx.controls.Dialog.currentDialog.lockMsgDialog)
        {
            pendingMsgDialogArgs = arguments.slice(0);
            return;
        } // end if
        var _loc4 = String(arguments.shift());
        var _loc5 = Boolean(arguments.shift());
        var _loc6 = Boolean(arguments.shift());
        var _loc3 = arguments.shift().toString();
        var submitDataHolder = {command: arguments.shift(), data: arguments.slice(0)};
        _loc4 = net.wargaming.notification.MessageDialog.show(_loc4, _loc5, _loc6);
        if (_loc3 != null && _loc3.length > 0)
        {
            _loc4.message = _loc3;
        } // end if
        _loc4.getSubmitData = function ()
        {
            return (submitDataHolder);
        };
        _loc4.addEventListener("submit", this, "onSubmitDataFromMessageDialog");
    } // End of the function
    function showInformationDialog(dialog, messageEx, command)
    {
        dialog = net.wargaming.notification.MessageDialog.show(dialog, false, false);
        if (messageEx != null && messageEx.length > 0)
        {
            dialog.message = messageEx;
        } // end if
        if (command != null && command.length > 0)
        {
            dialog.addEventListener("close", function (event)
            {
                gfx.io.GameDelegate.call(command, []);
            });
        } // end if
    } // End of the function
    function showConfirmDialog(dialog, customMessage, submitCallBack, cancelCallBack)
    {
        dialog = net.wargaming.notification.MessageDialog.show(dialog, true, true);
        if (customMessage != null && customMessage.length > 0)
        {
            dialog.message = customMessage;
        } // end if
        dialog.addEventListener("submit", function (event)
        {
            gfx.io.GameDelegate.call(submitCallBack, []);
        });
        dialog.addEventListener("close", function (event)
        {
            gfx.io.GameDelegate.call(cancelCallBack, []);
        });
    } // End of the function
    function showVoiceChatInitFailedDialog()
    {
        net.wargaming.notification.MessageDialog.show("voiceChatInitFailed", true, false);
    } // End of the function
    function showVoiceChatInitSuccededDialog()
    {
        net.wargaming.notification.MessageDialog.show("voiceChatInitSucceded", true, false);
    } // End of the function
    function showPendingMsgDialog()
    {
        if (pendingMsgDialogArgs.length > 0)
        {
            showMessageDialog.apply(this, pendingMsgDialogArgs);
            pendingMsgDialogArgs = [];
        } // end if
    } // End of the function
    function onSubmitDataFromMessageDialog(event)
    {
        var _loc1 = event.data;
        var _loc2 = _loc1.command;
        if (_loc2.length > 0)
        {
            gfx.io.GameDelegate.call(_loc2, _loc1.data);
        } // end if
    } // End of the function
    var ns = "base";
    var pendingMsgDialogArgs = [];
} // End of Class
