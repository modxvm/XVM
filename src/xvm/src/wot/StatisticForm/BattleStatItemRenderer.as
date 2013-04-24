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

class wot.StatisticForm.BattleStatItemRenderer
{
    // override
    function updateData()
    {
        return this.updateDataImpl.apply(this, arguments);
    }

    // override
    function updateState()
    {
        return this.updateStateImpl.apply(this, arguments);
    }

    /////////////////////////////////////////////////////////////////

    private var wrapper:net.wargaming.BattleStatItemRenderer;
    private var base:net.wargaming.BattleStatItemRenderer;

    /////////////////////////////////////////////////////////////////

    static var DEBUG_TIMES = false;

    public static var s_winChances:WinChances = null;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    public function BattleStatItemRenderer(wrapper:net.wargaming.BattleStatItemRenderer, base:net.wargaming.BattleStatItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("StatisticForm");

        if (s_winChances == null)
            s_winChances = new WinChances();

        wrapper.col3.html = true;
        wrapper.col3._y = 0;
        wrapper.col3._height = wrapper._height;
        wrapper.col3.verticalAlign = "center";
        wrapper.col3.verticalAutoSize = true;

        GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener("stat_loaded", wrapper, updateData);

        Config.LoadConfig("BattleStatItemRenderer.as");
    }

    private function get team(): Number
    {
        return (wrapper.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }

    function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        wrapper.col3._width += 100;
        if (team == Defines.TEAM_ALLY)
        {
            wrapper.col3._x -= 100;
            //Logger.addObject(event.target);
        }
        if (!Config.s_config.battle.mirroredVehicleIcons)
        {
            if (team == Defines.TEAM_ENEMY)
            {
                wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
                wrapper.iconLoader._x -= 80 - 5; // FIXIT: where I can get image width?
                wrapper.col3._x += 5;
            }
        }
    }

    public function onConfigLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        s_winChances.showChances = Config.s_config.statisticForm.showChances;
        s_winChances.showExp = Config.s_config.statisticForm.showChancesExp;

        wrapper.col3.condenseWhite = true;
    }

    // override
    function updateDataImpl()
    {
        //Logger.add("updateData()");
        if (!wrapper.data)
        {
            base.updateData();
            return;
        }

        var start = new Date();

        wrapper.col3.condenseWhite = StatData.s_empty;
        
        var pname = Utils.GetNormalizedPlayerName(wrapper.data.label);
        Macros.RegisterPlayerData(pname, wrapper.data, team);

        var key = "SF/" + pname + "/" + (StatData.s_data[pname] ? StatData.s_data[pname].loadstate : "0");
        var saved_icon = wrapper.data.icon;
        var saved_label = wrapper.data.label;

        // Add data for Win Chance calculation
        //Logger.addObject(data);
        if (Config.s_config.rating.showPlayersStatistics) {
            if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
                StatLoader.AddPlayerData(wrapper.data, team);
            else
                StatData.s_data[pname].vehicleState = wrapper.data.vehicleState;
        }
        // Chance
        if (!StatData.s_empty && Config.s_config.statisticForm.showChances && wrapper.selected == true)
            s_winChances.showWinChances();

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(wrapper.iconLoader,
            [ wrapper.data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm), wrapper.data.icon ]);

        wrapper.data.icon = m_iconset.currentIcon;
        wrapper.data.label = Cache.Get("SF." + saved_label, function() { return Macros.Format(saved_label, "{{name}}") });

        // Player/clan icons
        attachClanIconToPlayer(wrapper.data);

        if (Config.s_config.statisticForm.removeSquadIcon && wrapper.squad)
            wrapper.squad._visible = false;

        base.updateData();

        wrapper.data.icon = saved_icon;
        wrapper.data.label = saved_label;
        var team = this.team;
        wrapper.col3.htmlText = Cache.Get(key, function() { return Macros.Format(saved_label,
            team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
            { }) } );

        if (DEBUG_TIMES)
        {
            Logger.add("DEBUG TIME: BattleStatItemRenderer[" + wrapper.data.label + "]: updateDataImpl(): " +
                Utils.elapsedMSec(start, new Date()) + " ms");
        }
    }

    // override
    function updateStateImpl()
    {
        base.updateState();

        if (Config.s_config.battle.highlightVehicleIcon == false && (wrapper.selected || wrapper.data.squad > 10))
        {
            var tr = new flash.geom.Transform(wrapper.iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(
                (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0 ? "normal" : "normal_dead").transform;
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
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80 - 5;
            m_clanIcon = PlayerInfo.createIcon(wrapper, cfg, x, wrapper.iconLoader._y, team);
        }
        PlayerInfo.setSource(m_clanIcon, data.label, data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
}
