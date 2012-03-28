/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.PlayerInfo;

class wot.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
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
        icon._x -= icon.__width;

        //if (!Config.s_config.battle.mirroredVehicleIcons)
        this.vehicleLevel._x = icon._x + 15;
      }
    }
    icon.visible = true;
  }

  // override
  private var _clanIconLoaded = false;
  function setData(data)
  {
    if (data)
    {
      // Player/clan icons
      if (!_clanIconLoaded)
      {
        _clanIconLoaded = true;
        var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : null);
        if (pinfo)
          PlayerInfo.createClanIcon(this, pinfo, iconLoader._x, iconLoader._y, team);
      }

      // Alternative icon set
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel);
    }

    super.setData(data);
  }
  
}
