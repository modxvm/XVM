/**
 * ...
 * @author sirmax2
 */
import net.wargaming.controls.UILoaderAlt;
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.IconLoader;
import com.xvm.Logger;
import com.xvm.Macros;
import com.xvm.PlayerInfo;
import com.xvm.StatData;
import com.xvm.StatLoader;
import com.xvm.Utils;
import wot.StatisticForm.WinChances;

class wot.StatisticForm.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
    static var DEBUG_TIMES = false;

    public static var winChances:WinChances = null;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    function BattleStatItemRenderer()
    {
        super();

        Utils.TraceXvmModule("BattleStatItemRenderer");

        if (winChances == null)
            winChances = new WinChances();

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

        winChances.showChances = Config.s_config.statisticForm.showChances;
        winChances.showExp = Config.s_config.statisticForm.showChancesExp;

        col3.condenseWhite = true;
    }

    // override
    function updateData()
    {
        //Logger.add("updateData()");
        if (!data)
        {
            super.updateData();
            return;
        }

        var start = new Date();

        col3.condenseWhite = StatData.s_empty;
        
        var pname = Utils.GetNormalizedPlayerName(data.label);
        Macros.RegisterPlayerData(pname, data, team);

        var key = "SF/" + pname + "/" + (StatData.s_data[pname] ? StatData.s_data[pname].loadstate : "0");
        var saved_icon = data.icon;
        var saved_label = data.label;

        // Add data for Win Chance calculation
        //Logger.addObject(data);
        if (Config.s_config.rating.showPlayersStatistics) {
            if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
                StatLoader.AddPlayerData(data, team);
            else
                StatData.s_data[pname].vehicleState = data.vehicleState;
        }
        // Chance
        if (!StatData.s_empty && Config.s_config.statisticForm.showChances && this.selected == true)
            winChances.showWinChances();

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
