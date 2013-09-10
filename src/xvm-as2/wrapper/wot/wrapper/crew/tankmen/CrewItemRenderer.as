import com.xvm.Wrapper;

class wot.wrapper.crew.tankmen.CrewItemRenderer extends net.wargaming.tankmen.CrewItemRenderer
{
    function CrewItemRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI"
        ];
        Wrapper.override(this, new wot.crew.tankmen.CrewItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
