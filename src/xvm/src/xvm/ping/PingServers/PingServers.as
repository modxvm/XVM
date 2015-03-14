package xvm.ping.PingServers
{
    import com.xvm.*;
    import com.xvm.events.*;
    import flash.events.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.*;

    public class PingServers extends EventDispatcher
    {
        private static const XPM_COMMAND_PING:String = "xpm.ping";
        private static const XPM_AS_COMMAND_PINGDATA:String = "xpm.pingdata";

        private static var _instance:PingServers = null;
        private static function get instance():PingServers
        {
            if (_instance == null)
                _instance = new PingServers();
            return _instance;
        }

        private var pingTimer:uint;
        private var pingTimeouts:Array;

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

            if (instance.pingTimeouts != null)
            {
                for each (var t:uint in instance.pingTimeouts)
                    clearTimeout(t);
                instance.pingTimeouts = null;
            }
        }

        public static function addListener(listener:Function):void
        {
            instance.addEventListener(Event.COMPLETE, listener);
        }

        public static function removeListener(listener:Function):void
        {
            instance.removeEventListener(Event.COMPLETE, listener);
        }

        // PRIVATE

        function PingServers()
        {
            Xvm.addEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);

            pingTimer = 0;
            pingTimeouts = null;
        }

        private function ping():void
        {
            //Logger.add("ping");
            Xvm.cmd(XPM_COMMAND_PING);
        }

        private function handleXpmCommand(e:ObjectEvent):void
        {
            //Logger.add("handleXpmCommand: " + e.result.cmd);
            try
            {
                switch (e.result.cmd)
                {
                    case XPM_AS_COMMAND_PINGDATA:
                        pingCallback(e.result.args[0]);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function pingCallback(answer:Object):void
        {
            //Logger.addObject(answer, 2);
            //Logger.add("pingCallback:" + arguments.toString());
            if (!answer)
                return;

            var responseTimeList:Array = [];
            for (var name:String in answer)
            {
                var cluster:String = StringUtils.startsWith(name, "WOT ") ? name.substring(4) : name;
                responseTimeList.push({ cluster: cluster, time: answer[name] });
            }
            responseTimeList.sortOn(["cluster"]);

            dispatchEvent(new ObjectEvent(Event.COMPLETE, responseTimeList));
        }
    }
}
