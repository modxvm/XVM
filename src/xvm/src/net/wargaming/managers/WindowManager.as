class net.wargaming.managers.WindowManager
{
    var groupsCounter, context, onEnterFrame, xAdjust, yAdjust, window, xIncrement, yIncrement;
    static var opened, __get__instance;
    function WindowManager()
    {
        super();
        opened = new Object();
        groupsCounter = new Object();
        context = _root;
    } // End of the function
    static function get instance()
    {
        if (net.wargaming.managers.WindowManager._instance == null)
        {
            _instance = new net.wargaming.managers.WindowManager();
        } // end if
        return (net.wargaming.managers.WindowManager._instance);
    } // End of the function
    function initialize(layout)
    {
        inited = true;
        context = layout;
        Selection.addListener(this);
    } // End of the function
    function onSetFocus(old_focus, new_focus)
    {
        var _loc2;
        var _loc4;
        if (new_focus == null)
        {
            context.onEnterFrame = function ()
            {
                net.wargaming.managers.WindowManager.__get__instance().restoreFocus();
                delete this.onEnterFrame;
            };
            return;
        }
        else if (!(new_focus instanceof net.wargaming.controls.Window))
        {
            for (var _loc2 = new_focus; _loc2 != undefined; _loc2 = _loc2._parent)
            {
                if (_loc2 instanceof net.wargaming.controls.Window)
                {
                    _loc2.focused = true;
                    _loc4 = _loc2;
                    break;
                } // end if
            } // end of for
        } // end else if
        for (var _loc2 = old_focus; _loc2 != undefined; _loc2 = _loc2._parent)
        {
            if (_loc2 instanceof net.wargaming.controls.Window)
            {
                _loc2.focus_element = old_focus instanceof gfx.controls.TextInput ? (old_focus.textField) : (old_focus);
                if (_loc4 != _loc2)
                {
                    _loc2.focused = false;
                } // end if
                break;
            } // end if
        } // end of for
    } // End of the function
    function restoreFocus()
    {
        if (Selection.getFocus() == null)
        {
            var _loc2 = null;
            for (var _loc3 in net.wargaming.managers.WindowManager.opened)
            {
                var _loc1 = net.wargaming.managers.WindowManager.opened[_loc3].window;
                if (_loc2 == null || _loc1.getDepth() > _loc2.getDepth())
                {
                    _loc2 = _loc1;
                } // end if
            } // end of for...in
            if (_loc2 != null)
            {
                Selection.setFocus(_loc2.focus_element || _loc2.titleBtn);
            } // end if
        } // end if
    } // End of the function
    function open(symbol, uniqueName, initObj, managed, group, relativeTo, positionPolicy)
    {
        net.wargaming.managers.ToolTipManager.hide();
        if (managed == undefined || managed == null)
        {
            managed = false;
        } // end if
        if (group == undefined)
        {
            group = null;
        } // end if
        if (positionPolicy == undefined)
        {
            positionPolicy = net.wargaming.managers.WindowManager.HOLD_VISIBLE;
        } // end if
        var _loc3;
        if (net.wargaming.managers.WindowManager.opened[uniqueName] != undefined)
        {
            return (net.wargaming.managers.WindowManager.opened[uniqueName].window);
        } // end if
        if (initObj._x == undefined)
        {
            initObj._x = 0;
        } // end if
        if (initObj._y == undefined)
        {
            initObj._y = 0;
        } // end if
        var _loc8 = {_x: initObj._x, _y: initObj._y};
        if (relativeTo != undefined)
        {
            var _loc5 = {x: initObj._x, y: initObj._y};
            relativeTo.localToGlobal(_loc5);
            context.globalToLocal(_loc5);
            initObj._x = _loc5.x;
            initObj._y = _loc5.y;
        } // end if
        var _loc7 = {window: null, name: uniqueName, managed: managed, group: group, positionPolicy: positionPolicy};
        net.wargaming.managers.WindowManager.opened[uniqueName] = _loc7;
        _loc3 = gfx.core.UIComponent.createInstance(context, symbol, uniqueName, context.getNextHighestDepth(), initObj);
        _loc3.addEventListener("close", this, "handleCloseWindow");
        _loc3.addEventListener("confirmFormComplete", function (event)
        {
            net.wargaming.managers.WindowManager.__get__instance().swapToNextHighestDepth(event.target);
        });
        _loc7.window = _loc3;
        net.wargaming.managers.WindowManager.windows.push(uniqueName);
        if (group != null)
        {
            this.addGroupCounter(group);
            this.movieGroupWindowToVector(_loc3, group);
        } // end if
        return (_loc3);
    } // End of the function
    function close(uniqueName, force)
    {
        var _loc2 = net.wargaming.managers.WindowManager.opened[uniqueName];
        if (_loc2 != undefined)
        {
            if (force)
            {
                _loc2.window.removeMovieClip();
                this.deleteWindow(uniqueName);
            }
            else
            {
                _loc2.window.handleClose();
            } // end if
        } // end else if
    } // End of the function
    function isOpen(uniqueName)
    {
        return (net.wargaming.managers.WindowManager.opened[uniqueName] != undefined);
    } // End of the function
    function getWindow(uniqueName)
    {
        return (net.wargaming.managers.WindowManager.opened[uniqueName].window);
    } // End of the function
    function setWindow(window, uniqueName, managed, group, positionPolicy)
    {
        if (managed == undefined || managed == null)
        {
            managed = false;
        } // end if
        if (group == undefined || group == null)
        {
            group = null;
        } // end if
        if (positionPolicy == undefined)
        {
            positionPolicy = net.wargaming.managers.WindowManager.HOLD_VISIBLE;
        } // end if
        this.addGroupCounter(group);
        net.wargaming.managers.WindowManager.opened[uniqueName] = {window: window, name: uniqueName, managed: managed, group: group, positionPolicy: positionPolicy};
    } // End of the function
    function moveTo(window, x, y, group, relativeTo)
    {
        var _loc2 = {x: x, y: y};
        if (relativeTo != undefined)
        {
            relativeTo.localToGlobal(_loc2);
        } // end if
        context.globalToLocal(_loc2);
        window._x = _loc2.x;
        window._y = _loc2.y;
        if (group != undefined && groupsCounter[group] != undefined)
        {
            this.movieGroupWindowToVector(window, group);
        } // end if
    } // End of the function
    function swapToNextHighestDepth(window)
    {
        window.swapDepths(context.getNextHighestDepth());
        for (var _loc3 in net.wargaming.managers.WindowManager.opened)
        {
            if (net.wargaming.managers.WindowManager.opened[_loc3].window != window)
            {
                net.wargaming.managers.WindowManager.opened[_loc3].window.focused = false;
            } // end if
        } // end of for...in
        window.focused = true;
    } // End of the function
    function closeAllManagedWindow(forse)
    {
        for (var _loc5 in net.wargaming.managers.WindowManager.opened)
        {
            var _loc2 = net.wargaming.managers.WindowManager.opened[_loc5];
            if (_loc2.managed || forse)
            {
                if (_loc2.group != null)
                {
                    groupsCounter[_loc2.group].decrement();
                } // end if
                var _loc3 = _loc2.window;
                if (_loc2.managed)
                {
                    _loc3.handleClose();
                } // end if
                _loc3.removeMovieClip();
                delete net.wargaming.managers.WindowManager.opened[_loc5];
            } // end if
        } // end of for...in
    } // End of the function
    function update(width, height)
    {
        var _loc6 = net.wargaming.managers.WindowManager.opened.length;
        for (var _loc3 in net.wargaming.managers.WindowManager.opened)
        {
            var _loc2 = net.wargaming.managers.WindowManager.opened[_loc3];
            switch (_loc2.positionPolicy)
            {
                case net.wargaming.managers.WindowManager.HOLD_VISIBLE:
                {
                    this.holdVisible(_loc2.window, width, height);
                    break;
                } 
                case net.wargaming.managers.WindowManager.REMAIN_IN_POSITON:
                {
                    break;
                } 
            } // End of switch
        } // end of for...in
    } // End of the function
    function focusToTopWindow()
    {
        var _loc2 = "";
        while (net.wargaming.managers.WindowManager.windows.length != 0)
        {
            _loc2 = net.wargaming.managers.WindowManager.windows[net.wargaming.managers.WindowManager.windows.length - 1];
            if (net.wargaming.managers.WindowManager.opened[_loc2] == undefined)
            {
                net.wargaming.managers.WindowManager.windows.pop();
                continue;
            } // end if
            break;
        } // end while
        if (_loc2 != "" && net.wargaming.managers.WindowManager.opened[_loc2])
        {
            this.swapToNextHighestDepth(this.getWindow(_loc2));
        } // end if
    } // End of the function
    function hasOpened()
    {
        for (var _loc1 in net.wargaming.managers.WindowManager.opened)
        {
            if (net.wargaming.managers.WindowManager.opened[_loc1] != null)
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    } // End of the function
    function handleCloseWindow(event)
    {
        var _loc2 = event.target._name;
        this.deleteWindow(_loc2);
        this.focusToTopWindow();
    } // End of the function
    function deleteWindow(uniqueName)
    {
        var _loc2 = net.wargaming.managers.WindowManager.opened[uniqueName].group;
        if (_loc2 != null && groupsCounter[_loc2] != undefined)
        {
            groupsCounter[_loc2].window = groupsCounter[_loc2].window - 1;
            if (groupsCounter[_loc2].window == 0)
            {
                groupsCounter[_loc2].xAdjust = 0;
                groupsCounter[_loc2].yAdjust = 0;
            } // end if
        } // end if
        delete net.wargaming.managers.WindowManager.opened[uniqueName];
    } // End of the function
    function addGroupCounter(group)
    {
        if (group == null)
        {
            return;
        } // end if
        if (groupsCounter[group] == undefined)
        {
            groupsCounter[group] = {xAdjust: 0, yAdjust: 0, window: 0, xIncrement: function ()
            {
                xAdjust = xAdjust + 1;
            }, yIncrement: function ()
            {
                yAdjust = yAdjust + 1;
            }, increment: function ()
            {
                window = window + 1;
                this.xIncrement();
                this.yIncrement();
            }, decrement: function ()
            {
                window = window - 1;
            }};
        } // end if
        var _loc3 = groupsCounter[group];
        _loc3.increment();
    } // End of the function
    function movieGroupWindowToVector(obj, group)
    {
        var _loc3 = groupsCounter[group];
        if (_loc3 == undefined || _loc3.window == 1)
        {
            return;
        } // end if
        var _loc5 = obj._x + (_loc3.xAdjust - 1) * groupPositionOffset.x;
        var _loc4 = obj._y + (_loc3.yAdjust - 1) * groupPositionOffset.y;
        var _loc6 = obj.width == Number.NaN ? (obj._width) : (obj.width);
        var _loc7 = obj.height == Number.NaN ? (obj._height) : (obj.height);
        if (_loc5 < 0)
        {
            _loc5 = 0;
            _loc3.xIncrement = function ()
            {
                xAdjust = xAdjust + 1;
            };
        }
        else if (_loc5 + _loc6 > Stage.width)
        {
            _loc5 = Stage.width - _loc6;
            _loc3.xIncrement = function ()
            {
                xAdjust = xAdjust - 1;
            };
        } // end else if
        if (_loc4 < 0)
        {
            _loc4 = 0;
            _loc3.yIncrement = function ()
            {
                yAdjust = yAdjust + 1;
            };
        }
        else if (_loc4 + _loc7 > Stage.height)
        {
            _loc4 = Stage.height - _loc7;
            _loc3.yIncrement = function ()
            {
                yAdjust = yAdjust - 1;
            };
        } // end else if
        obj._x = _loc5;
        obj._y = _loc4;
    } // End of the function
    function holdVisible(clip, width, height)
    {
        var _loc2 = {x: clip._x, y: clip._y};
        var _loc4 = false;
        context.localToGlobal(_loc2);
        var _loc5 = clip.width == Number.NaN ? (clip._width) : (clip.width);
        var _loc6 = clip.height == Number.NaN ? (clip._height) : (clip.height);
        if (_loc2.x < 0)
        {
            _loc2.x = 0;
            _loc4 = true;
        }
        else if (_loc2.x + _loc5 > width)
        {
            _loc2.x = width - _loc5;
            _loc4 = true;
        } // end else if
        if (_loc2.y < 0)
        {
            _loc2.y = 0;
            _loc4 = true;
        }
        else if (_loc2.y + _loc6 > height)
        {
            _loc2.y = height - _loc6;
            _loc4 = true;
        } // end else if
        if (_loc4)
        {
            context.globalToLocal(_loc2);
            clip._x = _loc2.x;
            clip._y = _loc2.y;
        } // end if
    } // End of the function
    static var REMAIN_IN_POSITON = 1;
    static var HOLD_VISIBLE = 2;
    static var windows = [];
    static var _instance = net.wargaming.managers.WindowManager.__get__instance();
    var inited = false;
    var groupPositionOffset = {x: 20, y: 20};
} // End of Class
