class net.wargaming.managers.BattleInputHandler
{
    var m_focusHandler, m_unFocusMC, m_inputDelegate, m_lastKeyCode;
    static var __get__instance;
    function BattleInputHandler()
    {
        super();
    } // End of the function
    static function get instance()
    {
        if (net.wargaming.managers.BattleInputHandler.m_instance == null)
        {
            m_instance = new net.wargaming.managers.BattleInputHandler();
        } // end if
        return (net.wargaming.managers.BattleInputHandler.m_instance);
    } // End of the function
    function addHandler(keyCode, keyUp, scope, handler)
    {
        var _loc2 = (keyUp ? ("keyUp") : ("keyDown")) + String(keyCode);
        m_handlers[_loc2] = [scope, handler];
    } // End of the function
    function clearHanders()
    {
        m_handlers = new Object();
    } // End of the function
    function setFocused(mc)
    {
        m_focusHandler.setFocus(mc);
    } // End of the function
    function setUnfocused(mc)
    {
        if (m_unFocusMC != null)
        {
            m_focusHandler.setFocus(m_unFocusMC);
        } // end if
    } // End of the function
    function init(unFocusMC)
    {
        m_inputDelegate = gfx.managers.InputDelegate.instance;
        m_inputDelegate.addEventListener("input", this, "_handleInput");
        m_focusHandler = gfx.managers.FocusHandler.instance;
        m_unFocusMC = unFocusMC;
    } // End of the function
    function _handleInput(event)
    {
        var _loc4 = event.details;
        var _loc3 = _loc4.value + String(_loc4.code);
        if (m_lastKeyCode == _loc3)
        {
            return;
        } // end if
        m_lastKeyCode = _loc3;
        var _loc5 = m_handlers[_loc3];
        if (_loc5 == null)
        {
            return;
        } // end if
        var _loc2 = this._getPathToFocus();
        if (_loc2.length == 0 || _loc2[0].handleInput == null || _loc2[0].handleInput(_loc4, _loc2.slice(1)) != true)
        {
            var _loc6 = _loc5[0];
            var _loc7 = _loc5[1];
            _loc6[_loc7].apply(_loc6, [event]);
            return (true);
        } // end if
        return (false);
    } // End of the function
    function _getPathToFocus()
    {
        var _loc3 = m_focusHandler.getFocus();
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
    var m_handlers = new Object();
    static var m_instance = null;
} // End of Class
