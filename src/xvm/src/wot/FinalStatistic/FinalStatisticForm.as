import wot.utils.Logger;

class wot.FinalStatistic.FinalStatisticForm extends net.wargaming.hangar.FinalStatistic.FinalStatisticForm
{
//    var _parent, __arenaUniqueId, tabs_mc, view_mc, vehicleSelector, __get__arenaUniqueId, __get__data;
    function FinalStatisticForm()
    {
        super();
        Logger.add("FinalStatisticForm::ctor()");
    }
    function setCommonData(data)
    {
        Logger.addObject(data, "FinalStatisticForm::setCommonData(data)", 3);
        super.setCommonData(data);
    }
}
