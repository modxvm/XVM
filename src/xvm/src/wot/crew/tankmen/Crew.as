/**
 * @author LEMAXHO
 */
import wot.utils.Config;
import wot.utils.Utils;
import wot.crew.CrewLoader;

class wot.crew.tankmen.Crew extends net.wargaming.tankmen.Crew
{
    public function Crew()
    {
        super();

        Utils.TraceXvmModule("Crew");

        Config.LoadConfig("Crew.as"); // required for localization
    }

    // override
    function setTankmen(data)
    {
        super.setTankmen(data);
        //wot.utils.Logger.addObject(list, "list", 2);
        CrewLoader.s_defaultCrew = list._dataProvider; // setting the crewlist
    }
	
} 
