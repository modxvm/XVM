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

            if (!enabled)
                return;

            // immediately
            instance.ping();
            // after 1, 3, 5, 7 sec
            //instance.pingTimeouts = [
                //setTimeout(instance.ping, 1000),
                //setTimeout(instance.ping, 3000),
                //setTimeout(instance.ping, 5000),
                //setTimeout(instance.ping, 7000)
            //];

            if (interval > 0)
            {
                // periodically
                instance.pingTimer = setInterval(instance.ping, interval);
            }
        }

        public static function addListener(listener:Function):void
        {
            instance.addEventListener(Event.COMPLETE, listener);
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
            var responceTimeList:Array = [];
            for (var name:String in parsedAnswerObj)
            {
                var cluster:String = StringUtils.startsWith(name, "WOT ") ? name.substring(4) : name;
                responceTimeList.push({ cluster: cluster, time: parsedAnswerObj[name] });
            }
            responceTimeList.sortOn(["cluster"]);

            dispatchEvent(new ObjectEvent(Event.COMPLETE, responceTimeList));
        }
    }
}
