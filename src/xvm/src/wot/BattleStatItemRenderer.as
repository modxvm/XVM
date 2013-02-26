/**
 * ...
 * @author sirmax2
 */
import net.wargaming.controls.UILoaderAlt;
import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.IconLoader;
import wot.utils.Logger;
import wot.utils.Macros;
import wot.utils.PlayerInfo;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
    static var DEBUG_TIMES = false;

    public static var s_chanceField: TextField = null;
    public static var s_chanceText: String;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    function BattleStatItemRenderer()
    {
        super();

        Utils.TraceXvmModule("BattleStatItemRenderer");
        
        col3.html = true;
        col3._y = 0;
        col3._height = _height;
        col3.verticalAlign = "center";
        col3.verticalAutoSize = true;

        GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener("stat_loaded", this, updateData);
        Config.LoadConfig("BattleStatItemRenderer.as");
    }

    private function get team(): Number
    {
        return (this.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }

    function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        col3._width += 100;
        if (team == Defines.TEAM_ALLY)
        {
            col3._x -= 100;
            //Logger.addObject(event.target);
        }
        if (!Config.s_config.battle.mirroredVehicleIcons)
        {
            if (team == Defines.TEAM_ENEMY)
            {
                iconLoader._xscale = -iconLoader._xscale;
                iconLoader._x -= 80 - 5; // FIXIT: where I can get image width?
                col3._x += 5;
            }
        }
    }

    public function onConfigLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        col3.condenseWhite = !Config.s_config.rating.showPlayersStatistics;
    }

    // override
    private static var s_setChanceFieldDataAdded = false;
    function updateData()
    {
        if (!data)
        {
            super.updateData();
            return;
        }

        var start = new Date();

        // Chance
        if (StatData.s_loaded && Config.s_config.statisticForm.showChances && !s_setChanceFieldDataAdded)
        {
            s_setChanceFieldDataAdded = true;
            var timer = _global.setTimeout(function() { BattleStatItemRenderer.SetChanceFieldData(); }, 50);
        }

        var pname = Utils.GetNormalizedPlayerName(data.label);
        Macros.RegisterPlayerData(pname, data);

        var key = "SF/" + pname + "/" + (StatData.s_data[pname] ? StatData.s_data[pname].loadstate : "0");
        var saved_icon = data.icon;
        var saved_label = data.label;

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(iconLoader,
            [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm), data.icon ]);

        data.icon = m_iconset.currentIcon;
        data.label = Cache.Get("SF." + saved_label, function() { return Macros.Format(saved_label, "{{name}}") });

        // Player/clan icons
        attachClanIconToPlayer(data);

        if (Config.s_config.statisticForm.removeSquadIcon && squad)
            squad._visible = false;

        super.updateData();

        data.icon = saved_icon;
        data.label = saved_label;
        var team = this.team;
        col3.htmlText = Cache.Get(key, function() { return Macros.Format(saved_label,
            team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
            { }) } );

        if (DEBUG_TIMES)
        {
            Logger.add("DEBUG TIME: BattleStatItemRenderer[" + data.label + "]: updateData(): " +
                Utils.elapsedMSec(start, new Date()) + " ms");
        }
    }

    private static function SetChanceFieldData()
    {
        //Logger.add("SetChanceFieldData()");
        s_setChanceFieldDataAdded = false;
        if (!s_chanceField)
        {
            s_chanceField = _root.statsDialog.battleText;
            s_chanceField.html = true;
            s_chanceField._width += 300;
            s_chanceField._x -= 150;
            s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.statisticForm.showChancesExp);
        }
        if (s_chanceField.htmlText != s_chanceText)
        {
            //Logger.add(s_chanceField.htmlText);
            s_chanceField.html = true;
            s_chanceField.htmlText = s_chanceText;
        }
    }

    // override
    function updateState()
    {
        super.updateState();

        if (Config.s_config.battle.highlightVehicleIcon == false && (selected || data.squad > 10))
        {
            var tr = new flash.geom.Transform(iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(
                (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0 ? "normal" : "normal_dead").transform;
        }
    }

    function attachClanIconToPlayer(data)
    {
        var cfg = Config.s_config.statisticForm.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
                ? iconLoader._x : iconLoader._x + 80 - 5;
            m_clanIcon = PlayerInfo.createIcon(this, cfg, x, iconLoader._y, team);
        }
        PlayerInfo.setSource(m_clanIcon, data.label, data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
}
