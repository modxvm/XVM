class net.wargaming.notification.MessageDialog extends net.wargaming.Dialog
{
    var _messageType, __get__messageType, dragBar, invalidate, title, message, messageField, submitBtn, submitLabel, cancelLabel, cancelBtn, iconField, __set__messageType;
    function MessageDialog()
    {
        super();
    } // End of the function
    static function show(dialog, focusSubmit, sumbitVisible, store)
    {
        if (dialog == undefined)
        {
            return;
        } // end if
        var _loc3 = {title: "#dialogs:" + dialog + "/title", message: "#dialogs:" + dialog + "/message", submitLabel: "#dialogs:" + dialog + "/submit", cancelLabel: "#dialogs:" + dialog + "/cancel"};
        if (typeof(sumbitVisible) == "boolean")
        {
            _loc3.sumbitVisible = sumbitVisible;
        } // end if
        if (typeof(focusSubmit) == "boolean")
        {
            _loc3.focusSubmit = focusSubmit;
        } // end if
        net.wargaming.managers.ToolTipManager.hide();
        return (net.wargaming.Dialog.show(_root, net.wargaming.notification.MessageDialog.messageDialogSource, _loc3, true, store));
    } // End of the function
    function get messageType()
    {
        return (_messageType);
    } // End of the function
    function set messageType(value)
    {
        if (_messageType == value)
        {
            return;
        } // end if
        _messageType = value;
        //return (this.messageType());
        null;
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (dragBar != null && !dragable)
        {
            dragBar.onPress = function ()
            {
            };
            dragBar.onRelease = function ()
            {
            };
        } // end if
    } // End of the function
    function draw()
    {
        if (dragBar != null && !dragBar.initialized)
        {
            this.invalidate();
            return;
        }
        else
        {
            super.draw();
            if (title.length > 0 && dragBar != null)
            {
                dragBar.textField.text = title;
            } // end if
        } // end else if
    } // End of the function
    function populateUI()
    {
        super.populateUI();
        if (title && dragBar != null)
        {
            dragBar.text = title;
        } // end if
        if (message && messageField != null)
        {
            messageField.html = true;
            messageField.htmlText = message;
        } // end if
        if (submitBtn != null)
        {
            submitBtn.__set__visible(sumbitVisible);
            if (focusSubmit)
            {
                Selection.setFocus(submitBtn);
            } // end if
            if (submitLabel)
            {
                submitBtn.__set__label(submitLabel);
            } // end if
        } // end if
        if (cancelLabel && cancelBtn != null)
        {
            cancelBtn.__set__label(cancelLabel);
        } // end if
        if (iconField != null)
        {
            iconField.gotoAndPlay(_messageType);
        } // end if
    } // End of the function
    static var messageDialogSource = "MessageDialog";
    var sumbitVisible = true;
    var focusSubmit = false;
    var dragable = false;
    var html = false;
} // End of Class
