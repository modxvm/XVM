/**
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.events.*;

class com.xvm.events.EBattleStateChanged
{
    private var _playerId:Number;

    public function EBattleStateChanged(playerId:Number)
    {
        _playerId = playerId;
    }

    public function get type():String
    {
        return Events.E_BATTLE_STATE_CHANGED;
    }

    public function get playerId():Number
    {
        return _playerId;
    }
}
