/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.BattleStateData;

class com.xvm.BattleState
{
    private static var _userData:Object = { };
    private static var _screenSize:Object = { };
    private static var _selfPlayerId:Number = 0;

    public static function get(playerId:Number):BattleStateData
    {
        if (!_userData.hasOwnProperty(String(playerId)))
        {
            _userData[playerId] = { };
        }
        return _userData[playerId];
    }

    public static function getSelf():BattleStateData
    {
        if (_selfPlayerId == null)
            return null;
        return get(_selfPlayerId);
    }

    public static function getByPlayerName(playerName:String):BattleStateData
    {
        for (var i in _userData)
        {
            var data:BattleStateData = _userData[i];
            if (data.playerName == playerName)
                return data;
        }
        return null;
    }

    public static function update(playerId:Number, data:Object):Boolean
    {
        var updated:Boolean = false;
        var ud:BattleStateData = get(playerId);
        for (var i in data)
        {
            if (ud[i] != data[i])
            {
                updated = true;
                ud[i] = data[i];
            }
        }
        return updated;
    }

    public static function setSelfPlayerId(playerId:Number):Void
    {
        _selfPlayerId = playerId;
    }

    public static function get screenSize():Object
    {
        return _screenSize;
    }

    public static function setScreenSize(width:Number, height:Number, scale:Number):Void
    {
        _screenSize.width = width;
        _screenSize.height = height;
        _screenSize.scale = scale;
    }
}
