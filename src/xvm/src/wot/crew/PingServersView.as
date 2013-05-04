import com.xvm.Config;
import com.xvm.JSONx;
import com.xvm.Utils;

class wot.crew.PingServersView
{
    public function showPingCallback(event)
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
        _root["__xvm_pingTextField"].htmlText = "<span class='xvm_ping'>" + Utils.fixImgTag(str.join("\n")) + "</span>";

        //com.xvm.Logger.add(str.join("\n"));
    }
}