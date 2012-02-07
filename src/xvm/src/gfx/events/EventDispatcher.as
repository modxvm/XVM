class gfx.events.EventDispatcher
{
    var _listeners;
    static var _instance;
    function EventDispatcher()
    {
    } // End of the function
    static function initialize(target)
    {
        if (gfx.events.EventDispatcher._instance == undefined)
        {
            _instance = new gfx.events.EventDispatcher();
        } // end if
        target.dispatchEvent = gfx.events.EventDispatcher._instance.dispatchEvent;
        target.dispatchQueue = gfx.events.EventDispatcher._instance.dispatchQueue;
        target.hasEventListener = gfx.events.EventDispatcher._instance.hasEventListener;
        target.addEventListener = gfx.events.EventDispatcher._instance.addEventListener;
        target.removeEventListener = gfx.events.EventDispatcher._instance.removeEventListener;
        target.removeAllEventListeners = gfx.events.EventDispatcher._instance.removeAllEventListeners;
        target.cleanUpEvents = gfx.events.EventDispatcher._instance.cleanUpEvents;
        _global.ASSetPropFlags(target, "dispatchQueue", 1);
    } // End of the function
    static function indexOfListener(listeners, scope, callBack)
    {
        var _loc3 = listeners.length;
        var _loc2 = -1;
        while (++_loc2 < _loc3)
        {
            var _loc1 = listeners[_loc2];
            if (_loc1.listenerObject == scope && _loc1.listenerFunction == callBack)
            {
                return (_loc2);
            } // end if
        } // end while
        return (-1);
    } // End of the function
    function addEventListener(event, scope, callBack)
    {
        if (_listeners == undefined)
        {
            _listeners = {};
            _global.ASSetPropFlags(this, "_listeners", 1);
        } // end if
        var _loc3 = _listeners[event];
        if (_loc3 == undefined)
        {
            _loc3 = [];
            _listeners[event] = [];
        } // end if
        if (gfx.events.EventDispatcher.indexOfListener(_loc3, scope, callBack) == -1)
        {
            _loc3.push({listenerObject: scope, listenerFunction: callBack});
        } // end if
    } // End of the function
    function removeEventListener(event, scope, callBack)
    {
        var _loc2 = _listeners[event];
        if (_loc2 == undefined)
        {
            return;
        } // end if
        var _loc3 = gfx.events.EventDispatcher.indexOfListener(_loc2, scope, callBack);
        if (_loc3 != -1)
        {
            _loc2.splice(_loc3, 1);
        } // end if
    } // End of the function
    function dispatchEvent(event)
    {
        if (event.type == "all")
        {
            return;
        } // end if
        if (event.target == undefined)
        {
            event.target = this;
        } // end if
        this.dispatchQueue(this, event);
    } // End of the function
    function hasEventListener(event)
    {
        return (_listeners[event] != null && _listeners[event].length > 0);
    } // End of the function
    function removeAllEventListeners(event)
    {
        if (event == undefined)
        {
            delete this._listeners;
        }
        else
        {
            delete _listeners[event];
        } // end else if
    } // End of the function
    function dispatchQueue(dispatch, event)
    {
        var _loc1 = dispatch._listeners[event.type];
        if (_loc1 != undefined)
        {
            gfx.events.EventDispatcher.$dispatchEvent(dispatch, _loc1, event);
        } // end if
        _loc1 = dispatch._listeners.all;
        if (_loc1 != undefined)
        {
            gfx.events.EventDispatcher.$dispatchEvent(dispatch, _loc1, event);
        } // end if
    } // End of the function
    static function $dispatchEvent(dispatch, listeners, event)
    {
        var _loc7 = listeners.length;
        for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
        {
            var _loc1 = listeners[_loc3].listenerObject;
            var _loc5 = typeof(_loc1);
            var _loc2 = listeners[_loc3].listenerFunction;
            if (_loc2 == undefined)
            {
                _loc2 = event.type;
            } // end if
            if (_loc5 != "function")
            {
                if (_loc1.handleEvent != undefined && _loc2 == undefined)
                {
                    _loc1.handleEvent(event);
                }
                else
                {
                    _loc1[_loc2](event);
                } // end else if
                continue;
            } // end if
            if (_loc1[_loc2] != null)
            {
                _loc1[_loc2](event);
                continue;
            } // end if
            _loc1.apply(dispatch, [event]);
        } // end of for
    } // End of the function
    function cleanUp()
    {
        this.cleanUpEvents();
    } // End of the function
    function cleanUpEvents()
    {
        this.removeAllEventListeners();
    } // End of the function
} // End of Class
