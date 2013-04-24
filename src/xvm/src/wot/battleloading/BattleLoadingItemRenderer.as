/**
 * ...
 * @author sirmax2
 */
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.IconLoader;
import com.xvm.Logger;
import com.xvm.Macros;
import com.xvm.StatData;
import com.xvm.StatLoader;
import com.xvm.PlayerInfo;
import com.xvm.Utils;

// Renders one player, not a bulk.

class wot.battleloading.BattleLoadingItemRenderer
{
    /////////////////////////////////////////////////////////////////

    // override
    function setData()
    {
        return this.setDataImpl.apply(this, arguments);
    }

    // override
    function setState()
    {
        return this.setStateImpl.apply(this, arguments);
    }

    // override
    function update()
    {
        return this.updateImpl.apply(this, arguments);
    }

    /////////////////////////////////////////////////////////////////

    private var wrapper:net.wargaming.controls.LobbyPlayerListItemRenderer;
    private var base:net.wargaming.controls.LobbyPlayerListItemRenderer;

    /////////////////////////////////////////////////////////////////

    public function BattleLoadingItemRenderer(wrapper:net.wargaming.controls.LobbyPlayerListItemRenderer, base:net.wargaming.controls.LobbyPlayerListItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("BL");

        BattleLoadingItemRendererCtor();
    }

    /////////////////////////////////////////////////////////////////

    private var m_iconset: IconLoader = null;
    private var m_clanIconLoaded = false;
    private var m_iconLoaded: Boolean = false;

    private function BattleLoadingItemRendererCtor()
    {
        wrapper.vehicleField.html = true;
        wrapper.vehicleField.verticalAlign = "center";
        wrapper.vehicleField.verticalAutoSize = true;
        wrapper.vehicleField.condenseWhite = true;
    }

    // override
    function setDataImpl(data)
    {
        // Process one player data.
        if (data)
        {
            addPlayerToStatLoadQueue(data);
            attachClanIconToPlayer(data);
        }

        // Remove squad icon.
        if (Config.s_config.battleLoading.removeSquadIcon && wrapper.squad)
            wrapper.squad._visible = false;

        base.setData(data);
    }

    function addPlayerToStatLoadQueue(data)
    {
        if (!Config.s_config.rating.showPlayersStatistics)
            return;

        StatLoader.AddPlayerData(data, team);
        GlobalEventDispatcher.addEventListener("stat_loaded", this, StatLoadedCallback);
    }

    function attachClanIconToPlayer(data)
    {
        if (m_clanIconLoaded)
            return;
        m_clanIconLoaded = true;

        var cfg = Config.s_config.battleLoading.clanIcon;
        if (!cfg.show)
            return;

        var icon = PlayerInfo.createIcon(wrapper, cfg, wrapper.iconLoader._x, wrapper.iconLoader._y, team);
        PlayerInfo.setSource(icon, Utils.GetPlayerName(data.label), Utils.GetClanName(data.label));
    }

    private function get team(): Number
    {
        return (wrapper.owner._name == "team1List") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }

    function completeLoad()
    {
        //Logger.add("completeLoad");
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        wrapper.vehicleField._width += 80;
        if (team == Defines.TEAM_ALLY)
            wrapper.vehicleField._x -= 113; // sirmax: why this value?
        else
            wrapper.vehicleField._x += 5;
        if (!Config.s_config.battle.mirroredVehicleIcons)
        {
            if (team == Defines.TEAM_ENEMY)
            {
                wrapper.iconLoader._xscale = -wrapper.iconLoader._xscale;
                wrapper.iconLoader._x -= 80;
                //Logger.add(wrapper.iconLoader.width + "x" + wrapper.iconLoader.height);
            }
        }
    }

    // override
    function setStateImpl()
    {
        base.setState();

        if (Config.s_config.battle.highlightVehicleIcon == false && (wrapper.selected || wrapper.data.squad > 10))
        {
            var tr = new flash.geom.Transform(wrapper.iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(!wrapper.disabled ? "normal" : "normal_dead").transform;
        }
    }

    // override
    function updateImpl()
    {
        if (!wrapper.data)
        {
            base.update();
            return;
        }

        wrapper.self_bg._visible = wrapper.selected;

        var me = this;
        wrapper.onEnterFrame = function()
        {
            delete this.onEnterFrame;
            me.update2();
        }
    }

    function update2()
    {
        if (!wrapper.data)
            return;

        //Logger.add("update2");

        Macros.RegisterPlayerData(Utils.GetNormalizedPlayerName(wrapper.data.label), wrapper.data, team);

        var saved_icon = wrapper.data.icon;
        var saved_label = wrapper.data.label;

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(wrapper.iconLoader,
            [ wrapper.data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading), wrapper.data.icon ]);

        wrapper.data.icon = m_iconset.currentIcon;
        wrapper.data.label = Cache.Get("BL." + saved_label, function() { return Macros.Format(saved_label, "{{nick}}") });

        base.update();

        wrapper.data.icon = saved_icon;
        wrapper.data.label = saved_label;

        var key = "BL/" + saved_label;
        var team = this.team;
        wrapper.vehicleField.htmlText = Cache.Get(key, function() { return Macros.Format(saved_label,
            team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
            { }) } );

        //Logger.add(vehicleField.htmlText);
    }

    // update delegate
    function StatLoadedCallback()
    {
        //Logger.add("StatLoaded(): " + data.label);

        GlobalEventDispatcher.removeEventListener("stat_loaded", this, StatLoadedCallback);

        var label = wrapper.data.label;
        var team = this.team;
        wrapper.vehicleField.condenseWhite = StatData.s_empty;
        var key = "BL/" + label;
        Cache.Remove(key);
        wrapper.vehicleField.htmlText = Cache.Get(key, function() { return Macros.Format(label,
            team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
            { }) } );

        //Logger.add(vehicleField.htmlText);
    }

}
