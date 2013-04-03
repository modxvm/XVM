/**
 * This class upgrades BattleInputHandler.
 * Before upgrade only one event was allowed per key.
 * Now many events are possible per one key.
 * 
 * Primary example:
 * Show cursor while Ctrl is pressed and zoom minimap.
 * It was not possible to have two events for one key with original WG system.
 */
class wot.battle.BattleInputHandler
{
    public static function upgrade()
    {
        /**
         * Change m_handlers structure to allow storage of multiple scope\callback pairs for one key
         * 
         * from:
         * "keyDown163": [ "_level0", "showCursor" ]
         * to: 
         * "keyDown163": [ { "_level0", "showCursor" } ]
         */
        upgradeHandlers();
        
        /** And accommodate handlers proccesors */
        upgradeAddHandler();
        upgradeHandleInput();
    }
    
    // -- Private
    
    private static function upgradeHandlers()
    {
        var handlers:Array = BIH.m_handlers;
        
        for (var i in handlers)
        {
            var handler = handlers[i];
            var scope = handler[0];
            var callback = handler[1];
            var handlePairsArray:Array = [ { scope:scope, callback:callback } ];
            handlers[i] = handlePairsArray;
        }
    }
    
    private static function upgradeAddHandler()
    {
        BIH.addHandler = function(keyCode, keyUp, scope, callback)
        {
            var key = (keyUp ? ("keyUp") : ("keyDown")) + String(keyCode);
            
            if (_root.BIH.m_handlers[key] == null)
            {
                /** Never had any handler for this key */
                _root.BIH.m_handlers[key] = [];
            }
            
            var handlePairsArray:Array = _root.BIH.m_handlers[key];
            
            var newHandlePair = { scope:scope, callback:callback };
            handlePairsArray.push(newHandlePair);
            
            _root.BIH.m_handlers[key] = handlePairsArray;
        }
        net.wargaming.managers.BattleInputHandler.instance.addHandler = BIH.addHandler;
    }
    
    private static function upgradeHandleInput()
    {
        BIH._handleInput = function(event)
        {
            var key = event.details.value + String(event.details.code);
            if (this.m_lastKeyCode == key)
            {
                return;
            }
            this.m_lastKeyCode = key;
            
            var handler = this.m_handlers[key];
            if (handler == null)
            {
                return;
            }
            
            var focusPath = this._getPathToFocus();
            if (focusPath.length == 0 || focusPath[0].handleInput == null || focusPath[0].handleInput(event.details, focusPath.slice(1)) != true)
            {
                for (var i in handler)
                {
                    var pair = handler[i];
                    var scope = pair.scope;
                    var callback = pair.callback;
                    scope[callback].apply(scope, [event]);
                }
                
                return (true);
            }
            
            return (false);
        }
        net.wargaming.managers.BattleInputHandler.instance._handleInput = BIH._handleInput;
    }
    
    private static function get BIH()
    {
        return _root.BIH;
    }
}
