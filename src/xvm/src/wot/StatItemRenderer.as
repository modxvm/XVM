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
    if (Config.value("battle/disableMirroredVehicleIcons/data") == "true")
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
    if (data)
    {
      if (Config.value("battle/showPlayerStatictics/data") == "true")
      {
        Stat.AddPlayerData(this, data.id, data.vehicle,
          this.owner._name == "team1List" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
      }
    }
    super.setData(data);
  }

  // override
  function update()
  {
    super.update();
    if (Config.value("battle/showPlayerStatictics/data") == "true")
    {
      if (data)
      {
        vehicleField.htmlText = Stat.Decorate(data.id, data.vehicle,
          this.owner._name == "team1List" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
      }
    }
  }

  // update delegate (function name is fixed and cannot be changed)
  function updateCallback(pdata)
  {
    vehicleField.htmlText = Stat.Decorate(pdata.original_name, pdata.original_fieldtext, 
      pdata.team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
  }
}
