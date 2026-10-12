/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ping.PingServers
{
    import com.xfw.*;
    import com.xfw.events.*;
    import flash.events.*;
    import flash.utils.Timer;

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

        private var pingTimer:Timer;
        private var serversOrder:Array;

        public static function initFeature(enabled:Boolean, interval:Number = 0):void
        {
            stop();
            if (!enabled || interval <= 0)
                return;

            instance.ping();

            instance.pingTimer = new Timer(interval);
            instance.pingTimer.addEventListener(TimerEvent.TIMER, instance.onPingTimer);
            instance.pingTimer.start();
        }

        public static function stop():void
        {
            if (_instance && _instance.pingTimer)
            {
                _instance.pingTimer.stop();
                _instance.pingTimer.removeEventListener(TimerEvent.TIMER, _instance.onPingTimer);
                _instance.pingTimer = null;
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

            pingTimer = null;
        }

        private function onPingTimer(e:TimerEvent):void
        {
            ping();
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
