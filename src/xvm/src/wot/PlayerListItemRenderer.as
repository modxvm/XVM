/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Iconset;
import wot.utils.Defines;
import wot.utils.PlayerInfo;

class wot.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
  var m_clanIcon: MovieClip = null;
  var m_iconset: Iconset;
  
  function PlayerListItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "PlayerListItemRenderer") == -1)
      _global.xvm.push("PlayerListItemRenderer");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "PlayerListItemRenderer.as");
  }

  private function get team(): Number
  {
    return (this.owner._itemRenderer == "LeftItemRendererIcon") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  function completeLoad()
  {
    if (!Config.s_config.battle.mirroredVehicleIcons && team == Defines.TEAM_ENEMY)
    {
      icon._xscale = -icon._xscale;
      icon._x -= icon.width;
      this.vehicleLevel._x = icon._x + 15;
    }
  }

  // override
  function update()
  {
    if (data)
    {
      // Alternative icon set
      m_iconset = new Iconset(iconLoader, [
        data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel),
        data.icon ], completeLoad);
      data.icon = m_iconset.currentIcon;

      // Player/clan icons
      var cfg = Config.s_config.playersPanel.clanIcon;
      if (cfg.show)
        XVMClanIcon(cfg);
    }

    if (Config.s_config.playersPanel.removeSquadIcon && squadIcon)
      squadIcon._visible = false;

    super.update();
  }
  
  function XVMClanIcon(cfg)
  {
    var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : "");
    if (!m_clanIcon)
    {
      var x = (!_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
        ? iconLoader._x : iconLoader._x + iconLoader.width;
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
