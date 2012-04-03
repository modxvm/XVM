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

class wot.BattleStatItemRenderer extends net.wargaming.BattleStatItemRenderer
{
  public static var chancesField: TextField = null;

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

    if (!chancesField && (this.owner._name == "team1"))
    {
      chancesField = this.owner.createTextField("chances", this.owner.getNextHighestDepth(), -50, 20, 400, 100);
      chancesField.wordWrap = true;
      chancesField.antiAliasType = "advanced";
      chancesField.setNewTextFormat(new TextFormat("$FieldFont", 16, 0x000000, true, false, false, null, null, "left"));
      chancesField.filters = [ new DropShadowFilter(0, 0, 0, 100, 3, 3, 3, 3) ];
      chancesField.textColor = 0xFFFFFF;
      chancesField._alpha = 100;
      chancesField._visible = true;
    }
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
  private var _chancesShown = false;
  function updateData()
  {
    // Chances
    if (Stat.s_loaded && Config.s_config.battleLoading.showChances && !_chancesShown)
    {
      _chancesShown = true;
      var chances = Stat.GetChances();
      chancesField.text = "Chances(m) = " + chances.m + " (" + chances.m1 + " / " + chances.m2 + ")\n" +
        "Chances(k) = " + chances.k + " (" + chances.k1 + " / " + chances.k2 + ")";
      chancesField.textColor = Number(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, chances.m_raw, "0x"));
    }

    if (data)
    {
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
}
