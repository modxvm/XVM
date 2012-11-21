import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.StatsLogger;
import wot.utils.Utils;
import wot.FinalStatistic.WinChances;

class wot.FinalStatistic.FinalStatisticForm extends net.wargaming.hangar.FinalStatistic.FinalStatisticForm
{
    private var save_data_pending:Boolean;

    // Components
    private var winChances:WinChances;

    function FinalStatisticForm()
    {
        super();

        Utils.TraceXvmModule("FinalStatistic");

        save_data_pending = false;

        winChances = new WinChances(this);
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("FinalStatisticForm.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        if (save_data_pending && Config.s_config.rating.enableStatisticsLog == true && data != null)
            StatsLogger.saveStatistics("results", data);
    }

    function setCommonData(data)
    {
        super.setCommonData(data);
        if (!Config.s_loaded)
            save_data_pending = true;
        else
        {
            if (Config.s_config.rating.enableStatisticsLog == true)
                StatsLogger.saveStatistics("results", data);
        }
    }
}
