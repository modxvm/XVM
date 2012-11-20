import wot.utils.StatsLogger;

class wot.FinalStatistic.FinalStatisticForm extends net.wargaming.hangar.FinalStatistic.FinalStatisticForm
{
//    var _parent, __arenaUniqueId, tabs_mc, view_mc, vehicleSelector, __get__arenaUniqueId, __get__data;
    function FinalStatisticForm()
    {
        super();
    }
	
    function setCommonData(data)
    {
		StatsLogger.saveStatistics("results", data);
        super.setCommonData(data);
    }
}
