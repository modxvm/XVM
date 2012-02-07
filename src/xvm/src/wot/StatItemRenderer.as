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
    Config.LoadConfig();
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    if (Config.s_config.battle.disableMirroredVehicleIcons.data == "true")
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
    if (data)
      vehicleField.htmlText = Stat.DecorateField(data.label, data.vehicle);
  }

  // override
  function setData(data)
  {
    Stat.AddPlayerData(this, data.label, data.vehicle);
    super.setData(data);
  }
  
  // update delegate (function name is fixed and cannot be changed)
  function updateCallback(pdata)
  {
    vehicleField.htmlText = Stat.DecorateField(pdata.original_name, pdata.original_fieldtext);
  }
}
