/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar.components.ClanIcon
{
    import com.xfw.*;
    import com.xfw.misc.*;
    import com.xfw.utils.*;
    import com.xfw.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;

    public class ClanIcon extends IconLoader
    {
        private static var s_playersIconSources:Dictionary = new Dictionary();

        private var cfg:CClanIcon;
        private var nick:String;

        public function ClanIcon(cfg:CClanIcon, dx:Number, dy:Number, team:Number, playerId:Number, nick:String, clan:String, emblem:String)
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

            setSource(playerId, nick, clan, emblem);
        }

        public function setSource(playerId:Number, nick:String, clan:String, emblem:String):void
        {
            // Load order: id -> nick -> emblem -> clan -> default clan -> default nick
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
                var prefix:String = Defines.XVMRES_ROOT + Config.config.battle.clanIconsFolder;
                paths.push(prefix + "ID/" + playerId + ".png");

                prefix += Config.gameRegion + "/";
                paths.push(prefix + "nick/" + nick + ".png");

                if (emblem != null)
                {
                    //Logger.add('emblem: ' + Utils.fixImgTag(emblem));
                    paths.push(Utils.fixImgTag(emblem));
                }

                if (clan != null && clan != "")
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

                width = cfg.w;
                height = cfg.h;

                visible = true;
            }
            catch (ex:Error)
            {
                Logger.addObject(ex.getStackTrace());
            }

            super.onLoadComplete(e);
        }
    }
}
