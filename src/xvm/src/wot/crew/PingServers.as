import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.JSONx;
import com.xvm.Utils;

class wot.crew.PingServers
{
    private static var instance:PingServers = null;

    private var pingCommandCounter:Number;
    private var pingTimer:Function;

    public static function StartPinging()
    {
        if (instance == null)
            instance = new PingServers();
        instance.pingTimer = _global.setInterval(
            function() { PingServers.instance.ShowPing.call(PingServers.instance) },
            Config.s_config.hangar.pingServers.updateInterval);

        // immediately
        PingServers.instance.ShowPing.call(PingServers.instance);
        // after 1, 3, 5 sec
        _global.setTimeout(function() { PingServers.instance.ShowPing.call(PingServers.instance) }, 1000);
        _global.setTimeout(function() { PingServers.instance.ShowPing.call(PingServers.instance) }, 3000);
        _global.setTimeout(function() { PingServers.instance.ShowPing.call(PingServers.instance) }, 5000);
    }

    public function PingServers()
    {
        pingCommandCounter = 0;
    }

    private function ShowPing()
    {
        Comm.Sync(Defines.COMMAND_PING, String(pingCommandCounter++), this, ShowPingCallback);
    }

    private function ShowPingCallback(event)
    {
        if (event.str == null || event.str == "")
            return;

        if (_root["__xvm_pingTextField"] == null)
        {
            _root["__xvm_pingTextField"] = _root.createTextField("__xvm_pingTextField", 0,
                Config.s_config.hangar.pingServers.x, Config.s_config.hangar.pingServers.y, 100, 300);
            _root["__xvm_pingTextField"].antiAliasType = "advanced";
            _root["__xvm_pingTextField"].html = true;
            _root["__xvm_pingTextField"].selectable = false;
            _root["__xvm_pingTextField"].styleSheet = Utils.createStyleSheet(
                Utils.createCSS("xvm_ping", 0xCCCCCC, "$FieldFont", 10, "left", false, false));
        }

        //com.xvm.Logger.addObject(event);

        var str:Array = [];
        var res = JSONx.parse(event.str);
        for (var i in res)
        {
            var s = Utils.startsWith("WOT ", i) ? i.substring(4) : i;
            str.push(s + ": " + res[i])
        }
        str.sort();
        _root["__xvm_pingTextField"].htmlText = "<span class='xvm_ping'>" + str.join("\n") + "</span>";

        //com.xvm.Logger.add(str.join("\n"));
    }

}