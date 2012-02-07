/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  function BattleStatItemRenderer()
  {
    super();
    col3.html = true;
    col3._width += 20;
    Config.LoadConfig();
    //Stat.LoadUserNames();
    Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
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
  function setData(data)
  {
    if (this.owner._name == "team1List")
      col3._x -= 20;
    super.setData(data);
  }
}
