/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;

class wot.utils.PlayerInfo extends MovieClip
{
  public static function getPlayerInfo(nick: String, clan: String)
  {
    if (!Config.s_loaded)
      return null;

    for (var i = 0; i < Config.s_config.players.length; ++i)
    {
      var pinfo = Config.s_config.players[i];
      if (nick && pinfo.nick && nick == pinfo.nick)
        return pinfo;
      if (clan && pinfo.clan && clan.indexOf(pinfo.clan, 0) != -1)
        return pinfo;
    }
    return null;
  }
  
  public static function createClanIcon(owner: MovieClip, name: String, pinfo, cfg, dx, dy, team, oldIcon: MovieClip): MovieClip
  {
    if (!pinfo || !pinfo.icon)
      return null;

    var holder: MovieClip = owner.createEmptyMovieClip(name, owner.getNextHighestDepth());
    var icon: MovieClip = holder.attachMovie("UILoader", "clanIcon", holder.getNextHighestDepth());
    var depth = holder.getNextHighestDepth();
    var t: TextField = holder.createTextField("tf", depth, 0, 0, 16, 16);
    t.textColor = 0x00FF00;
    t.text = depth.toString();

    var mx = team == Defines.TEAM_ALLY ? 1 : -1;
    holder._x = dx + cfg.x * mx;
    if (team == Defines.TEAM_ENEMY)
      holder._x -= cfg.w;
    holder._y = dy + cfg.y;

    icon._x = icon._y = 0;
    icon._alpha = cfg.alpha;
    icon.addEventListener("complete", instance, "completeLoadClanIcon");
    icon.source = pinfo.icon;
    icon.visible = false;
    icon["xvm_claninfo"] = { w: cfg.w, h: cfg.h };
    icon["holder"] = holder;
    icon["oldIcon"] = oldIcon;

/*    if (icon.hasOwnProperty("oldIcon"))
    {
      icon["oldIcon"].removeMovieClip();
      delete icon["oldIcon"];
      icon["oldIcon"] = null;
    }*/
    
    return holder;
  }

  // private
  private static var _instance = null;
  private static function get instance()
  {
    if (!_instance)
      _instance = new PlayerInfo();
    return _instance;
  }

  private function completeLoadClanIcon(event)
  {
    var icon: MovieClip = event.target;
    icon.setSize(icon["xvm_claninfo"].w, icon["xvm_claninfo"].h);

    if (icon.hasOwnProperty("oldIcon"))
    {
      //if (icon["oldIcon"])
      //  icon["oldIcon"]["owner"]["m_clanIcon"].removeMovieClip();
      //delete icon["oldIcon"];
      //icon["oldIcon"] = null;
    }

    icon["holder"].onEnterFrame = function()
    {
      this.onEnterFrame = null;
      icon.visible = true;
    }
  }
}