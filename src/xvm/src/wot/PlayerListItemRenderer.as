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
  var m_clanIcon: MovieClip;

  function PlayerListItemRenderer()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "PlayerListItemRenderer") == -1)
      _global.xvm.push("PlayerListItemRenderer");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    //m_clanIcon = this.duplicateMovieClip("iconLoader", getNextHighestDepth());
    //m_clanIcon = this.createEmptyMovieClip("m_clanIcon", getNextHighestDepth());
    //m_clanIcon.attachMovie("UILoader", "icon", m_clanIcon.getNextHighestDepth());
    
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
            //if (!s_clanIcons.hasOwnProperty(data.label))
            //{
            //  wot.utils.Logger.add("new");
            //  var clanIcon = PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo, cfg, iconLoader._x, iconLoader._y, team);
            //  clanIcon["owner"] = this;
            //  s_clanIcons[data.label] = clanIcon;
            //}
            //else
            //{

            //createClanIcon(pinfo, cfg, iconLoader._x, iconLoader._y, team);
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

    var mx = team == Defines.TEAM_ALLY ? 1 : -1;
    m_clanIcon._x = dx + cfg.x * mx;
    if (team == Defines.TEAM_ENEMY)
      m_clanIcon._x -= cfg.w;
    m_clanIcon._y = dy + cfg.y;

    m_clanIcon._alpha = cfg.alpha;
    m_clanIcon.addEventListener("complete", this, "completeLoadClanIcon");
    m_clanIcon.source = pinfo.icon;
    m_clanIcon.visible = false;
    m_clanIcon["xvm_claninfo"] = { w: cfg.w, h: cfg.h };

/*    if (icon.hasOwnProperty("oldIcon"))
    {
      icon["oldIcon"].removeMovieClip();
      delete icon["oldIcon"];
      icon["oldIcon"] = null;
    }*/
  }

  private function completeLoadClanIcon(event)
  {
    var icon: MovieClip = event.target;
    icon.setSize(icon["xvm_claninfo"].w, icon["xvm_claninfo"].h);

    this.onEnterFrame = function()
    {
      this.onEnterFrame = null;
      icon.visible = true;
    }
  }
  
}
