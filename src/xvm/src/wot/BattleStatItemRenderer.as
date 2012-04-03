/**
 * ...
 * @author sirmax2
 */

import flash.filters.DropShadowFilter;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.PlayerInfo;
import wot.utils.Stat;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  public static var s_chancesField: TextField = null;
  public static var s_chancesText: String;

  var m_clanIcon: MovieClip = null;

  function BattleStatItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "BattleStatItemRenderer") == -1)
      _global.xvm.push("BattleStatItemRenderer");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    col3.html = true;
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
      col3._width += 80;
      _iconLoaded = true;
      if (team == Defines.TEAM_ALLY)
      {
        col3._x -= 80;
        //wot.utils.Logger.addObject(event.target);
      }
      if (!Config.s_config.battle.mirroredVehicleIcons)
      {
        if (team == Defines.TEAM_ENEMY)
        {
          event.target._xscale = -event.target._xscale;
          event.target._x -= 80 - 5; // FIXIT: where I can get image width?
          col3._x += 5;
        }
      }
    }
    event.target.visible = true;
  }

  // override
  function updateData()
  {
    // Chances
    wot.utils.Logger.add(Stat.s_player_names.length.toString());
    if (Stat.s_loaded && Config.s_config.battleLoading.showChances && Stat.s_player_names.length == 30)
    {
      if (!s_chancesField)
        ShowChances();
      if (s_chancesField.htmlText != s_chancesText)
      {
        wot.utils.Logger.add(s_chancesField.htmlText);
        s_chancesField.html = true;
        s_chancesField.htmlText = s_chancesText;
      }
    }

    if (data)
    {
      if (Config.s_config.rating.showPlayersStatistics && !Stat.s_player_data[data.label.toUpperCase()])
        Stat.AddPlayerData(this, 1, data.label, data.vehicle, VehicleInfo.getInfo(data.icon), team);

      // Alternative icon set
      data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm);

      // Player/clan icons
      var cfg = Config.s_config.statisticForm.clanIcon;
      if (cfg.show)
        XVMClanIcon(cfg);
    }

    if (Config.s_config.statisticForm.removeSquadIcon && squad)
      squad._visible = false;

    super.updateData();

    col3.htmlText = Stat.DecorateField(data, data.vehicle,
      team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
      team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
  }

  function XVMClanIcon(cfg)
  {
    var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : null);
    if (!pinfo && m_clanIcon)
    {
      m_clanIcon.removeMovieClip();
      delete m_clanIcon;
      m_clanIcon = null;
    }
    else if (pinfo)
    {
      if (!m_clanIcon)
      {
        var x = (!_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
          ? iconLoader._x : iconLoader._x + 80 - 5;
        m_clanIcon = PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo, cfg, x, iconLoader._y, team);
      }
      else if (pinfo.icon != m_clanIcon.clanIcon.source)
        m_clanIcon.clanIcon.source = pinfo.icon;
    }
  }
  
  function ShowChances()
  {
    var chances = Stat.GetChances();
    s_chancesField = _root.statsDialog.battleText;
    s_chancesField.html = true;
    s_chancesField.htmlText = s_chancesField.text + 
      " <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, chances.m_raw) + "'>" +
      "(Chances: m = " + chances.m + ", k = " + chances.k + ")</font>";
    s_chancesText = s_chancesField.htmlText;
  }
}
