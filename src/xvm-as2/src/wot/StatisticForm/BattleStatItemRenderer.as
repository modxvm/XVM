/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;
import net.wargaming.controls.*;
import net.wargaming.ingame.*;
import wot.StatisticForm.*;

class wot.StatisticForm.BattleStatItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.BattleStatItemRenderer;
    private var base:net.wargaming.BattleStatItemRenderer;

    public function BattleStatItemRenderer(wrapper:net.wargaming.BattleStatItemRenderer, base:net.wargaming.BattleStatItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;
        BattleStatItemRendererCtor();
    }

    function updateData()
    {
        return this.updateDataImpl.apply(this, arguments);
    }

    function updateState()
    {
        return this.updateStateImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private static var s_state:Number = 0;
    private static var s_winChances:WinChances = null;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    public function BattleStatItemRendererCtor()
    {
        Utils.TraceXvmModule("StatisticForm");

        if (s_winChances == null)
            s_winChances = new WinChances();

        wrapper.col3.html = true;
        wrapper.col3._y = 0;
        wrapper.col3._height = wrapper._height;
        wrapper.col3.verticalAlign = "center";
        wrapper.col3.verticalAutoSize = true;

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, wrapper, updateData);
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
        if (!Config.config.battle.mirroredVehicleIcons)
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
        if (s_state <= 0)
        {
            s_state = 1;
            s_winChances.showChances = Config.config.statisticForm.showChances;
            s_winChances.showLive = Config.config.statisticForm.showChancesLive;
            s_winChances.showBattleTier = Config.config.statisticForm.showBattleTier;
        }

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

        var dlg = _root.statsDialog;
        if (dlg == null)
            return;

        wrapper.col3.condenseWhite = Stat.s_empty;

        var name = Utils.GetPlayerName(wrapper.data.label);
        var saved_icon = wrapper.data.icon;
        var saved_label = wrapper.data.label;

        // Add data for Win Chance calculation
        //Logger.add(dlg.visible);
        //Logger.addObject(wrapper.data);
        if (Config.config.rating.showPlayersStatistics) {
            if (Stat.s_data[name] && Stat.s_data[name].stat)
                Stat.s_data[name].stat.alive = (wrapper.data.vehicleState & VehicleStateInBattle.IS_ALIVE) != 0;
        }
        // Chance
        if (!Stat.s_empty && (Config.config.statisticForm.showChances || Config.config.statisticForm.showBattleTier) && wrapper.selected == true)
            s_winChances.showWinChances();

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(wrapper.iconLoader,
            [ wrapper.data.icon.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT + ((team == Defines.TEAM_ALLY)
            ? Config.config.iconset.statisticFormAlly
            : Config.config.iconset.statisticFormEnemy)), wrapper.data.icon ]);

        wrapper.data.icon = m_iconset.currentIcon;
        wrapper.data.label = Cache.Get("SF." + saved_label, function() { return Macros.Format(saved_label, "{{name}}") });

        // Player/clan icons
        attachClanIconToPlayer(wrapper.data);

        if (Config.config.statisticForm.removeSquadIcon && wrapper.squad)
            wrapper.squad._visible = false;

        base.updateData();

        wrapper.data.icon = saved_icon;
        wrapper.data.label = saved_label;

        var team:Number = (wrapper.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;

        // Set Text Fields
        var c:String = "#" + Strings.padLeft(wrapper.textField.textColor.toString(16), 6, '0');

        var obj = BattleState.getUserData(name);
        var fmt:String = Macros.Format(saved_label, (team == Defines.TEAM_ALLY) ? Config.config.statisticForm.formatLeftNick : Config.config.statisticForm.formatRightNick, obj);
        wrapper.textField.htmlText = "<font color='" + c + "'>" + fmt + "</font>";

        fmt = Macros.Format(saved_label, (team == Defines.TEAM_ALLY) ? Config.config.statisticForm.formatLeftVehicle : Config.config.statisticForm.formatRightVehicle, obj);
        wrapper.col3.htmlText = "<font color='" + c + "'>" + fmt + "</font>";
    }

    // override
    function updateStateImpl()
    {
        base.updateState();

        if (Config.config.battle.highlightVehicleIcon == false && (wrapper.selected || wrapper.data.squad > 10))
        {
            var tr = new flash.geom.Transform(wrapper.iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(
                (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) != 0 ? "normal" : "normal_dead").transform;
        }
    }

    function attachClanIconToPlayer(data)
    {
        var cfg = Config.config.statisticForm.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80 - 5;
            m_clanIcon = PlayerInfo.createIcon(wrapper._parent._parent._parent, "clanicon_" + data.uid,
                cfg, x + wrapper._parent._parent._x + wrapper._parent._x + wrapper._x,
                wrapper.iconLoader._y + wrapper._parent._parent._y + wrapper._parent._y + wrapper._y,
                team);
        }
        PlayerInfo.setSource(m_clanIcon, Utils.GetPlayerName(data.userName), data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) != 0) ? 100 : 50;
    }
}
/*data: {
  "igrLabel": "",
  "uid": 7294494,
  "position": 7,
  "denunciations": 5,
  "userName": "M_r_A[RISER]",
  "icon": "../maps/icons/vehicle/contour/germany-G_Tiger.png",
  "teamKiller": false,
  "vehicleState": 3,
  "speaking": false,
  "VIP": false,
  "vipKilled": 0,
  "roster": 0,
  "frags": 0,
  "vehAction": 0,
  "vehicle": "G.W. Tiger",
  "team": "team2",
  "squad": 0,
  "level": 9,
  "himself": true,
  "vehId": 22644499,
  "isEnabledInRoaming": false,
  "muted": false,
  "isPostmortemView": true,
  "clanAbbrev": "RISER",
  "isIGR": false,
  "label": "Флаттершай - л.."
}*/
