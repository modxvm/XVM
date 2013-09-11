/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar.components.ClanIcon
{
    import flash.display.*;
    import flash.events.Event;
    import flash.utils.Dictionary;
    import com.xvm.misc.IconLoader;
    import com.xvm.*;
    import com.xvm.types.cfg.CClanIcon;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class ClanIcon extends IconLoader
    {
        private static var s_playersIconSources:Dictionary = new Dictionary();

        private var cfg:CClanIcon;
        private var nick:String;

        public function ClanIcon(cfg:CClanIcon, dx:Number, dy:Number, team:Number, nick:String, clan:String)
        {
            super();

            this.cfg = cfg;
            this.nick = nick;

            x = dx + (team == Defines.TEAM_ALLY ? cfg.x : -cfg.xr);
            if (team == Defines.TEAM_ENEMY)
                x -= cfg.w;
            y = dy + (team == Defines.TEAM_ALLY ? cfg.y : cfg.yr);

            alpha = isFinite(cfg.alpha) ? cfg.alpha : 100;

            autoSize = false;
            visible = false;

            setSource(nick, clan);
        }

        public function setSource(nick:String, clan:String):void
        {
            // Load order: nick -> clan -> default clan -> default nick
            var paths:Vector.<String> = new Vector.<String>();
            var src:String = s_playersIconSources[nick];
            if (src != null)
            {
                if (src == "")
                {
                    unload();
                    return;
                }
                paths.push(s_playersIconSources[nick]);
            }
            else
            {
                var prefix:String = Defines.XVMRES_ROOT + Config.config.battle.clanIconsFolder + Config.gameRegion + "/";
                paths.push(prefix + "nick/" + nick + ".png");
                if (clan != null)
                {
                    paths.push(prefix + "clan/" + clan + ".png");
                    paths.push(prefix + "clan/default.png");
                }
                paths.push(prefix + "nick/default.png");
            }

            setSources(paths);
        }

        override protected function onLoadComplete(e:Event):void
        {
            try
            {
                if (!s_playersIconSources.hasOwnProperty(nick))
                    s_playersIconSources[nick] = source;

                if (maintainAspectRatio)
                {
                    var c:Number = Math.min(cfg.w / loader.width, cfg.h / loader.height);
                    loader.width *= c;
                    loader.height *= c;
                }
                else
                {
                    loader.width = cfg.w;
                    loader.height = cfg.h;
                }

                visible = true;
            }
            catch (ex:Error)
            {
                Logger.addObject(ex.getStackTrace());
            }
        }
    }
}
