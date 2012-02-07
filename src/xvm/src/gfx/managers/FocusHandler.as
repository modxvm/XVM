class gfx.managers.FocusHandler
{
    var inputDelegate, currentFocus, actualFocus;
    function FocusHandler()
    {
        Selection.addListener(this);
        _global.gfxExtensions = 1;
        /* fix decompiler errors (sirmax2)
		Selection.alwaysEnableArrowKeys = true;
        Selection.disableFocusKeys = true;
        Selection.disableFocusAutoRelease = true;
        Selection.disableFocusRolloverEvent = true;
		*/
        _root._focusrect = false;
    } // End of the function
    static function get instance()
    {
        if (gfx.managers.FocusHandler._instance == null)
        {
            _instance = new gfx.managers.FocusHandler();
        } // end if
        return (gfx.managers.FocusHandler._instance);
    } // End of the function
    function initialize()
    {
        inited = true;
        inputDelegate = gfx.managers.InputDelegate.instance;
        inputDelegate.addEventListener("input", this, "handleInput");
    } // End of the function
    function getFocus()
    {
        return (currentFocus);
    } // End of the function
    function setFocus(focus)
    {
        if (!inited)
        {
            this.initialize();
        } // end if
        while (focus.focusTarget != null)
        {
            focus = focus.focusTarget;
        } // end while
        if (currentFocus != focus)
        {
            currentFocus.focused = false;
            currentFocus = focus;
            currentFocus.focused = true;
        } // end if
        if (actualFocus != currentFocus && !(actualFocus instanceof TextField))
        {
            Selection.setFocus(currentFocus);
        } // end if
    } // End of the function
    function handleInput(event)
    {
        var path = this.getPathToFocus();
        if (path.length == 0 || path[0].handleInput == null || path[0].handleInput(event.details, path.slice(1)) != true)
        {
            if (event.details.value == "keyUp")
            {
                return;
            } // end if
            var nav = event.details.navEquivalent;
            if (nav != null)
            {
                if (this.actualFocus instanceof TextField && Selection.getFocus() == this.actualFocus && this.textFieldHandleInput(nav))
                {
                    return;
                } // end if
				/* fix decompiler errors (sirmax2)
                var newFocus = (MovieClip)(Selection.moveFocus(nav, this.currentFocus));
				*/
            } // end if
        } // end if
    } // End of the function
    function getPathToFocus()
    {
        var _loc3 = currentFocus;
        var _loc4 = [_loc3];
        while (_loc3)
        {
            _loc3 = _loc3._parent;
            if (_loc3.handleInput != null)
            {
                _loc4.unshift(_loc3);
            } // end if
            if (_loc3 == _root)
            {
                break;
            } // end if
        } // end while
        return (_loc4);
    } // End of the function
    function onSetFocus(oldFocus, newFocus)
    {
        if (oldFocus instanceof TextField && newFocus == null)
        {
            return;
        } // end if
        if (actualFocus == newFocus)
        {
            var _loc3 = newFocus instanceof TextField ? (newFocus._parent) : (newFocus);
            if (_loc3.focused == false)
            {
                _loc3.focused = true;
            } // end if
        } // end if
        actualFocus = newFocus;
        this.setFocus(newFocus);
    } // End of the function
    function textFieldHandleInput(nav)
    {
        var _loc2 = Selection.getCaretIndex();
        switch (nav)
        {
            case gfx.ui.NavigationCode.UP:
            {
                if (!actualFocus.multiline)
                {
                    return (false);
                } // end if
            } 
            case gfx.ui.NavigationCode.LEFT:
            {
                return (_loc2 > 0);
            } 
            case gfx.ui.NavigationCode.DOWN:
            {
                if (!actualFocus.multiline)
                {
                    return (false);
                } // end if
            } 
            case gfx.ui.NavigationCode.RIGHT:
            {
                return (_loc2 < (TextField)(actualFocus).length);
            } 
        } // End of switch
        return (false);
    } // End of the function
    static var _instance = gfx.managers.FocusHandler.__get__instance();
    var inited = false;
} // End of Class
