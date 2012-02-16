/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.StatItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  function StatItemRenderer()
  {
    super();
    vehicleField.html = true;
    vehicleField._width += 20;
    Config.LoadConfig();
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");
    if (this.owner._name == "team1List")
      vehicleField._x -= 40; // why this value? (sirmax2)
    if (Config.bool("battle/disableMirroredVehicleIcons"))
    {
      if (this.owner._name == "team2List")
      {
        event.target._xscale = -event.target._xscale;
        event.target._x -= event.target.__width;
      }
    }
  }

  // override
  function setData(data)
  {
    //wot.utils.Logger.addObject(data, "data");
    if (data && Config.bool("rating/showPlayersStatistics"))
    {
      Stat.AddPlayerData(this, data.id, data.label, data.vehicle,
        this.owner._name == "team1List" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
      if (Stat.s_player_ids.length === 30 && !Stat.s_loaded) // FIXIT: Не будет работать с "туманом войны".
        Stat.LoadData();
    }
    super.setData(data);
  }

  // override
  function update()
  {
    super.update();
    if (Config.bool("rating/showPlayersStatistics") && Config.bool("rating/showAtBattleLoading", true))
    {
      if (data)
      {
        vehicleField.htmlText = Stat.DecorateRating(data.label, data.vehicle,
          this.owner._name == "team1List" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
      }
    }
  }

  // update delegate (function name is fixed and cannot be changed)
  function updateCallback(pdata)
  {
    if (Config.bool("rating/showAtBattleLoading", true))
    {
      vehicleField.htmlText = Stat.DecorateRating(pdata.name, pdata.originalText,
        pdata.team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
  }
}
