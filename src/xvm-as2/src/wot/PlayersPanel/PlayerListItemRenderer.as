/**
 * @author sirmax2
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.IconLoader;
import com.xvm.PlayerInfo;
import com.xvm.Utils;
import net.wargaming.controls.UILoaderAlt;
import wot.PlayersPanel.SpotStatusView;

class wot.PlayersPanel.PlayerListItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.ingame.PlayerListItemRenderer;
    private var base:net.wargaming.ingame.PlayerListItemRenderer;

    public function PlayerListItemRenderer(wrapper:net.wargaming.ingame.PlayerListItemRenderer, base:net.wargaming.ingame.PlayerListItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;
        wrapper.xvm_worker = this;
        PlayerListItemRendererCtor();
    }

    function __getColorTransform()
    {
        return this.__getColorTransformImpl.apply(this, arguments);
    }

    function update()
    {
        return this.updateImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private static var IS_ALIVE:Number = 1;

    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    public var spotStatusView:SpotStatusView;

    public function PlayerListItemRendererCtor()
    {
        Utils.TraceXvmModule("PlayersPanel");

        spotStatusView = new SpotStatusView(this);
    }

    function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        mirrorEnemyIcons();

        wrapper.iconLoader._visible = true;
    }

    private function mirrorEnemyIcons():Void
    {
        if (!Config.s_config.battle.mirroredVehicleIcons && this.team == Defines.TEAM_ENEMY)
        {
            wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
            wrapper.iconLoader._x -= 80;
            wrapper.vehicleLevel._x = wrapper.iconLoader._x + 15;
        }
    }

    function __getColorTransformImpl(schemeName)
    {
        //com.xvm.Logger.add("data.squad=" + data.squad + " " + data.label + " scheme=" + schemeName);

        if (Config.s_config.battle.highlightVehicleIcon == false)
        {
            if (schemeName == "selected" || schemeName == "squad")
                schemeName = "normal";
            else if (schemeName == "selected_dead" || schemeName == "squad_dead")
                schemeName = "normal_dead";
        }

        return base.__getColorTransform(schemeName);
    }

    function updateImpl()
    {
        var saved_icon = wrapper.data ? wrapper.data.icon : null;
        if (wrapper.data)
        {
            // Alternative icon set
            if (!m_iconset)
                m_iconset = new IconLoader(this, completeLoad);
            m_iconset.init(wrapper.iconLoader,
                [ wrapper.data.icon.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT + ((this.team == Defines.TEAM_ALLY)
                ? Config.s_config.iconset.playersPanelAlly
                : Config.s_config.iconset.playersPanelEnemy)), wrapper.data.icon ]);
            wrapper.data.icon = m_iconset.currentIcon;

            // Player/clan icons
            attachClanIconToPlayer(wrapper.data);
        }

        if (Config.s_config.playersPanel.removeSquadIcon && wrapper.squadIcon)
            wrapper.squadIcon._visible = false;

        base.update();

        if (wrapper.data)
            wrapper.data.icon = saved_icon;
    }

    private function attachClanIconToPlayer(data):Void
    {
        var cfg = Config.s_config.playersPanel.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (this.team == Defines.TEAM_ALLY))
                ? wrapper.iconLoader._x : wrapper.iconLoader._x + 80;
            m_clanIcon = PlayerInfo.createIcon(wrapper, "clanicon", cfg, x, wrapper.iconLoader._y, this.team);
        }
        PlayerInfo.setSource(m_clanIcon, Utils.GetPlayerName(data.userName), data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }

    private function get team(): Number
    {
        return (wrapper._parent._parent._itemRenderer == "LeftItemRendererIcon") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
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
  "label": "M_r_A[RISER]"
}*/