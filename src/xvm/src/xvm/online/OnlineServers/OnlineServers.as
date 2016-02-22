/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.online.OnlineServers
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.*;

    public class OnlineServers extends EventDispatcher
    {
        private static const COMMAND_ONLINE:String = "xvm_online.online";
        private static const COMMAND_AS_ONLINEDATA:String = "xvm_online.as.onlinedata";

        private static var _instance:OnlineServers = null;
        private static function get instance():OnlineServers
        {
            if (_instance == null)
                _instance = new OnlineServers();
            return _instance;
        }

        private var onlineTimer:uint;
        private var onlineTimeouts:Array;
        private var serversOrder:Array;

        public static function initFeature(enabled:Boolean, interval:Number = 0):void
        {
            if (!enabled || interval <= 0)
                return;

            instance.online();
            instance.onlineTimer = setInterval(instance.online, interval);
        }

        public static function stop():void
        {
            if (instance.onlineTimer > 0)
            {
                clearInterval(instance.onlineTimer);
                instance.onlineTimer = 0;
            }

            if (instance.onlineTimeouts != null)
            {
                for each (var t:uint in instance.onlineTimeouts)
                    clearTimeout(t);
                instance.onlineTimeouts = null;
            }
        }

        public static function addEventListener(listener:Function):void
        {
            instance.addEventListener(Event.COMPLETE, listener);
        }

        public static function removeEventListener(listener:Function):void
        {
            instance.removeEventListener(Event.COMPLETE, listener);
        }

        // PRIVATE

        function OnlineServers()
        {
            Xfw.addCommandListener(COMMAND_AS_ONLINEDATA, onlineCallback);

            onlineTimer = 0;
            onlineTimeouts = null;
        }

        private function online():void
        {
            //Logger.add("online");
            Xfw.cmd(COMMAND_ONLINE);
        }

        private function onlineCallback(answer:Object):Object
        {
            //Logger.addObject(answer, 2);
            //Logger.add("onlineCallback:" + arguments.toString());
            if (!answer)
                return null;
            if (!serversOrder || !Utils.serversOrderMatchesAnswer(answer, serversOrder))
                serversOrder = Utils.createServersOrderFromAnswer(answer);

            var responseTimeList:Array = [serversOrder.length];
            for (var name:String in answer)
            {
                var cluster:String = StringUtils.startsWith(name, "WOT ") ? name.substring(4) : name;
                responseTimeList[serversOrder.indexOf(name)] = { cluster: cluster, time: answer[name] };
            }

            dispatchEvent(new ObjectEvent(Event.COMPLETE, responseTimeList));

            return null;
        }
    }
}
