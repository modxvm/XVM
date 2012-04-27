/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.Stat;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

class wot.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  function BattleLoadingItemRenderer()
  {
    super();
    vehicleField.html = true;
    Config.LoadConfig("XVM.xvmconf");
  }

  private function get team(): Number
  {
    return (this.owner._name == "team1List") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  // override
  function errorLoad(event)
  {
    if (event.target.source)
    {
      // Fallback to default icon
      event.target.source = (Config.s_config.iconset.battleLoading != Defines.CONTOUR_ICON_PATH)
        ? event.target.source.split(Config.s_config.iconset.battleLoading).join(Defines.CONTOUR_ICON_PATH)
        : event.target.source = Defines.CONTOUR_ICON_PATH + "noImage.tga";
    }
  }

  // override
  private var _iconLoaded = false;
  function completeLoad(event)
  {
    if (!_iconLoaded)
    {
      _iconLoaded = true;
      vehicleField._width += 80;
      if (team == Defines.TEAM_ALLY)
        vehicleField._x -= 113; // sirmax: why this value?
      else
        vehicleField._x += 5;
      if (!Config.s_config.battle.mirroredVehicleIcons)
      {
        if (team == Defines.TEAM_ENEMY)
        {
          event.target._xscale = -event.target._xscale;
          event.target._x -= event.target.__width;
          //Logger.add(event.target.width + "x" + event.target.height);
        }
      }
    }
    event.target.visible = true;
  }

  // override
  private static var _logShown = false;
  private var _clanIconLoaded = false;
  function setData(data)
  {
    if (data)
    {
      // Add players for statistics loading
      if (Config.s_config.rating.showPlayersStatistics)
      {
        if (!_logShown)
        {
          _logShown = true;
          Logger.add("[BattleLoading] Show Players Statistics = true"); // Just to check config is loaded correctly
        }
        Stat.AddPlayerData(this, data.id, data.label, data.vehicle, data.icon, team);
        if (Stat.s_player_ids.length === 30)
          Stat.StartLoadData();
      }

      // Alternative icon set
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading);

      // Player/clan icons
      var cfg = Config.s_config.battleLoading.clanIcon;
      if (cfg.show && !_clanIconLoaded)
      {
        _clanIconLoaded = true;
        var pinfo = PlayerInfo.getPlayerInfo(Utils.GetPlayerName(data.label), Utils.GetClanName(data.label));
        if (pinfo)
          PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo.icon, cfg, iconLoader._x, iconLoader._y, team);
      }
    }

    if (Config.s_config.battleLoading.removeSquadIcon && squad)
      squad._visible = false;

    super.setData(data);
  }

  // override
  function update()
  {
    super.update();
    if (Config.s_config.rating.showPlayersStatistics)
    {
      if (data)
      {
        vehicleField.htmlText = Stat.DecorateField(data, data.vehicle,
          team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
          team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
      }
    }
  }

  // update delegate (function name is fixed and cannot be changed)
  function XVMStatUpdateCallback(pdata)
  {
    vehicleField.htmlText = Stat.DecorateField(pdata, pdata.originalText,
      pdata.team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
      pdata.team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
  }
}
