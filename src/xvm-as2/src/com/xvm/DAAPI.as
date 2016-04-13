/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;

class com.xvm.DAAPI extends MovieClip
{
    // DAAPI initialization

    public static function initialize()
    {
        // create stubs for AS2->Python DAAPI function binding
        _root.py_xvm_log = null;
        _root.py_xvm_getScreenSize = null;
        _root.py_xvm_captureBarGetBaseNumText = null;
        _root.py_xvm_loadBattleStat = null;
        _root.py_xvm_pythonMacro = null;

        // Python->AS2 DAAPI function binding
        _root.as_xvm_onUpdateConfig = DAAPI.as_xvm_onUpdateConfig;
        _root.as_xvm_onUpdateStat = DAAPI.as_xvm_onUpdateStat;
    }

    // AS2->Python DAAPI methods

    public static function py_xvm_log():Void
    {
        _root.py_xvm_log.apply(null, arguments);
    }

    public static function py_xvm_getScreenSize()
    {
        return _root.py_xvm_getScreenSize();
    }

    public static function py_xvm_captureBarGetBaseNumText(id:Number):String
    {
        return _root.py_xvm_captureBarGetBaseNumText(id);
    }

    public static function py_xvm_loadBattleStat():Void
    {
        _root.py_xvm_loadBattleStat();
    }

    public static function py_xvm_pythonMacro(arg:String):String
    {
        return _root.py_xvm_pythonMacro(arg);
    }

    // Python->AS2 DAAPI methods

    public static function as_xvm_onUpdateConfig():Void
    {
        Config.instance.GetConfigCallback.apply(Config.instance, arguments);
    }

    public static function as_xvm_onUpdateStat():Void
    {
        StatLoader.instance.LoadStatDataCallback.apply(StatLoader.instance, arguments);
    }
}
