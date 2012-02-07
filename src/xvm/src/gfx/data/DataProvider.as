class gfx.data.DataProvider extends Array
{
    var length, slice, dispatchEvent, splice, cleanUpEvents;
    static var instance;
    function DataProvider(total)
    {
        super();
        gfx.events.EventDispatcher.initialize(this);
    } // End of the function
    static function initialize(data)
    {
        if (gfx.data.DataProvider.instance == undefined)
        {
            instance = new gfx.data.DataProvider();
        } // end if
        var _loc3 = ["indexOf", "requestItemAt", "requestItemRange", "invalidate", "toString", "cleanUp", "isDataProvider"];
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            data[_loc3[_loc2]] = gfx.data.DataProvider.instance[_loc3[_loc2]];
        } // end of for
        gfx.events.EventDispatcher.initialize(data);
        _global.ASSetPropFlags(data, _loc3, 1);
        _global.ASSetPropFlags(data, "addEventListener,removeEventListener,hasEventListener,removeAllEventListeners,dispatchEvent,dispatchQueue,cleanUpEvents", 1);
    } // End of the function
    function indexOf(value, scope, callBack)
    {
        var _loc2 = 0;
        for (var _loc2 = 0; _loc2 < length; ++_loc2)
        {
            if (this[_loc2] == value)
            {
                break;
            } // end if
        } // end of for
        var _loc4 = _loc2 == length ? (-1) : (_loc2);
        if (callBack)
        {
            scope[callBack].call(scope, _loc4);
        } // end if
        return (_loc4);
    } // End of the function
    function requestItemAt(index, scope, callBack)
    {
        var _loc2 = this[index];
        if (callBack)
        {
            scope[callBack].call(scope, _loc2);
        } // end if
        return (_loc2);
    } // End of the function
    function requestItemRange(startIndex, endIndex, scope, callBack)
    {
        var _loc2 = this.slice(startIndex, endIndex + 1);
        if (callBack)
        {
            scope[callBack].call(scope, _loc2);
        } // end if
        return (_loc2);
    } // End of the function
    function invalidate(length)
    {
        this.dispatchEvent({type: "change"});
    } // End of the function
    function cleanUp()
    {
        this.splice(0, length);
        this.cleanUpEvents();
    } // End of the function
    function toString()
    {
        return ("[DataProvider (" + length + ")]");
    } // End of the function
    var isDataProvider = true;
} // End of Class
