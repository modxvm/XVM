import com.xvm.Wrapper;

class wot.wrapper.FinalStatistic.DetailsBlock extends net.wargaming.hangar.FinalStatistic.view.DetailsBlock
{
    function DetailsBlock()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "draw"
        ];
        Wrapper.override(this, new wot.FinalStatistic.DetailsBlock(this, super), OVERRIDE_FUNCTIONS);
    }
}
