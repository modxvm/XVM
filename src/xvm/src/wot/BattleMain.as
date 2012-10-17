/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Utils;
import wot.SixthSenseIndicator;

class wot.BattleMain
{
    static var instance: BattleMain;
    var sixthSenseIndicator:SixthSenseIndicator;

    //static var minimap;
    //static var timerBig;
    //static var leftPanel;
    //static var rightPanel;
    //static var debugPanel;
    //static var playerMessangersPanel;
    //static var vehicleMessagesPanel;
    //static var damagePanel;
    //static var statHidden;

    private static var dummy = Logger.dummy;

    private static var width, height;
    
    static function main()
    {
        Utils.TraceXvmModule("Battle:main");

        GlobalEventDispatcher.addEventListener("config_loaded", BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
        Config.LoadConfig("BattleMain.as");

        instance = new BattleMain();
        gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
        gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
        gfx.io.GameDelegate.addCallBack("battle.arenaData", instance, "setArenaData");
//        gfx.io.GameDelegate.addCallBack("battle.showStatus", instance, "showFinalStatus"); // dialog is not exist since WoT 0.8.0
    }

    private static function BattleMainConfigLoaded()
    {
        //Logger.add("BattleMainConfigLoaded()");

        GlobalEventDispatcher.removeEventListener("config_loaded", BattleMainConfigLoaded);

        // Initialize Sixth Sense Indicator
        instance.sixthSenseIndicator = new SixthSenseIndicator();

        // Setup Visual Elements
        SetupElements();

        // Show Clocks
        ShowClock(Config.s_config.battle.clockFormat);
    }

    private static function SetupElements()
    {
        if (!Config.s_loaded || !width || !height)
            return;
        var cfg = Config.s_config.battle.elements;
        for (var i in cfg)
        {
            if (_root[i] != null)
                SetupElement(_root[i], Config.s_config.battle.elements[i], i);
            else
                Logger.add("Warning: Visual Element not found: " + i);
        }
    }

    private static var colors:Array = [ 0xFFFFFF, 0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF, 0xFF00FF ];
    private static function SetupElement(mc:MovieClip, cfg, name)
    {
        //Logger.add(width + "x" + height);
        /*if (!isNaN(cfg.x))
            mc._x = cfg.x;
        if (!isNaN(cfg.y))
            mc._y = cfg.y;*/
        if (cfg.debug == true)
        {
            with (mc)
            {
                var x = mc._x;
                var y = mc._y;
                var w = mc._width;
                var h = mc._height;
                var c = colors[colors.length * Math.random()];
                beginFill(0, 0);
                lineStyle(1, c, 100);
                moveTo(0, 0);
                lineTo(w, 0);
                lineTo(w, h);
                lineTo(0, h);
                lineTo(0, 0);
                endFill();
                var t: TextField = createTextField("t", getNextHighestDepth(), w / 2 - 50,  h / 2 - 10, 100, 40);
                t.setNewTextFormat(new TextFormat("Small Fonts", 8, c, false, false, false, null, null, "center"));
                t.filters = [new flash.filters.DropShadowFilter(0, 0, 0, 100, 4, 4, 2, 3)];
                t.multiline = true;
                t.text = name + "\n" + mc._x + "x" + mc._y + "+" + mc._width + "," + mc._height;
            }
        }
    }
    
    private static function ShowClock(format)
    {
        if (!format || format == "")
            return;
        var fgMC = _root.debugPanel.fgMC;
        var lag = fgMC.lag;
        var fps = fgMC.fps;
        var clock: TextField = fgMC.createTextField("clock", fgMC.getNextHighestDepth(),
            lag._x + lag._width, fps._y, 300, fps._height);
        clock.antiAliasType = "advanced";
        var tf: TextFormat = fps.getNewTextFormat();
        tf.align = "left";
        clock.setNewTextFormat(tf);
        clock.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5, 3)];
        setInterval(function() { clock.text = Utils.FormatDate(format, new Date()) }, 1000);
    }

    function showPostmortemTips(movingUpTime, showTime, movingDownTime)
    {
        //Logger.add("Battle::showPostmortemTips");
        if (Config.s_config.battle.showPostmortemTips)
            _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
    }

    function setArenaData(mapText, battleType, battleName, team1name, team2name, winText)
    {
        //Logger.add("Battle::setArenaData(" + mapText + ", " + battleType + ", " + battleName + ", " + team1name + ", " + team2name + ", " + winText + ")");
        _root.setArenaData(mapText, battleType, battleName, team1name, team2name, winText);
    }

    function onUpdateStage(width, height)
    {
        //Logger.add("Battle::onUpdateStage()");
        _root.onUpdateStage(width, height);
        BattleMain.width = width;
        BattleMain.height = height;
        SetupElements();
    }

    /* DISABLED - final dialog is not exist since WoT 0.8.0
    var finalStatusShown = false;
    function showFinalStatus(statusText)
    {
        if (finalStatusShown)
            return;

        //Logger.add("Battle::showFinalStatus(): " + statusText);

        _root.showFinalStatus(statusText);

        if (!_root.finalDialog || !_root.finalDialog.form)
            return;

        finalStatusShown = true;

        if (!StatData.s_loaded || !Config.s_config.rating.showPlayersStatistics || !Config.s_config.statisticForm.showChances)
            return;

        for (var i = 0; i < _root.statsData.team1.length; ++i)
        {
            var data = _root.statsData.team1[i];
            var pname = data.label.toUpperCase();
            if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
            {
                StatLoader.AddPlayerData(data.uid, data.label, data.vehicle, data.icon,
                    _root.statsData.playerTeam == "team1" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
            }
        }

        for (var i = 0; i < _root.statsData.team2.length; ++i)
        {
            var data = _root.statsData.team2[i];
            var pname = data.label.toUpperCase();
            if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
            {
                StatLoader.AddPlayerData(data.uid, data.label, data.vehicle, data.icon,
                    _root.statsData.playerTeam == "team1" ? Defines.TEAM_ENEMY : Defines.TEAM_ALLY);
            }
        }

        //Logger.addObject(_root.finalDialog.form.form, "form", 2);

        var t: TextField = null;
        for (var i in _root.finalDialog.form.form)
        {
            if (!Utils.startsWith("instance", i))
                continue;
            var v = _root.finalDialog.form.form[i];
            if (v instanceof TextField)
            {
                t = v;
                break;
            }
        }

        if (t)
        {
            t.html = true;
            t.text = "";
            Chance.ShowChance(t, Config.s_config.statisticForm.showChancesExp);
        }
    }
    */
}
