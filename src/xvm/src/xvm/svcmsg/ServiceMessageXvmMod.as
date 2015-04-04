/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.svcmsg
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class ServiceMessageXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:SVCMSG]";
        }

        private static const _views:Object =
        {
            "lobby": ServiceMessageXvmView,
            "notificationsList": ServiceMessageXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
