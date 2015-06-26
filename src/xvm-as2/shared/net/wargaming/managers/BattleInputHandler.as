intrinsic class net.wargaming.managers.BattleInputHandler
{
    var m_handlers = new Object();
    var m_focusHandler, m_unFocusMC, m_inputDelegate, m_lastKeyCode;
    static var m_instance = null;
 
    static function get instance();
    function addHandler(keyCode, keyUp, scope, handler);
    function removeHandlers(keyCode);
    function _getPathToFocus();
}
