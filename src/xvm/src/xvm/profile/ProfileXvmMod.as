/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class ProfileXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:PROFILE]";
        }

        private static const _views:Object =
        {
            "lobby": ProfileLobbyXvmView,
            "profile": ProfileXvmView,
            "profileWindow": ProfileXvmView
        }

        override public function entryPoint():void
        {
            //Logger.err(new Error());
            super.entryPoint();
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
