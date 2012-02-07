// fix decompiler errors (sirmax2)
//import gfx.core.UIComponent;

class gfx.managers.PopUpManager
{
    function PopUpManager()
    {
    } // End of the function
    static function createPopUp(context, linkage, initProperties, relativeTo)
    {
        var _loc3 = context._parent;
        if (!_loc3)
        {
            _loc3 = context;
        } // end if
        var _loc7 = _loc3.getNextHighestDepth();
        var _loc5 = {_x: initProperties._x, _y: initProperties._y};
        if (relativeTo != undefined)
        {
            var _loc4 = {x: initProperties._x, y: initProperties._y};
            relativeTo.localToGlobal(_loc4);
            _loc3.globalToLocal(_loc4);
            if (initProperties._x != undefined)
            {
                initProperties._x = _loc4.x;
            } // end if
            if (initProperties._y != undefined)
            {
                initProperties._y = _loc4.y;
            } // end if
        } // end if
        index = ++gfx.managers.PopUpManager.index;
        var _loc2 = gfx.core.UIComponent.createInstance(_loc3, linkage, "popup" + gfx.managers.PopUpManager.index, _loc7, initProperties);
        if (!_loc2)
        {
            initProperties._x = _loc5._x;
            initProperties._y = _loc5._y;
            _loc2 = gfx.managers.PopUpManager.createPopUpRetry(context, linkage, initProperties, relativeTo);
            if (!_loc2)
            {
            } // end if
            return (_loc2);
        } // end if
        _loc2.topmostLevel = true;
        return (_loc2);
    } // End of the function
    static function destroyPopUp(popUp)
    {
        popUp.removeMovieClip();
    } // End of the function
    static function movePopUp(context, popUp, relativeTo, x, y)
    {
        if (popUp == null)
        {
            return;
        } // end if
        var _loc2 = context._parent;
        if (!_loc2)
        {
            _loc2 = context;
        } // end if
        var _loc1 = {x: x, y: y};
        relativeTo.localToGlobal(_loc1);
        _loc2.globalToLocal(_loc1);
        popUp._x = _loc1.x;
        popUp._y = _loc1.y;
    } // End of the function
    static function centerPopUp(popUp)
    {
        if (popUp == null)
        {
            return;
        } // end if
        popUp._x = Stage.width - popUp._width >> 1;
        popUp._y = Stage.height - popUp._height >> 1;
    } // End of the function
    static function createPopUpRetry(context, linkage, initProperties, relativeTo)
    {
        var _loc4 = context.getNextHighestDepth();
        if (relativeTo != null)
        {
            var _loc2 = {x: initProperties._x, y: initProperties._y};
            relativeTo.localToGlobal(_loc2);
            context.globalToLocal(_loc2);
            if (initProperties._x != null)
            {
                initProperties._x = _loc2.x;
            } // end if
            if (initProperties._y != null)
            {
                initProperties._y = _loc2.y;
            } // end if
        } // end if
        index = ++gfx.managers.PopUpManager.index;
        var _loc3 = context.attachMovie(linkage, "popup" + gfx.managers.PopUpManager.index, _loc4, initProperties);
        _loc3.topmostLevel = true;
        return (_loc3);
    } // End of the function
    static var index = 0;
} // End of Class
