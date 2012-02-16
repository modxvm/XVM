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
    col3._width += 40;
    Config.LoadConfigAndStat();
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");
    if (this.owner._name == "team1")
      col3._x -= 40;
    if (Config.bool("battle/disableMirroredVehicleIcons"))
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
    if (Config.bool("rating/statisticForm/show", true))
    {
      col3.htmlText = Stat.DecorateField(data.label, data.vehicle,
        Config.value("rating/statisticForm/format"),
        this.owner._name == "team1" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
  }
}
