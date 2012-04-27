/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;

class wot.utils.PlayerInfo extends MovieClip
{
  private static var s_playersInfoCache = { };

  public static function getPlayerInfo(nick: String, clan: String)
  {
    if (!Config.s_loaded)
      return null;

    if (s_playersInfoCache.hasOwnProperty(nick))
      return s_playersInfoCache[nick];

    var result = null;
    for (var i = 0; i < Config.s_config.players.length; ++i)
    {
      var pinfo = Config.s_config.players[i];
      if (nick && pinfo.nick && nick == pinfo.nick)
      {
        result = pinfo;
        break;
      }
      if (clan != null && pinfo.clan != null && clan.indexOf(pinfo.clan, 0) != -1)
      {
        result = pinfo;
        break;
      }
    }
    s_playersInfoCache[nick] = result;
    return result;
  }
  
  public static function createClanIcon(owner: MovieClip, name: String, source: String, cfg, dx, dy, team): MovieClip
  {
    var holder: MovieClip = owner.createEmptyMovieClip(name, owner.getNextHighestDepth());
    var icon: MovieClip = holder.attachMovie("UILoader", "clanIcon", holder.getNextHighestDepth());

    holder._x = dx + (team == Defines.TEAM_ALLY ? cfg.x : -cfg.xr);
    if (team == Defines.TEAM_ENEMY)
      holder._x -= cfg.w;
    holder._y = dy + (team == Defines.TEAM_ALLY ? cfg.y : cfg.yr);

    icon._x = icon._y = 0;
    icon._alpha = cfg.alpha;
    icon.addEventListener("complete", instance, "completeLoadClanIcon");
    icon.source = source;
    icon.visible = false;
    icon["xvm_claninfo"] = { w: cfg.w, h: cfg.h };
    icon["holder"] = holder;

    return holder;
  }

  // private
  private static var _instance = null;
  public static function get instance()
  {
    if (!_instance)
      _instance = new PlayerInfo();
    return _instance;
  }

  private function completeLoadClanIcon(event)
  {
    var icon: MovieClip = event.target;
    icon.setSize(icon["xvm_claninfo"].w, icon["xvm_claninfo"].h);
    icon.invalidate();
    icon.visible = false;

    icon["holder"].onEnterFrame = function()
    {
      if (icon.invalidationIntervalID)
        return;
      this.onEnterFrame = null;
      this.stop();
      icon.visible = true;
    }
  }
}