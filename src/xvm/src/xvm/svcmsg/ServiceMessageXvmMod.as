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

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_svcmsg";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "serviceMessageComponents.swf" ];
            Xfw.load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
