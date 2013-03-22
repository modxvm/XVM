/**
 * ...
 * @author sirmax2
 */
import wot.utils.Logger;
import net.wargaming.controls.UILoaderAlt;
import wot.PlayersPanel.SpotStatusView;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.IconLoader;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

class wot.PlayersPanel.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
    private static var IS_ALIVE:Number = 1;
    
    var m_clanIcon: UILoaderAlt = null;
    var m_iconset: IconLoader = null;
    var m_iconLoaded: Boolean = false;

    var spotStatusView:SpotStatusView;

    function PlayerListItemRenderer()
    {
        super();
        
        //Logger.add("this.owner._itemRenderer " + this.owner._itemRenderer);
        if (team == Defines.TEAM_ENEMY)
        {
            //Logger.add("Rend: team " + team);
            spotStatusView = new SpotStatusView(this);
        }

        Utils.TraceXvmModule("PlayerListItemRenderer");
    }

    function completeLoad()
    {
        if (m_iconLoaded)
            return;
        m_iconLoaded = true;

        mirrorEnemyIcons();
        
        iconLoader._visible = true;
    }
    
    private function mirrorEnemyIcons():Void
    {
        if (!Config.s_config.battle.mirroredVehicleIcons && team == Defines.TEAM_ENEMY)
        {
            iconLoader._xscale = -iconLoader._xscale;
            iconLoader._x -= 80;
            this.vehicleLevel._x = iconLoader._x + 15;
        }
    }

    // override
    function __getColorTransform(schemeName)
    {
        //wot.utils.Logger.add("data.squad=" + data.squad + " " + data.label + " scheme=" + schemeName);

        if (Config.s_config.battle.highlightVehicleIcon == false)
        {
            if (schemeName == "selected" || schemeName == "squad")
                schemeName = "normal";
            else if (schemeName == "selected_dead" || schemeName == "squad_dead")
                schemeName = "normal_dead";
        }

        return super.__getColorTransform(schemeName);
    }

    // override
    function update()
    {
        var saved_icon = data ? data.icon : null;
        if (data)
        {
            // Alternative icon set
            if (!m_iconset)
                m_iconset = new IconLoader(this, completeLoad);
            m_iconset.init(iconLoader,
                [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel), data.icon ]);
            data.icon = m_iconset.currentIcon;

            // Player/clan icons
            attachClanIconToPlayer(data);
            
            if (spotStatusView) /** spotStatusView == null is panel is allied */
            {
                spotStatusView.tryCreateSpotMarker();
            }
        }

        if (Config.s_config.playersPanel.removeSquadIcon && squadIcon)
            squadIcon._visible = false;

        super.update();

        if (data)
            data.icon = saved_icon;
    }

    private function attachClanIconToPlayer(data):Void
    {
        var cfg = Config.s_config.playersPanel.clanIcon;
        if (!cfg.show)
            return;

        if (m_clanIcon == null)
        {
            var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
                ? iconLoader._x : iconLoader._x + 80;
            m_clanIcon = PlayerInfo.createIcon(this, cfg, x, iconLoader._y, team);
        }
        PlayerInfo.setSource(m_clanIcon, data.label, data.clanAbbrev);
        m_clanIcon["holder"]._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
    
    private function get team(): Number
    {
        if (this.owner._itemRenderer == undefined)
        {
            //Logger.add("## PlayerListItemRenderer ERROR: this.owner._itemRenderer == undefined");
        }
        return (this.owner._itemRenderer == "LeftItemRendererIcon") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
    }
}
