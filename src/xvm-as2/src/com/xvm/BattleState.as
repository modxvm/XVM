/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.BattleStateData;

class com.xvm.BattleState
{

    private static var _userData:Object = { };
    private static var _screenSize:Object = { };
    private static var _selfUserName:String = null;

    public static function getUserData(userName:String):BattleStateData
    {
        if (!_userData.hasOwnProperty(userName))
            _userData[userName] = { };
        return _userData[userName];
    }

    public static function getSelfUserData():BattleStateData
    {
        if (_selfUserName == null)
            return null;
        return getUserData(_selfUserName);
    }

    public static function setUserData(userName:String, data:Object)
    {
        var ud = getUserData(userName);
        for (var i in data)
            ud[i] = data[i];
    }

    public static function setSelfUserName(userName:String):Void
    {
        _selfUserName = userName;
    }

    public static function get screenSize():Object
    {
        return _screenSize;
    }

    public static function setScreenSize(width:Number, height:Number):Void
    {
        _screenSize.width = width;
        _screenSize.height = height;
    }
}
