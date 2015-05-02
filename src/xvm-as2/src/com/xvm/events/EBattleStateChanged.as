/**
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.events.*;

class com.xvm.events.EBattleStateChanged
{
    private var _playerName:String;

    public function EBattleStateChanged(playerName:String)
    {
        _playerName = playerName;
    }

    public function get type():String
    {
        return Events.E_BATTLE_STATE_CHANGED;
    }

    public function get playerName():String
    {
        return _playerName;
    }
}
