/**
 * AutoLogin XVM mod
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.autologin
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class AutoLoginXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:AUTOLOGIN]";
        }

        private static const _views:Object =
        {
            "introVideo": AutoLoginXvmView,
            "login": AutoLoginXvmView,
            "lobby": AutoLoginXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
