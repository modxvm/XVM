/**
 * @author LEMAXHO
 */
import com.xvm.Utils;
import wot.crew.CrewLoader;

class wot.crew.tankmen.Crew
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.tankmen.Crew;
    private var base:net.wargaming.tankmen.Crew;

    public function Crew(wrapper:net.wargaming.tankmen.Crew, base:net.wargaming.tankmen.Crew)
    {
        this.wrapper = wrapper;
        this.base = base;
        CrewCtor();
    }

    function setTankmen()
    {
        return this.setTankmenImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private function CrewCtor()
    {
        Utils.TraceXvmModule("Crew");
    }

    function setTankmenImpl(data)
    {
        base.setTankmen(data);
        //com.xvm.Logger.addObject(wrapper.list, "list", 2);
        CrewLoader.s_defaultCrew = wrapper.list._dataProvider; // save the crewlist
    }
}
