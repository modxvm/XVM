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
import wot.crew.PingServers;

class wot.crew.tankmen.Crew extends net.wargaming.tankmen.Crew
{
    public function Crew()
    {
        super();

        Utils.TraceXvmModule("Crew");

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("Crew.as"); // required for localization
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        if (Config.s_config.hangar.pingServers.enabled == true)
            PingServers.StartPinging();
    }

    // override
    function setTankmen(data)
    {
        super.setTankmen(data);
        //com.xvm.Logger.addObject(list, "list", 2);
        CrewLoader.s_defaultCrew = list._dataProvider; // setting the crewlist
    }
	
} 
