/**
 * ...
 * @author sirmax2
 */

import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Iconset;
import wot.utils.Logger;
import wot.utils.PlayerInfo;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.StatFormat;
import wot.utils.Utils;

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  static var DEBUG_TIMES = false;

  public static var s_chanceField: TextField = null;
  public static var s_chanceText: String;

  var m_clanIcon: MovieClip = null;
  var m_textCache = {};
  var m_iconset: Iconset = null;
  var m_iconLoaded: Boolean = false;

  function BattleStatItemRenderer()
  {
    super();

    Utils.TraceXvmModule("BattleStatItemRenderer");

    col3.html = true;
    col3.condenseWhite = true;

    GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
    Config.LoadConfig("BattleStatItemRenderer.as");
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

    // Chance
    if (StatData.s_loaded && Config.s_config.statisticForm.showChances && !s_setChanceFieldDataAdded)
    {
      s_setChanceFieldDataAdded = true;
      var timer = _global.setTimeout(this, "SetChanceFieldData", 50);
    }

    var saved_icon = data ? data.icon : null;
    if (data)
    {
      var pname = data.label.toUpperCase();
      if (Config.s_config.rating.showPlayersStatistics && !StatData.s_data[pname] || !StatData.s_data[pname].id)
        StatLoader.AddPlayerData(1, data.label, data.vehicle, data.icon, team);

      // Alternative icon set
      if (!m_iconset)
        m_iconset = new Iconset(this, completeLoad);
      m_iconset.init(iconLoader,
        [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.statisticForm), data.icon ]);
      data.icon = m_iconset.currentIcon;

      // Player/clan icons
      var cfg = Config.s_config.statisticForm.clanIcon;
      if (cfg.show)
        XVMClanIcon(cfg);
    }

    if (Config.s_config.statisticForm.removeSquadIcon && squad)
      squad._visible = false;

    super.updateData();

    if (data)
      data.icon = saved_icon;

    var key = data.label + "/" + data.vehicle;
    if (!m_textCache.hasOwnProperty(key))
    {
      //Logger.add(data.label);
      m_textCache[key] = StatFormat.DecorateField(data, data.vehicle,
        team == Defines.TEAM_ALLY ? Config.s_config.statisticForm.formatLeft : Config.s_config.statisticForm.formatRight,
        team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
    col3.htmlText = m_textCache[key];

    if (DEBUG_TIMES)
    {
      Logger.add("DEBUG TIME: BattleStatItemRenderer[" + data.label + "]: updateData(): " +
        Utils.elapsedMSec(start, new Date()) + " ms");
    }
  }

  private static var s_setChanceFieldDataAdded = false;
  private static function SetChanceFieldData()
  {
    //Logger.add("SetChanceFieldData()");
    s_setChanceFieldDataAdded = false;
    if (!s_chanceField)
    {
      s_chanceField = _root.statsDialog.battleText;
      s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.statisticForm.showChancesExp);
    }
    if (s_chanceField.htmlText != s_chanceText)
    {
      //Logger.add(s_chanceField.htmlText);
      s_chanceField.html = true;
      s_chanceField.htmlText = s_chanceText;
    }
  }

  // override
  function updateState()
  {
    super.updateState();

    if (Config.s_config.battle.highlightVehicleIcon == false && (selected || data.squad > 10))
    {
      var tr = new flash.geom.Transform(iconLoader);
      tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(
        (data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0 ? "normal" : "normal_dead").transform;
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
