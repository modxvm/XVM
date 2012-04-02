/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.PlayerInfo;

class wot.PlayerListItemRenderer extends net.wargaming.ingame.PlayerListItemRenderer
{
  //static var s_clanIcons: Object = { };
  var m_clanIcon: MovieClip = null;

  function PlayerListItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "PlayerListItemRenderer") == -1)
      _global.xvm.push("PlayerListItemRenderer");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "PlayerListItemRenderer.as");
  }

  private function get team(): Number
  {
    return (this.owner._itemRenderer == "LeftItemRendererIcon") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  // override
  function errorLoad(event)
  {
    if (event.target.source)
    {
      // Fallback to default icon
      event.target.source = (Config.s_config.iconset.playersPanel != Defines.CONTOUR_ICON_PATH)
        ? event.target.source.split(Config.s_config.iconset.playersPanel).join(Defines.CONTOUR_ICON_PATH)
        : event.target.source = Defines.CONTOUR_ICON_PATH + "noImage.tga";
    }
  }

  // override
  private var _iconLoaded = false;
  function completeLoad(event)
  {
    var icon = event.target;
    if (!_iconLoaded)
    {
      _iconLoaded = true;
      if (!Config.s_config.battle.mirroredVehicleIcons && team == Defines.TEAM_ENEMY)
      {
        icon._xscale = -icon._xscale;
        icon._x -= icon.__width;

        //if (!Config.s_config.battle.mirroredVehicleIcons)
        this.vehicleLevel._x = icon._x + 15;
      }
    }
    icon.visible = true;
  }

  // override
  function update()
  {
    try
    {
      if (data)
      {
        // Alternative icon set
        data.icon = data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.playersPanel);

        // Player/clan icons
        var cfg = Config.s_config.playersPanel.clanIcon;
        if (cfg.show)
        {
          var pinfo = PlayerInfo.getPlayerInfo(data.label, data.clanAbbrev ? "[" + data.clanAbbrev + "]" : null);
          if (pinfo)
          {
            if (m_clanIcon)
            {
              m_clanIcon.removeMovieClip();
              delete m_clanIcon;
            }
            m_clanIcon = createEmptyMovieClip("m_clanIcon", getNextHighestDepth());
            m_clanIcon.clanIcon = m_clanIcon.attachMovie("UILoader", "clanIcon", 1);
            createClanIcon(pinfo, cfg, iconLoader._x, iconLoader._y, team);
          }
        }
      }

      super.update();
    }
    catch (ex: Error)
    {
      wot.utils.Logger.add(ex.toString());
    }
  }

  
  public function createClanIcon(pinfo, cfg, dx, dy, team)
  {
    if (!pinfo || !pinfo.icon)
      return null;

    //wot.utils.Logger.add("createClanIcon: " + pinfo.icon);
    var mx = team == Defines.TEAM_ALLY ? 1 : -1;
    m_clanIcon._x = dx + cfg.x * mx;
    if (team == Defines.TEAM_ENEMY)
      m_clanIcon._x -= cfg.w;
    m_clanIcon._y = dy + cfg.y;

    m_clanIcon.clanIcon._x = m_clanIcon.clanIcon._y = 0;
    m_clanIcon.clanIcon._alpha = cfg.alpha;
    m_clanIcon.clanIcon.addEventListener("complete", this, "completeLoadClanIcon");
    m_clanIcon.clanIcon.source = pinfo.icon;
    m_clanIcon.clanIcon.visible = false;
    m_clanIcon.clanIcon["xvm_claninfo"] = { w: cfg.w, h: cfg.h };
  }

  private function completeLoadClanIcon(event)
  {
    var icon: MovieClip = event.target;
    icon.setSize(icon["xvm_claninfo"].w, icon["xvm_claninfo"].h);
    //wot.utils.Logger.add("completeLoadClanIcon");

    m_clanIcon.onEnterFrame = function()
    {
      //wot.utils.Logger.add("completeLoadClanIcon: onEnterFrame");
      this.onEnterFrame = null;
      icon.visible = true;
    }
  }
  
}
