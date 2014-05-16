/**
 * ...
 * @author sirmax2
 */
class com.xvm.BattleState
{
    private static var _userData:Object = { };
    private static var _screenSize:Object = { };

    public static function getUserData(userName:String)
    {
        if (!_userData.hasOwnProperty(userName))
            _userData[userName] = { };
        return _userData[userName];
    }

    public static function setUserData(userName:String, data:Object)
    {
        var ud = getUserData(userName);
        for (var i in data)
            ud[i] = data[i];
    }

    public static function get screenSize()
    {
        return _screenSize;
    }

    public static function setScreenSize(width:Number, height:Number)
    {
        _screenSize.width = width;
        _screenSize.height = height;
    }
}
