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
    col3._width += 80;
    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "BattleStatItemRenderer.as");
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");
    if (this.owner._name == "team1")
      col3._x -= 80;
    if (!Config.s_config.battle.mirroredVehicleIcons)
    {
      if (this.owner._name == "team2")
      {
        event.target._xscale = -event.target._xscale;
        event.target._x -= 80 - 5; // FIXIT: where is image width?
      }
    }
  }

  // override
  function updateData()
  {
    super.updateData();
    if (Config.s_config.rating.statisticForm.show)
    {
      col3.htmlText = Stat.DecorateField(data, data.vehicle,
        Config.s_config.rating.statisticForm.format,
        this.owner._name == "team1" ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
  }
}
