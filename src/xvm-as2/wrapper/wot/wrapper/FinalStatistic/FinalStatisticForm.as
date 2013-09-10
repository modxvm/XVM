import com.xvm.Wrapper;

class wot.wrapper.FinalStatistic.FinalStatisticForm extends net.wargaming.hangar.FinalStatistic.FinalStatisticForm
{
    function FinalStatisticForm()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "setCommonData"
        ];
        Wrapper.override(this, new wot.FinalStatistic.FinalStatisticForm(this, super), OVERRIDE_FUNCTIONS);
    }
}
