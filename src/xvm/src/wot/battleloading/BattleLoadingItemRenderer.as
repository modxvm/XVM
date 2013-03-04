/**
 * ...
 * @author sirmax2
 */
import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.IconLoader;
import wot.utils.Logger;
import wot.utils.Macros;
import wot.utils.StatLoader;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

// Renders one player, not a bulk.

class wot.battleloading.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
    private static var dummy = Logger.dummy; // avoid import warning

    private var m_iconset: IconLoader = null;
    private var m_clanIconLoaded = false;
    private var m_iconLoaded: Boolean = false;

    function BattleLoadingItemRenderer()
    {
        super();

        Utils.TraceXvmModule("BattleLoadingItemRenderer");

        vehicleField.html = true;
        vehicleField.verticalAlign = "center";
        vehicleField.verticalAutoSize = true;
        vehicleField.condenseWhite = true;
    }

    // override
    function setData(data)
    {
        // Process one player data.
        if (data)
        {
            addPlayerToStatLoadQueue(data);
            attachClanIconToPlayer(data);
        }

        // Remove squad icon.
        if (Config.s_config.battleLoading.removeSquadIcon && squad)
            squad._visible = false;

        super.setData(data);
    }

    function addPlayerToStatLoadQueue(data)
    {
        if (Config.s_config.rating.showPlayersStatistics)
        {
            StatLoader.AddPlayerData(data.id, data.label, data.vehicle, data.icon, team, selected, data.playerID);
            GlobalEventDispatcher.addEventListener("stat_loaded", this, StatLoadedCallback);
        }
    }

    function attachClanIconToPlayer(data)
    {
        if (m_clanIconLoaded)
            return;
        m_clanIconLoaded = true;

        var cfg = Config.s_config.battleLoading.clanIcon;
        if (!cfg.show)
            return;

        var icon = PlayerInfo.createIcon(this, cfg, iconLoader._x, iconLoader._y, team);
        PlayerInfo.setSource(icon, Utils.GetPlayerName(data.label), Utils.GetClanName(data.label));
    }

    private function get team(): Number
    {
        return (this.owner._name == "team1List") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }

    function completeLoad()
    {
        //Logger.add("completeLoad");
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        vehicleField._width += 80;
        if (team == Defines.TEAM_ALLY)
            vehicleField._x -= 113; // sirmax: why this value?
        else
            vehicleField._x += 5;
        if (!Config.s_config.battle.mirroredVehicleIcons)
        {
            if (team == Defines.TEAM_ENEMY)
            {
                iconLoader._xscale = -iconLoader._xscale;
                iconLoader._x -= 80;
                //Logger.add(iconLoader.width + "x" + iconLoader.height);
            }
        }
    }

    // override
    function setState()
    {
        super.setState();

        if (Config.s_config.battle.highlightVehicleIcon == false && (selected || data.squad > 10))
        {
            var tr = new flash.geom.Transform(iconLoader);
            tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(!disabled ? "normal" : "normal_dead").transform;
        }
    }

    // override
    function update()
    {
        if (!data)
        {
            super.update();
            return;
        }

        self_bg._visible = selected;

        onEnterFrame = function()
        {
            delete this.onEnterFrame;
            this.update2();
        }
    }

    function update2()
    {
        if (!data)
            return;

        //Logger.add("update2");

        Macros.RegisterPlayerData(Utils.GetNormalizedPlayerName(data.label), data);

        var saved_icon = data.icon;
        var saved_label = data.label;

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(iconLoader,
            [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading), data.icon ]);

        data.icon = m_iconset.currentIcon;
        data.label = Cache.Get("BL." + saved_label, function() { return Macros.Format(saved_label, "{{nick}}") });

        super.update();

        data.icon = saved_icon;
        data.label = saved_label;

        var key = "BL/" + saved_label;
        var team = this.team;
        vehicleField.htmlText = Cache.Get(key, function() { return Macros.Format(saved_label,
            team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
            { }) } );

        //Logger.add(vehicleField.htmlText);
    }

    // update delegate
    function StatLoadedCallback()
    {
        //Logger.add("StatLoaded(): " + data.label);

        GlobalEventDispatcher.removeEventListener("stat_loaded", this, StatLoadedCallback);

        var label = data.label;
        var team = this.team;
        vehicleField.condenseWhite = false;
        var key = "BL/" + label;
        Cache.Remove(key);
        vehicleField.htmlText = Cache.Get(key, function() { return Macros.Format(label,
            team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
            { }) } );

        //Logger.add(vehicleField.htmlText);
    }

}
