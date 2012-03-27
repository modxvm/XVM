/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.Stat;
import wot.utils.VehicleInfo;

class wot.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  function BattleLoadingItemRenderer()
  {
    super();
    vehicleField.html = true;
    Config.LoadConfig("XVM.xvmconf");
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
      if (this.owner._name == "team1List")
        vehicleField._x -= 113; // sirmax: why this value?
      if (!Config.s_config.battle.mirroredVehicleIcons)
      {
        if (this.owner._name == "team2List")
        {
          event.target._xscale = -event.target._xscale;
          event.target._x -= event.target.__width - 5;
        }
      }
    }
    event.target.visible = true;
  }

  // override
  private static var _logShown = false;
  function setData(data)
  {
    if (data && Config.s_config.rating.showPlayersStatistics)
    {
      if (!_logShown)
      {
        _logShown = true;
        Logger.add("[BattleLoading] Show Players Statistics = TRUE"); // Just to check config is loaded correctly
      }
      Stat.AddPlayerData(this, data.id, data.label, data.vehicle, VehicleInfo.getInfo(data.icon),
        this.owner._name == "team1List" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
      if (Stat.s_player_ids.length === 30)
        Stat.StartLoadData();
    }
    
    // Alternative icon set
    if (data)
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading);

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
          this.owner._name == "team1List" ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
          this.owner._name == "team1List" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
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
