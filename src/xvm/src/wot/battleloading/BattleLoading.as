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
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.battleloading.BattleLoading extends net.wargaming.BattleLoading
{
    private static var STAT_PRELOAD_DELAY:Number = 3000; // TODO - sometimes it happens before all items added in BattleLoadingItemRenderer7
    
    // Components
    private var winChances:WinChances;
    private var tipField:TipField;
    private var realClock:RealClock;

    public function BattleLoading()
    {
        super();

        Utils.TraceXvmModule("BattleLoading");

        // Components
        winChances = new WinChances(form_mc); // Winning chance info above players list.
        tipField   = new TipField(form_mc);   // Information field below players list.
        realClock  = new RealClock(form_mc);  // Realworld time at right side of TipField.
        
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        
        Config.LoadConfig("BattleLoading.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        traceToProxyTerminal();

        if (Config.s_config.rating.showPlayersStatistics)
            loadStatistics();
    }
    
    private function loadStatistics()
    {
        // Force stats loading after 0.5 sec if enabled (for 12x12 battles, FogOfWar, ...)
        _global.setTimeout
        (
            function() {
                if (!StatData.s_loaded)
                    StatLoader.StartLoadData(Defines.COMMAND_RUN);
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
                "    showPlayersStatistics=true\n" +
                "    loadEnemyStatsInFogOfWar=" + Config.s_config.rating.loadEnemyStatsInFogOfWar + "\n" +
                "    useStandardMarkers=" + Config.s_config.battle.useStandardMarkers);
    }  
}