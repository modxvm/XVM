import com.xvm.Wrapper;

class wot.wrapper.crew.tankmen.Crew extends net.wargaming.tankmen.Crew
{
    function Crew()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setTankmen"
        ];
        Wrapper.override(this, new wot.crew.tankmen.Crew(this, super), OVERRIDE_FUNCTIONS);
    }
}
