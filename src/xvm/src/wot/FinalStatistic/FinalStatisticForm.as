import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.StatData;
import com.xvm.StatLoader;
import com.xvm.StatsLogger;
import com.xvm.Utils;
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

        StatData.s_loaded = false;
        StatData.s_data = {};

        winChances = new WinChances(this);
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("FinalStatisticForm.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        processData();
    }

    private function processData()
    {
        if (!save_data_pending || !Config.s_loaded || data == null)
            return;

        save_data_pending = false;

        if (Config.s_config.rating.enableStatisticsLog == true)
            StatsLogger.saveStatistics("results", data);

        if (Config.s_config.rating.showPlayersStatistics && Config.s_config.finalStatistic.showChances)
        {
            var len = data.team1.length;
            for (var i = 0; i < len; ++i)
            {
                var d = data.team1[i];
                StatLoader.AddPlayerData(d, Defines.TEAM_ALLY);
            }

            len = data.team2.length;
            for (var i = 0; i < len; ++i)
            {
                var d = data.team2[i];
                StatLoader.AddPlayerData(d, Defines.TEAM_ENEMY);
            }

            StatLoader.StartLoadData();
        }
    }

    function setCommonData(data)
    {
        super.setCommonData(data);
        var page = parseInt(Config.s_config.finalStatistic.startPage);
        if (!isNaN(page) && page >= 1 && page <= 3)
            tabs_mc.selectedIndex = page - 1;
        save_data_pending = true;
        processData();
    }
}
