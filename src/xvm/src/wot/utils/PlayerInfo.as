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
    var players_length = Config.s_config.players.length;
    for (var i = 0; i < players_length; ++i)
    {
      var pinfo = Config.s_config.players[i];
      if (nick && pinfo.nick && nick == pinfo.nick)
      {
        result = pinfo;
        break;
      }
      if (clan != null && pinfo.clanAbbrev != null && clan.indexOf(pinfo.clanAbbrev, 0) != -1)
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
    var holder_x = dx + (team == Defines.TEAM_ALLY ? cfg.x : -cfg.xr);
    if (team == Defines.TEAM_ENEMY)
      holder_x -= cfg.w;
    var holder_y = dy + (team == Defines.TEAM_ALLY ? cfg.y : cfg.yr);
    return createClanIcon2(owner, name, source, holder_x, holder_y, cfg.w, cfg.h, cfg.alpha);
  }

  public static function createClanIcon2(owner: MovieClip, name: String, source: String, x, y, w, h, alpha): MovieClip
  {
    var holder: MovieClip = owner.createEmptyMovieClip(name, owner.getNextHighestDepth());
    var icon: MovieClip = holder.attachMovie("UILoader", "clanIcon", holder.getNextHighestDepth());

    holder._x = x;
    holder._y = y;

    icon._x = icon._y = 0;
    icon._alpha = alpha;
    icon.addEventListener("complete", instance, "completeLoadClanIcon");
    icon.source = source;
    icon.visible = false;
    icon["xvm_claninfo"] = { w: w, h: h };
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
