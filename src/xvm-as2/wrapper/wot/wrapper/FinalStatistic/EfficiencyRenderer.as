import com.xvm.Wrapper;

class wot.wrapper.FinalStatistic.EfficiencyRenderer extends net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer
{
    function EfficiencyRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "draw"
        ];
        Wrapper.override(this, new wot.FinalStatistic.EfficiencyRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
