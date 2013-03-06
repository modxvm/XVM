intrinsic class net.wargaming.managers.BattleInputHandler
{
    static function get instance();
    function addHandler(keyCode, keyUp, scope, handler);
    function removeHandlers(keyCode);
}
