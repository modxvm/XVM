/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;

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
    if (this.owner._name == "team1List")
      col3._x -= 20;
    super.setData(data);
  }
}
