import com.xvm.Wrapper;

class wot.wrapper.FinalStatistic.TeamStats extends net.wargaming.hangar.FinalStatistic.TeamStats
{
    function TeamStats()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "configUI"
        ];
        Wrapper.override(this, new wot.FinalStatistic.TeamStats(this, super), OVERRIDE_FUNCTIONS);
    }
}
