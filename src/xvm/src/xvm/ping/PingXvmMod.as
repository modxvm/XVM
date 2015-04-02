/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.ping
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import xvm.ping.PingServers.*;

    public class PingXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:PING]";
        }

        private static const _views:Object =
        {
            "login": PingLoginXvmView,
            "lobby": PingLobbyXvmView
        }

        public override function get views():Object
        {
            return _views;
        }

        public override function entryPoint():void
        {
            // init pinger as earlier as possible
            PingServers.initFeature(Config.config.login.pingServers.enabled || Config.config.hangar.pingServers.enabled);
        }
    }
}
