/**
 * ...
 * @author sirmax2
 */
import net.wargaming.controls.UILoaderAlt;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.IconLoader;

class wot.utils.PlayerInfo extends MovieClip
{
    private static var s_playersIconSources: Object = { };

    public static function createIcon(owner: MovieClip, cfg: Object, dx: Number, dy: Number, team: Number): UILoaderAlt
    {
        var holder:MovieClip = owner["xvm_icon_holder"];
        if (holder == undefined)
        {
            if (team == undefined)
                team = Defines.TEAM_ALLY;
            holder = owner.createEmptyMovieClip("xvm_icon_holder", owner.getNextHighestDepth());
            holder._x = dx + (team == Defines.TEAM_ALLY ? cfg.x : -cfg.xr);
            if (team == Defines.TEAM_ENEMY)
                holder._x -= cfg.w;
            holder._y = dy + (team == Defines.TEAM_ALLY ? cfg.y : cfg.yr);
        }

        var il = new IconLoader(instance, instance.completeLoadIcon);

        var icon: UILoaderAlt = (UILoaderAlt)(holder.attachMovie("UILoaderAlt", "icon", 0));
        icon._x = icon._y = 0;
        icon._alpha = isFinite(cfg.alpha) ? cfg.alpha : 100;
        icon._visible = false;
        icon["claninfo"] = { w: cfg.w, h: cfg.h };
        icon["holder"] = holder;
        icon["iconloader"] = il;

        return icon;
    }

    public static function setSource(icon: UILoaderAlt, nick: String, clan: String)
    {
        if (icon["nick"] == nick)
            return;
        icon["nick"] = nick;

        // Load order: nick -> clan -> default clan -> default nick
        var paths = [ ];
        var src = s_playersIconSources[nick];
        if (src != undefined)
        {
            if (src == "")
            {
                icon.unload();
                return;
            }
            paths.push(s_playersIconSources[nick]);
        }
        else
        {
            paths.push(Config.s_config.battle.clanIconsFolder + Config.s_game_region + "/nick/" + nick + ".png");
            if (clan)
            {
                paths.push(Config.s_config.battle.clanIconsFolder + Config.s_game_region + "/clan/" + clan + ".png");
                paths.push(Config.s_config.battle.clanIconsFolder + Config.s_game_region + "/clan/default.png");
            }
            paths.push(Config.s_config.battle.clanIconsFolder + Config.s_game_region + "/nick/default.png");
        }

        var il = icon["iconloader"];
        il.init(icon, paths, false);
        var ci = il.currentIcon;
        icon.source = ci;
    }

    // private
    private static var _instance = null;
    public static function get instance()
    {
        if (!_instance)
            _instance = new PlayerInfo();
        return _instance;
    }

    public function completeLoadIcon(event)
    {
        var icon: MovieClip = event.target;

        icon.setSize(icon["claninfo"].w, icon["claninfo"].h);
        icon.invalidate();
        //icon.visible = false;
        if (!s_playersIconSources.hasOwnProperty(icon["nick"]))
            s_playersIconSources[icon["nick"]] = icon.source;

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
