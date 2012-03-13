/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  function BattleLoadingItemRenderer()
  {
    super();
    vehicleField.html = true;
    Config.LoadConfig("XVM.xvmconf");
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");
    vehicleField._width += 80;
    if (this.owner._name == "team1List")
      vehicleField._x -= 113; // sirmax: why this value?
    if (!Config.s_config.battle.mirroredVehicleIcons)
    {
      if (this.owner._name == "team2List")
      {
        event.target._xscale = -event.target._xscale;
        event.target._x -= event.target.__width;
      }
    }
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
        wot.utils.Logger.add("[BattleLoading] Show Players Statistics = TRUE"); // Just to check config is loaded correctly
      }
      Stat.AddPlayerData(this, data.id, data.label, data.vehicle,
        this.owner._name == "team1List" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
      if (Stat.s_player_ids.length === 30)
        Stat.StartLoadData();
    }
    super.setData(data);
  }

  // override
  function update()
  {
    super.update();
    if (Config.s_config.rating.showPlayersStatistics && Config.s_config.rating.battleLoading.show)
    {
      if (data)
      {
        vehicleField.htmlText = Stat.DecorateField(data, data.vehicle,
          Config.s_config.rating.battleLoading.format,
          this.owner._name == "team1List" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
      }
    }
  }

  // update delegate (function name is fixed and cannot be changed)
  function XVMStatUpdateCallback(pdata)
  {
    if (Config.s_config.rating.battleLoading.show)
    {
      vehicleField.htmlText = Stat.DecorateField(pdata, pdata.originalText,
        Config.s_config.rating.battleLoading.format,
        pdata.team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
  }
}
