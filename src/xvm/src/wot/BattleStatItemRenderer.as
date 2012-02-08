/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;
import wot.utils.Stat;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  function BattleStatItemRenderer()
  {
    super();
    col3.html = true;
    col3._width += 20;
    Config.LoadConfigAndStat();
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");
    if (this.owner._name == "team1")
      col3._x -= 20;
    if (Config.value("battle/disableMirroredVehicleIcons/data") == "true")
    {
      if (this.owner._name == "team2")
      {
        event.target._xscale = -event.target._xscale;
        event.target._x -= event.target.__width;
      }
    }
  }
    
  // override
  function updateData()
  {
    super.updateData();
    col3.htmlText = Stat.Decorate(data.label, data.vehicle, this.owner._name == "team1" ? "right" : "left");
  }
}
