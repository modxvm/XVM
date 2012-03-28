/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.PlayerInfo;
import wot.utils.Stat;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  function BattleStatItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "BattleStatItemRenderer") == -1)
      _global.xvm.push("BattleStatItemRenderer");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    col3.html = true;
    col3._width += 80;
    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "BattleStatItemRenderer.as");
  }

  private function get team(): Number
  {
    return (this.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  // override
  function errorLoad(event)
  {
    if (event.target.source)
    {
      // Fallback to default icon
      event.target.source = (Config.s_config.iconset.statisticForm != Defines.CONTOUR_ICON_PATH)
        ? event.target.source.split(Config.s_config.iconset.statisticForm).join(Defines.CONTOUR_ICON_PATH)
        : event.target.source = Defines.CONTOUR_ICON_PATH + "noImage.tga";
    }
  }

  // override
  private var _iconLoaded = false;
  function completeLoad(event)
  {
    if (!_iconLoaded)
    {
      _iconLoaded = true;
      if (team == Defines.TEAM_ALLY)
        col3._x -= 80;
      if (!Config.s_config.battle.mirroredVehicleIcons)
      {
        if (team == Defines.TEAM_ENEMY)
        {
          event.target._xscale = -event.target._xscale;
          event.target._x -= 80 - 5; // FIXIT: where I can get image width?
        }
      }
    }
    event.target.visible = true;
  }

  // override
  private var _clanIconLoaded = false;
  function updateData()
  {
    if (data)
    {
      // Player/clan icons
      if (!_clanIconLoaded)
      {
        _clanIconLoaded = true;
        var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : null);
        if (pinfo)
          PlayerInfo.createClanIcon(this, pinfo, iconLoader._x, iconLoader._y, team);
      }

      // Alternative icon set
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm);
    }

    super.updateData();

    col3.htmlText = Stat.DecorateField(data, data.vehicle,
      team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
      team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
  }
}
