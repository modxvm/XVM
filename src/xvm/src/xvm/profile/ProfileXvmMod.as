/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.profile
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class ProfileXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:PROFILE]";
        }

        private static const _views:Object =
        {
            // TODO: 0.8.10 "lobby": ProfileLobbyXvmView,
            // TODO: 0.8.10 "profile": ProfileXvmView,
            // TODO: 0.8.10 "profileWindow": ProfileXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
