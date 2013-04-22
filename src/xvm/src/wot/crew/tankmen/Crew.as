/**
 * @author LEMAXHO
 */
import com.xvm.JSONx;
import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Utils;
import wot.crew.CrewLoader;
import net.wargaming.utils.DebugUtils;

class wot.crew.tankmen.Crew extends net.wargaming.tankmen.Crew
{
    private var pingCommandCounter:Number;

    public function Crew()
    {
        super();

        Utils.TraceXvmModule("Crew");

        pingCommandCounter = 0;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("Crew.as"); // required for localization
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        if (Config.s_config.hangar.pingServers.enabled == true)
        {
            var me = this;
            var timer:Function = _global.setInterval(function() { me.ShowPing.call(me) }, Config.s_config.hangar.pingServers.updateInterval);
        }
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
            _root["__xvm_pingTextField"] = _root.createTextField("__xvm_pingTextField", _root.getNextHighestDepth(),
                Config.s_config.hangar.pingServers.x, Config.s_config.hangar.pingServers.y, 100, 300);
            _root["__xvm_pingTextField"].antiAliasType = "advanced";
            _root["__xvm_pingTextField"].html = true;
            _root["__xvm_pingTextField"].selectable = false;
            _root["__xvm_pingTextField"].styleSheet = Utils.createStyleSheet(
                Utils.createCSS("xvm_ping", 0xCCCCCC, "$FieldFont", 10, "left", false, false));
        }
        
        com.xvm.Logger.addObject(event);

        var str:Array = [];
        var res = JSONx.parse(event.str);
        for (var i in res)
            str.push(i + ": " + res[i])
        str.sort();
        _root["__xvm_pingTextField"].htmlText = "<span class='xvm_ping'>" + str.join("\n") + "</span>";

        //com.xvm.Logger.add(str.join("\n"));
    }
    
    // override
    function setTankmen(data)
    {
        super.setTankmen(data);
        //com.xvm.Logger.addObject(list, "list", 2);
        CrewLoader.s_defaultCrew = list._dataProvider; // setting the crewlist
    }
	
} 
