/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
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
  function update()
  {
    super.update();
    if (Config.value("battle/showPlayerStatictics/data") == "true")
    {
      if (data)
        vehicleField.htmlText = Stat.DecorateField(data.label, data.vehicle);
    }
  }

  // override
  function setData(data)
  {
    if (Config.value("battle/showPlayerStatictics/data") == "true")
      Stat.AddPlayerData(this, data.label, data.vehicle);
    super.setData(data);
  }
  
  // update delegate (function name is fixed and cannot be changed)
  function updateCallback(pdata)
  {
    vehicleField.htmlText = Stat.Decorate(pdata.original_name, pdata.original_fieldtext, 
      this.owner._name == "team1List" ? "right" : "left");
  }
}
