/**
 * ...
 * @author sirmax2
 */
import wot.battleloading.TipField;
import wot.battleloading.RealClock;
import wot.utils.Chance;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.battleloading.BattleLoading extends net.wargaming.BattleLoading
{
    private static var STAT_PRELOAD_DELAY:Number = 500;
    
    private static var s_chanceField: TextField = null;
    private static var s_chanceText: String;
    
    private var tipField:TipField;
    private var realClock:RealClock;

    public function BattleLoading()
    {
        super();

        Utils.TraceXvmModule("BattleLoading");
        
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
        Config.LoadConfig("BattleLoading.as");

        // Components
        tipField  = new TipField(form_mc);  // Information field below players list
        realClock = new RealClock(form_mc); // Realworld time at right side of TipField
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
            function() { StatLoader.StartLoadData(Defines.COMMAND_RUN); },
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

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        if (Config.s_config.battleLoading.showChances)
            showWinChances();
    }
    
    private function showWinChances()
    {
        if (!s_chanceField)
        {
            s_chanceField = form_mc.battleText;
            s_chanceField.html = true;
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
            s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.battleLoading.showChancesExp);
        }
        if (s_chanceField.htmlText != s_chanceText)
        {
            //wot.utils.Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }
}