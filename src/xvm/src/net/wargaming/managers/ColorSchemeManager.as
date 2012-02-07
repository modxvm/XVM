class net.wargaming.managers.ColorSchemeManager
{
    function ColorSchemeManager()
    {
    } // End of the function
    static function initialize()
    {
        if (net.wargaming.managers.ColorSchemeManager._instance == null)
        {
            _instance = new net.wargaming.managers.ColorSchemeManager();
            gfx.io.GameDelegate.removeCallBack("colorSchemeManager.setColors");
            gfx.io.GameDelegate.addCallBack("colorSchemeManager.setColors", net.wargaming.managers.ColorSchemeManager._instance, "onSetColors");
        } // end if
    } // End of the function
    function update()
    {
        gfx.io.GameDelegate.call("colorSchemeManager.getColors", []);
    } // End of the function
    function addChangeCallBack(scope, func_name)
    {
        _callbacks.push([scope, func_name]);
    } // End of the function
    function __notifyCallbacks()
    {
        for (var _loc2 = 0; _loc2 < _callbacks.length; ++_loc2)
        {
            var _loc3 = _callbacks[_loc2][0];
            var _loc4 = _callbacks[_loc2][1];
            _loc3[_loc4].apply(_loc3, []);
        } // end of for
    } // End of the function
    static function get instance()
    {
        net.wargaming.managers.ColorSchemeManager.initialize();
        return (net.wargaming.managers.ColorSchemeManager._instance);
    } // End of the function
    function getScheme(schemeName)
    {
        return (net.wargaming.managers.ColorSchemeManager._colors[schemeName]);
    } // End of the function
    function getAliasColor(schemeName)
    {
        return (net.wargaming.managers.ColorSchemeManager._colors[schemeName] != undefined ? (net.wargaming.managers.ColorSchemeManager._colors[schemeName].aliasColor) : (null));
    } // End of the function
    function getRGB(schemeName)
    {
        return (net.wargaming.managers.ColorSchemeManager._colors[schemeName] != undefined ? (net.wargaming.managers.ColorSchemeManager._colors[schemeName].rgb) : (null));
    } // End of the function
    function getTransform(schemeName)
    {
        return (net.wargaming.managers.ColorSchemeManager._colors[schemeName] != undefined ? (net.wargaming.managers.ColorSchemeManager._colors[schemeName].transform) : (null));
    } // End of the function
    function onSetColors()
    {
        while (arguments.length != 0)
        {
            var _loc4 = String(arguments.shift());
            var _loc5 = String(arguments.shift());
            var _loc6 = Number(arguments.shift());
            var _loc3 = arguments.splice(0, 8);
            net.wargaming.managers.ColorSchemeManager._colors[_loc4] = {aliasColor: _loc5, rgb: _loc6, transform: new flash.geom.ColorTransform(_loc3[0], _loc3[1], _loc3[2], _loc3[3], _loc3[4], _loc3[5], _loc3[6], _loc3[7])};
        } // end while
        this.__notifyCallbacks();
    } // End of the function
    static var _instance = null;
    static var _colors = {};
    var _callbacks = [];
} // End of Class
