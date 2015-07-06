/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.online
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import xvm.online.OnlineServers.*;

    public class OnlineXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:ONLINE]";
        }

        private static const _views:Object =
        {
            "login": OnlineLoginXvmView,
            "lobby": OnlineLobbyXvmView
        }

        public override function get views():Object
        {
            return _views;
        }

        public override function entryPoint():void
        {
            // init as earlier as possible
            OnlineServers.initFeature((Config.config.login.onlineServers.enabled || Config.config.hangar.onlineServers.enabled) && Config.config.__wgApiAvailable);
        }
    }
}
