/**
 * ...
 * @author sirmax2
 */
import wot.battleloading.TipField;
import wot.battleloading.RealClock;
import wot.battleloading.WinChances;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatsLogger;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.battleloading.BattleLoading extends net.wargaming.BattleLoading
{
    private static var STAT_PRELOAD_DELAY:Number = 1000;

    // Components
    private var winChances:WinChances;
    private var tipField:TipField;
    private var realClock:RealClock;

    public function BattleLoading()
    {
        super();

        Utils.TraceXvmModule("BattleLoading");

        StatData.s_loaded = false;
        StatData.s_data = {};
        StatLoader.s_players_count = 0;
        StatLoader.teams = { t1:0, t2:0 };

        // Components
        winChances = new WinChances(form_mc); // Winning chance info above players list.
        tipField   = new TipField(form_mc);   // Information field below players list.
        realClock  = new RealClock(form_mc);  // Realworld time at right side of TipField.

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("BattleLoading.as");
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
    }

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);
        if (Config.s_config.rating.enableStatisticsLog == true)
            StatsLogger.saveStatistics("setup", StatData.s_data);
    }

    // override
    function setSize(width, height)
    {
        super.setSize(width, height);
        (new LoadVars()).load(Defines.COMMAND_VAR + " window_size=" + width + "," + height);
    }

    // override
    function setMapBG(imgsource:String)
    {
        /**
         * imgsource arg:
         * ../maps/icons/map/screen/19_monastery.png
         */

        /** Extract map name from image source */
        var arr:Array = imgsource.split("/");
        arr = arr[5].split(".");
        var mapName:String = arr[0]; // 45_north_america

        /**
         * Save map name for Minimap mod.
         * Best method to define map size without Python so far.
         */
        (new LoadVars()).load(Defines.COMMAND_VAR + " map_name=" + mapName);

        super.setMapBG(imgsource);
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        traceToProxyTerminal();

        if (Config.s_config.rating.showPlayersStatistics)
            loadStatistics();
    }

    private static function loadStatistics(loop)
    {
        if (!loop)
          loop = 0;
        // Force stats loading after 0.5 sec if enabled (for 12x12 battles, FogOfWar, ...)
        _global.setTimeout
        (
            function() {
                if (!StatData.s_loaded) {
                    if (StatLoader.teams.t1 == 0 /*&& StatLoader.teams.t2 == 0*/) { // t2 disabled because of FogOfWar
                        if (loop * BattleLoading.STAT_PRELOAD_DELAY > 10000) { // 10 sec
                            Logger.add("WARNING: no players data after 10 sec, skip stats loading");
                        } else {
                            Logger.add("[" + loop  + "] no players data, waiting more");
                            BattleLoading.loadStatistics(loop + 1);
                        }
                    }
                    else {
                        Logger.add("[BattleLoading] loading stat data (" + StatLoader.s_players_count + " players)");
                        StatLoader.StartLoadData(Defines.COMMAND_RUN);
                    }
                }
            },
            STAT_PRELOAD_DELAY
        );
    }

    private function traceToProxyTerminal()
    {
        Logger.add("[BattleLoading]\n" +
                "    XVM_VERSION=" + Defines.XVM_VERSION + "\n" +
                "    MAX_PATH=" + Defines.MAX_PATH + "\n" +
                "    GameRegion=" + Config.s_game_region + "\n" +
                "    configVersion=" + Config.s_config.configVersion + "\n" +
                "    showPlayersStatistics=" + Config.s_config.rating.showPlayersStatistics + "\n" +
                "    loadEnemyStatsInFogOfWar=" + Config.s_config.rating.loadEnemyStatsInFogOfWar + "\n" +
                "    useStandardMarkers=" + Config.s_config.battle.useStandardMarkers);
    }
}