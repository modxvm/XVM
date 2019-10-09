/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ping.PingServers
{
    import com.xfw.*;
    import com.xfw.events.*;
    import flash.events.*;
    import flash.utils.*;

    public class PingServers extends EventDispatcher
    {
        private static const COMMAND_PING:String = "xvm_ping.ping";
        private static const COMMAND_AS_PINGDATA:String = "xvm_ping.as.pingdata";

        private static var _instance:PingServers = null;
        private static function get instance():PingServers
        {
            if (_instance == null)
                _instance = new PingServers();
            return _instance;
        }

        private var pingTimer:uint;
        private var pingTimeouts:Array;
        private var serversOrder:Array;

        public static function initFeature(enabled:Boolean, interval:Number = 0):void
        {
            if (!enabled || interval <= 0)
                return;

            instance.ping();
            instance.pingTimer = setInterval(instance.ping, interval);
        }

        public static function stop():void
        {
            if (instance.pingTimer > 0)
            {
                clearInterval(instance.pingTimer);
                instance.pingTimer = 0;
            }

            if (instance.pingTimeouts)
            {
                for each (var t:uint in instance.pingTimeouts)
                    clearTimeout(t);
                instance.pingTimeouts = null;
            }
        }

        public static function addEventListener(listener:Function):void
        {
            instance.addEventListener(Event.COMPLETE, listener, false, 0, true);
        }

        public static function removeEventListener(listener:Function):void
        {
            instance.removeEventListener(Event.COMPLETE, listener);
        }

        // PRIVATE

        function PingServers()
        {
            Xfw.addCommandListener(COMMAND_AS_PINGDATA, pingCallback);

            pingTimer = 0;
            pingTimeouts = null;
        }

        private function ping():void
        {
            //Logger.add("ping");
            Xfw.cmd(COMMAND_PING);
        }

        private function pingCallback(answer:Array):Object
        {
            //Logger.addObject(answer, 2);
            //Logger.add("pingCallback:" + arguments.toString());
            if (!answer)
                return null;

            dispatchEvent(new ObjectEvent(Event.COMPLETE, answer));

            return null;
        }
    }
}
