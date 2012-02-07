class net.wargaming.io.GameDelegateNice
{
    function GameDelegateNice()
    {
    } // End of the function
    static function call(methodName, params, scope, callBack)
    {
        if (!net.wargaming.io.GameDelegateNice.initialized)
        {
            net.wargaming.io.GameDelegateNice.initialize();
        } // end if
        nextID = ++net.wargaming.io.GameDelegateNice.nextID;
        var _loc1 = net.wargaming.io.GameDelegateNice.nextID;
        net.wargaming.io.GameDelegateNice.responseHash[_loc1] = [scope, callBack];
        params.unshift(methodName, _loc1);
        var _loc2 = net.wargaming.io.GameDelegateNice.convertToJson(params);
        flash.external.ExternalInterface.call.apply(null, ["callNice", _loc2]);
        delete net.wargaming.io.GameDelegateNice.responseHash[_loc1];
    } // End of the function
    static function receiveResponse(uid, jsonString)
    {
        var _loc1 = net.wargaming.io.GameDelegateNice.responseHash[uid];
        if (_loc1 == null)
        {
            return;
        } // end if
        var _loc2 = _loc1[0];
        var _loc3 = _loc1[1];
        var _loc4 = net.wargaming.io.GameDelegateNice.convertFromJson(jsonString);
        _loc2[_loc3].apply(_loc2, _loc4);
    } // End of the function
    static function addCallBack(methodName, scope, callBack)
    {
        if (!net.wargaming.io.GameDelegateNice.initialized)
        {
            net.wargaming.io.GameDelegateNice.initialize();
        } // end if
        net.wargaming.io.GameDelegateNice.callBackHash[methodName] = [scope, callBack];
    } // End of the function
    static function removeCallBack(methodName)
    {
        net.wargaming.io.GameDelegateNice.callBackHash[methodName] = null;
    } // End of the function
    static function receiveCall(methodName, jsonString)
    {
        var _loc4 = net.wargaming.io.GameDelegateNice.convertFromJson(jsonString);
        var _loc1 = net.wargaming.io.GameDelegateNice.callBackHash[methodName];
        if (_loc1 == null)
        {
            return;
        } // end if
        var _loc2 = _loc1[0];
        var _loc3 = _loc1[1];
        _loc2[_loc3].apply(_loc2, _loc4);
    } // End of the function
    static function initialize()
    {
        initialized = true;
        flash.external.ExternalInterface.addCallback("callJson", net.wargaming.io.GameDelegateNice, net.wargaming.io.GameDelegateNice.receiveCall);
        flash.external.ExternalInterface.addCallback("respondJson", net.wargaming.io.GameDelegateNice, net.wargaming.io.GameDelegateNice.receiveResponse);
    } // End of the function
    static function convertFromJson(jsonStr)
    {
        try
        {
            var _loc1 = net.wargaming.io.JSON.parse(jsonStr);
        } // End of try
        catch (ex)
        {
            net.wargaming.utils.DebugUtils.LOG_ERROR_FORMAT("%s:%s:%s:%s", ex.name, ex.message, ex.at, ex.text);
        } // End of catch
        return (_loc1);
    } // End of the function
    static function convertToJson(obj)
    {
        try
        {
            var _loc1 = net.wargaming.io.JSON.stringify(obj);
        } // End of try
        catch (ex)
        {
            net.wargaming.utils.DebugUtils.LOG_ERROR_FORMAT("%s:%s:%s:%s", ex.name, ex.message, ex.at, ex.text);
        } // End of catch
        return (_loc1);
    } // End of the function
    static var responseHash = {};
    static var callBackHash = {};
    static var nextID = 0;
    static var initialized = false;
} // End of Class
