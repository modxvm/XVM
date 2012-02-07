class gfx.controls.Dialog extends gfx.core.UIComponent
{
    var _name, closeBtn, cancelBtn, submitBtn, dragBar, startDrag, stopDrag, dispatchEvent;
    static var currentDialog;
    function Dialog()
    {
        super();
    } // End of the function
    static function show(context, linkage, props, modal)
    {
        gfx.controls.Dialog.hide();
        if (modal)
        {
            var _loc1 = gfx.managers.PopUpManager.createPopUp(context, "PopUpModal", {_x: 0, _y: 0}, _level0);
            if (_loc1 != null)
            {
                _loc1._width = Stage.width;
                _loc1._height = Stage.height;
                _loc1.tabEnabled = false;
                _loc1.useHandCursor = false;
                _loc1.onRelease = gfx.controls.Dialog.blockInteraction;
            } // end if
        } // end if
        var _loc2 = gfx.managers.PopUpManager.createPopUp(context, linkage, props, _level0);
        if (_loc2 == null)
        {
            if (_loc1 != null)
            {
                _loc1.removeMovieClip();
            } // end if
            return (null);
        } // end if
        currentDialog = _loc2;
        _loc2.modalBackground = _loc1;
        gfx.managers.PopUpManager.centerPopUp(_loc2);
		/* fix decompiler errors (sirmax2)
        Selection.modalClip = _loc2;
		*/
        _loc2.addEventListener("close", gfx.controls.Dialog, "closeDialog");
        _loc2.addEventListener("submit", gfx.controls.Dialog, "closeDialog");
        open = true;
        return (_loc2);
    } // End of the function
    static function hide()
    {
		/* fix decompiler errors (sirmax2)
        Selection.modalClip = null;
		*/
        open = false;
        if (gfx.controls.Dialog.currentDialog == null)
        {
            return;
        } // end if
        if (gfx.controls.Dialog.currentDialog.modalBackground != null)
        {
            gfx.controls.Dialog.currentDialog.modalBackground.removeMovieClip();
        } // end if
        gfx.controls.Dialog.currentDialog.removeMovieClip();
        currentDialog = null;
    } // End of the function
    static function closeDialog(event)
    {
        gfx.controls.Dialog.hide();
    } // End of the function
    static function blockInteraction()
    {
    } // End of the function
    function toString()
    {
        return ("[Scaleform Dialog " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (closeBtn != null)
        {
            closeBtn.addEventListener("click", this, "handleClose");
        } // end if
        if (cancelBtn != null)
        {
            cancelBtn.addEventListener("click", this, "handleClose");
        } // end if
        if (submitBtn != null)
        {
            submitBtn.addEventListener("click", this, "handleSubmit");
        } // end if
        if (dragBar != null)
        {
            dragBar.tabEnabled = false;
            dragBar.onPress = gfx.utils.Delegate.create(this, startDrag);
            dragBar.onRelease = gfx.utils.Delegate.create(this, stopDrag);
        } // end if
        this.populateUI();
    } // End of the function
    function populateUI()
    {
    } // End of the function
    function handleClose(event)
    {
        this.dispatchEvent({type: "close"});
    } // End of the function
    function handleSubmit(event)
    {
        this.dispatchEvent({type: "submit", data: this.getSubmitData()});
    } // End of the function
    function getSubmitData()
    {
        return (true);
    } // End of the function
    static var open = false;
} // End of Class
