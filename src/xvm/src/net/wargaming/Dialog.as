class net.wargaming.Dialog extends gfx.controls.Dialog
{
    var dispatchEvent;
    function Dialog()
    {
        super();
    } // End of the function
    static function show(context, linkage, props, modal, store)
    {
        if (gfx.controls.Dialog.open && store)
        {
            net.wargaming.Dialog.nextDialogArgs.push(arguments.slice(0));
            return (null);
        } // end if
        if (gfx.controls.Dialog.currentDialog != null && gfx.controls.Dialog.currentDialog.mustReopen && gfx.controls.Dialog.currentDialog.getReopenCallerObject)
        {
            net.wargaming.Dialog.reopenDialogFuncs.push(gfx.controls.Dialog.currentDialog.getReopenCallerObject());
        } // end if
        var _loc2 = gfx.controls.Dialog.show(context, linkage, props, modal);
        _loc2.addEventListener("close", net.wargaming.Dialog, "showNextDialog");
        _loc2.addEventListener("submit", net.wargaming.Dialog, "showNextDialog");
        net.wargaming.Dialog.rebuild(Stage.width, Stage.height);
        return (_loc2);
    } // End of the function
    static function rebuild(w, h)
    {
        if (gfx.controls.Dialog.currentDialog != null)
        {
            gfx.controls.Dialog.currentDialog.modalBackground._width = w;
            gfx.controls.Dialog.currentDialog.modalBackground._height = h;
            if (Stage.align == "TL" || Stage.align == "LT")
            {
                gfx.controls.Dialog.currentDialog._x = w - gfx.controls.Dialog.currentDialog._width >> 1;
                gfx.controls.Dialog.currentDialog._y = h - gfx.controls.Dialog.currentDialog._height >> 1;
            }
            else
            {
                gfx.controls.Dialog.currentDialog.modalBackground._x = 1024 - w >> 1;
                gfx.controls.Dialog.currentDialog.modalBackground._y = 768 - h >> 1;
                gfx.controls.Dialog.currentDialog._x = Math.round((1024 - gfx.controls.Dialog.currentDialog._width) / 2);
                gfx.controls.Dialog.currentDialog._y = Math.round((768 - gfx.controls.Dialog.currentDialog._height) / 2);
            } // end if
        } // end else if
    } // End of the function
    static function showNextDialog()
    {
        if (net.wargaming.Dialog.nextDialogArgs.length > 0)
        {
            var _loc2 = Array(net.wargaming.Dialog.nextDialogArgs.shift())[0];
            net.wargaming.Dialog.show.apply(net.wargaming.Dialog, _loc2);
        }
        else if (net.wargaming.Dialog.reopenDialogFuncs.length > 0)
        {
            var _loc1 = net.wargaming.Dialog.reopenDialogFuncs.pop();
            _loc1.scope[_loc1.method]();
        } // end else if
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        switch (details.navEquivalent)
        {
            case gfx.ui.NavigationCode.ESCAPE:
            {
                if (enableEscapeHandle && details.value == "keyDown")
                {
                    this.dispatchEvent({type: "close"});
                } // end if
                return (true);
            } 
        } // End of switch
        return (super.handleInput(details, pathToFocus));
    } // End of the function
    static var nextDialogArgs = [];
    static var reopenDialogFuncs = [];
    var enableEscapeHandle = true;
    var mustReopen = false;
} // End of Class
