intrinsic class net.wargaming.managers.ColorSchemeManager
{
    static var _colors = {};
    static function initialize();
    static function get instance():ColorSchemeManager;
    function update();
    function addChangeCallBack(scope, func_name);
    function getScheme(schemeName);
}
