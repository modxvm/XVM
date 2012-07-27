/**
 * ...
 * @author sirmax2
 */
import wot.battleloading.TipField;
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

    public function BattleLoading()
    {
        super();

        Utils.TraceXvmModule("BattleLoading");
        
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
        Config.LoadConfig("BattleLoading.as");

        tipField = new TipField(form_mc);
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        traceToProxyTerminal();

        showClock(Config.s_config.battleLoading.clockFormat);
        
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

    private function setInfoFieldData(event)
    {
        //Logger.addObject(event, "SetInfoFieldData(event)");
        var info: TextField = form_mc.helpTip;
        var tip: TextField = form_mc.tipText;

        info.text = "XVM v" + Defines.XVM_VERSION + " ";

        if (event.ver && Utils.compareVersions(String(event.ver), Defines.XVM_VERSION) == 1)
        {
            info.textColor = 0x60FF60;
            info.text = "XVM: New version: v" + String(event.ver) + " (current is v" + Defines.XVM_VERSION + ")";
            if (event.message && event.message != "")
                setTipText(event.message);
        }

        if (event.warning != undefined)
        {
            info.textColor = 0xFFD040;
            if (event.warning != "")
                setTipText(event.warning);
        }

        if (event.error != undefined)
        {
            info.textColor = 0xFF4040;
            if (event.error != "")
                setTipText(event.error, true);
        }
    }

    private function setTipText(text, isError)
    {
        var tip: TextField = form_mc.tipText;
        var tf: TextFormat = tip.getNewTextFormat();
        tf.align = "left";
        tf.size = 12;
        tf.leading = 0;
        tip.setNewTextFormat(tf);
        tip.text = text;
        if (isError)
        {
            tf.color = 0xFF4040;
            var pos = text.indexOf(">>>");
            if (pos != -1)
                tip.setTextFormat(pos, pos + 3, tf);
            pos = text.indexOf("<<<");
            if (pos != -1)
                tip.setTextFormat(pos, pos + 3, tf);
        }
    }
    
    private function showClock(format)
    {
        if (!format || format == "")
            return;
        var f = form_mc.helpTip;
        var clock: TextField = form_mc.createTextField("xvm_clock", form_mc.getNextHighestDepth(), f._x, f._y, f._width, f._height);
        clock.antiAliasType = "advanced";
        var tf: TextFormat = f.getNewTextFormat();
        tf.color = 0xFFFFFF;
        tf.align = "right";
        clock.setNewTextFormat(tf);
        clock.filters = f.filters;
        setInterval(function() { clock.text = Utils.FormatDate(format, new Date()); }, 1000);
    }
}