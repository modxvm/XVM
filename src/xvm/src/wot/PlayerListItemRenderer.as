/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.PlayerInfo;
import wot.utils.Logger;

class wot.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
  var m_clanIcon: MovieClip = null;

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

  // override
  function errorLoad(event)
  {
    if (event.target.source)
    {
      // Fallback to default icon
      event.target.source = (Config.s_config.iconset.playersPanel != Defines.CONTOUR_ICON_PATH)
        ? event.target.source.split(Config.s_config.iconset.playersPanel).join(Defines.CONTOUR_ICON_PATH)
        : event.target.source = Defines.CONTOUR_ICON_PATH + "noImage.tga";
    }
  }

  // override
  private var _iconLoaded = false;
  function completeLoad(event)
  {
    var icon = event.target;
    if (!_iconLoaded)
    {
      _iconLoaded = true;
      if (!Config.s_config.battle.mirroredVehicleIcons && team == Defines.TEAM_ENEMY)
      {
        icon._xscale = -icon._xscale;
        icon._x -= icon.width;
        this.vehicleLevel._x = icon._x + 15;
      }
    }
    icon.visible = true;
  }

  // override
  function update()
  {
    if (data)
    {
      // Alternative icon set
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel);

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
    var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : null);
    if (!pinfo && m_clanIcon)
    {
      m_clanIcon.removeMovieClip();
      delete m_clanIcon;
      m_clanIcon = null;
    }
    else if (pinfo)
    {
      if (!m_clanIcon)
      {
        var x = (!_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
          ? iconLoader._x : iconLoader._x + iconLoader.width;
        m_clanIcon = PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo, cfg, x, iconLoader._y, team);
      }
      else if (pinfo.icon != m_clanIcon.clanIcon.source)
        m_clanIcon.clanIcon.source = pinfo.icon;

      m_clanIcon._alpha = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0) ? 100 : 50;
    }
  }
}
