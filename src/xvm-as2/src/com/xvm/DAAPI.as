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
        // create stubs for DAAPI function binding
        _root.py_xvm_log = null;
        _root.py_xvm_pythonMacro = null;
        _root.py_xvm_getScreenSize = null;
        _root.py_xvm_captureBarGetBaseNumText = null;
    }

    // DAAPI methods

    public static function xvm_log():Void
    {
        _root.py_xvm_log.apply(null, arguments);
    }

    public static function xvm_pythonMacro(arg:String):String
    {
        return _root.py_xvm_pythonMacro(arg);
    }

    public static function xvm_getScreenSize()
    {
        return _root.py_xvm_getScreenSize();
    }

    public static function xvm_captureBarGetBaseNumText(id:Number):String
    {
        return _root.py_xvm_captureBarGetBaseNumText(id);
    }
}
