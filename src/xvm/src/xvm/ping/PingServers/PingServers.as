package xvm.ping.PingServers
{
    import com.xvm.types.cfg.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.external.ExternalInterface;
    import org.idmedia.as3commons.util.StringUtils;

    public class PingServers extends EventDispatcher
    {
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
            ExternalInterface.addCallback(Cmd.RESPOND_PINGDATA, pingCallback);
            pingTimer = 0;
            pingTimeouts = null;
        }

        private function ping():void
        {
            //Logger.add("ping");
            Cmd.ping();
        }

        private function pingCallback(answer:String):void
        {
            //Logger.add("pingCallback:" + arguments.toString());
            if (answer == null || answer == "")
                return;

            var parsedAnswerObj:Object = JSONx.parse(answer);
            var responseTimeList:Array = [];
            for (var name:String in parsedAnswerObj)
            {
                var cluster:String = StringUtils.startsWith(name, "WOT ") ? name.substring(4) : name;
                responseTimeList.push({ cluster: cluster, time: parsedAnswerObj[name] });
            }
            responseTimeList.sortOn(["cluster"]);

            dispatchEvent(new ObjectEvent(Event.COMPLETE, responseTimeList));
        }
    }
}
