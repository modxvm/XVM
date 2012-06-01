/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Iconset;
import wot.utils.Logger;
import wot.utils.PlayerInfo;
import wot.utils.Stat;
import wot.utils.Utils;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  static var DEBUG_TIMES = false;

  public static var s_chancesField: TextField = null;
  public static var s_chancesText: String;

  var m_clanIcon: MovieClip = null;
  var m_textCache = {};
  var m_iconset: Iconset = null;
  var m_iconLoaded: Boolean = false;
  
  function BattleStatItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "BattleStatItemRenderer") == -1)
      _global.xvm.push("BattleStatItemRenderer");
    Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    col3.html = true;
    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "BattleStatItemRenderer.as");
  }

  private function get team(): Number
  {
    return (this.owner._name == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  function completeLoad()
  {
    if (m_iconLoaded)
      return;
    m_iconLoaded = true;

    col3._width += 80;
    if (team == Defines.TEAM_ALLY)
    {
      col3._x -= 80;
      //Logger.addObject(event.target);
    }
    if (!Config.s_config.battle.mirroredVehicleIcons)
    {
      if (team == Defines.TEAM_ENEMY)
      {
        iconLoader._xscale = -iconLoader._xscale;
        iconLoader._x -= 80 - 5; // FIXIT: where I can get image width?
        col3._x += 5;
      }
    }
  }

  // override
  function updateData()
  {
    var start = new Date();

    // Chances
    //Logger.add(Stat.s_player_names.length.toString());
    if (Stat.s_loaded && Config.s_config.statisticForm.showChances && Stat.s_player_names.length == 30)
    {
      if (!s_chancesField)
      {
        s_chancesField = _root.statsDialog.battleText;
        s_chancesText = Stat.ShowChances(s_chancesField);
      }
      if (s_chancesField.htmlText != s_chancesText)
      {
        //Logger.add(s_chancesField.htmlText);
        s_chancesField.html = true;
        s_chancesField.htmlText = s_chancesText;
      }
    }

    if (data)
    {
      if (Config.s_config.rating.showPlayersStatistics && !Stat.s_player_data[data.label.toUpperCase()])
        Stat.AddPlayerData(this, null, 1, data.label, data.vehicle, data.icon, team);

      // Alternative icon set
      if (!m_iconset)
        m_iconset = new Iconset();
      m_iconset.init(this, iconLoader, [
          data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm),
          data.icon ], completeLoad);
      data.icon = m_iconset.currentIcon;

      // Player/clan icons
      var cfg = Config.s_config.statisticForm.clanIcon;
      if (cfg.show)
        XVMClanIcon(cfg);
    }

    if (Config.s_config.statisticForm.removeSquadIcon && squad)
      squad._visible = false;

    super.updateData();

    if (!m_textCache.hasOwnProperty(data.label))
    {
      m_textCache[data.label] = Stat.DecorateField(data, data.vehicle,
        team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
        team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
    col3.htmlText = m_textCache[data.label];

    if (DEBUG_TIMES)
    {
      Logger.add("DEBUG TIME: BattleStatItemRenderer[" + data.label + "]: updateData(): " +
        Utils.elapsedMSec(start, new Date()) + " ms");
    }
  }

  function XVMClanIcon(cfg)
  {
    var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : "");
    if (!m_clanIcon)
    {
      var x = (!m_iconLoaded || Config.s_config.battle.mirroredVehicleIcons || (team == Defines.TEAM_ALLY))
        ? iconLoader._x : iconLoader._x + 80 - 5;
      m_clanIcon = PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo ? pinfo.icon : null, cfg, x, iconLoader._y, team);
    }
    if (!pinfo)
      m_clanIcon.clanIcon.source = null;
    else
    {
      if (pinfo.icon != m_clanIcon.clanIcon.source)
        m_clanIcon.clanIcon.source = pinfo.icon;
    }
  }
}
