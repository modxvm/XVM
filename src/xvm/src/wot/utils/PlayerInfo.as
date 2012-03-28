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
  
  public static function createClanIcon(owner: MovieClip, pinfo, dx, dy, team): MovieClip
  {
    if (!pinfo || !pinfo.w || !pinfo.h || pinfo.w <= 0 || pinfo.h <= 0)
      return null;

    var depth = owner.getNextHighestDepth();
    var icon: MovieClip = owner.attachMovie("UILoader", "clanIcon" + depth, depth);
    
    icon["xvm_parent"] = owner;
    icon["xvm_pinfo"] = pinfo;
    var mx = team == Defines.TEAM_ALLY ? 1 : -1;
    icon._x = dx + pinfo.x * mx;
    if (team == Defines.TEAM_ENEMY)
      icon._x -= pinfo.w;
    icon._y = dy + pinfo.y;
    icon._alpha = pinfo.alpha;
    icon.addEventListener("complete", instance, "completeLoadClanIcon");
    icon.source = pinfo.icon;
    icon.visible = false;
    return icon;
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
    icon.setSize(icon["xvm_pinfo"].w, icon["xvm_pinfo"].h);
    icon["xvm_parent"].onEnterFrame = function()
    {
      this.onEnterFrame = null;
      icon.visible = true;
    }
  }
}