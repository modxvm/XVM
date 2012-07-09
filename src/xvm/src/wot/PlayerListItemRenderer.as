/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Iconset;
import wot.utils.Defines;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

class wot.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
  var m_clanIcon: MovieClip = null;
  var m_iconset: Iconset = null;
  var m_iconLoaded: Boolean = false;

  function PlayerListItemRenderer()
  {
    super();

    Utils.TraceXvmModule("PlayerListItemRenderer");
  }

  private function get team(): Number
  {
    return (this.owner._itemRenderer == "LeftItemRendererIcon") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  function completeLoad()
  {
    if (m_iconLoaded)
      return;
    m_iconLoaded = true;

    if (!Config.s_config.battle.mirroredVehicleIcons && team == Defines.TEAM_ENEMY)
    {
      iconLoader._xscale = -iconLoader._xscale;
      iconLoader._x -= 80;
      this.vehicleLevel._x = iconLoader._x + 15;
    }
    
    iconLoader._visible = true;
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
        m_iconset = new Iconset(this, completeLoad);
      m_iconset.init(iconLoader,
        [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel), data.icon ]);
      data.icon = m_iconset.currentIcon;

      // Player/clan icons
      var cfg = Config.s_config.playersPanel.clanIcon;
      if (cfg.show)
        XVMClanIcon(cfg);
    }

    if (Config.s_config.playersPanel.removeSquadIcon && squadIcon)
      squadIcon._visible = false;

    super.update();

    if (data)
      data.icon = saved_icon;
  }

  function XVMClanIcon(cfg)
  {
    var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : "");
    if (!m_clanIcon)
    {
      var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
        ? iconLoader._x : iconLoader._x + 80;
      m_clanIcon = PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo ? pinfo.icon : null, cfg, x, iconLoader._y, team);
    }
    if (!pinfo)
      m_clanIcon.clanIcon.source = null;
    else
    {
      if (pinfo.icon != m_clanIcon.clanIcon.source)
        m_clanIcon.clanIcon.source = pinfo.icon;
      m_clanIcon._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
  }
}
