import com.xvm.Wrapper;

class wot.wrapper.StatisticForm.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
    function BattleStatItemRenderer()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "updateData",
            "updateState"
        ];
        Wrapper.override(this, new wot.StatisticForm.BattleStatItemRenderer(this, super), OVERRIDE_FUNCTIONS);
    }
}
