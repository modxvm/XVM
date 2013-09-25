package xvm.hangar.components.BattleLoading
{
    import flash.events.Event;
    import flash.text.*;
    import flash.utils.*;
    import flash.geom.Transform;
    import scaleform.gfx.TextFieldEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.lobby.battleloading.PlayerItemRenderer;
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.misc.IconLoader;
    import com.xvm.types.cfg.CClanIcon;
    import xvm.hangar.components.ClanIcon.ClanIcon;
    import xvm.UI.battleLoading.*;

    public class BattleLoadingItemRenderer
    {
        private var proxy:PlayerItemRenderer;

        private var playerName:String = null;

        public function BattleLoadingItemRenderer(proxy:PlayerItemRenderer)
        {
            this.proxy = proxy;

            proxy.iconLoader.addEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete);

            // Remove squad icon.
            if (Config.config.battleLoading.removeSquadIcon && proxy.squad != null)
                proxy.squad.visible = false;

            // FIXIT
            //TextFieldEx.setVerticalAlign(proxy.textField,  TextFieldAutoSize.CENTER);
            //TextFieldEx.setVerticalAutoSize(proxy.textField, TextFieldAutoSize.CENTER);

            TextFieldEx.setVerticalAlign(proxy.vehicleField, TextFieldAutoSize.CENTER);
            TextFieldEx.setVerticalAutoSize(proxy.vehicleField, TextFieldAutoSize.CENTER);
            proxy.vehicleField.condenseWhite = true;

            proxy.vehicleField.width += 100;
            proxy.vehicleField.scaleX = 1;
            if (team == Defines.TEAM_ALLY)
                proxy.vehicleField.x -= 103;

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);

            //setInterval(function() { proxy.setData(proxy.data) }, 10); // DEBUG
        }

        public function setData(data:Object):void
        {
            //Logger.add("setData: " + (data == null ? "(null)" : data.label));
            if (data == null)
                return;

            if (playerName == null)
                playerName = data.label + (data.clanAbbrev == null || data.clanAbbrev == "" ? "" : "[" + data.clanAbbrev + "]");

            Macros.RegisterMinimalMacrosData(playerName, Utils.clearIcon(data.icon), data.vehicle);
            data.label = Macros.Format(playerName, "{{nick}}");

            // ClanIcon
            attachClanIconToPlayer(data);

            // Alternative icon set
            if (proxy.iconLoader.sourceAlt == Defines.WG_CONTOUR_ICON_NOIMAGE)
            {
                proxy.iconLoader.sourceAlt = data.icon;
                data.icon = data.icon.replace(Defines.WG_CONTOUR_ICON_PATH,
                    Defines.XVMRES_ROOT + Config.config.iconset.battleLoading);
            }
            else
            {
                data.icon = proxy.iconLoader.source;
            }
        }

        private var _savedTextFieldColor:String = null;
        public function draw():void
        {
            try
            {
                if (proxy.data == null)
                    return;
                if (Config.config.battle.highlightVehicleIcon == false && App.colorSchemeMgr != null)
                {
                    proxy.iconLoader.transform.colorTransform =
                        App.colorSchemeMgr.getScheme(proxy.enabled ? "normal" : "normal_dead").colorTransform;
                }

                // Set Text Fields
                if (_savedTextFieldColor == null)
                    _savedTextFieldColor = proxy.textField.htmlText.match(/ COLOR="(#[0-9A-F]{6})"/)[1];
                var a:String = Macros.Format(playerName, team == Defines.TEAM_ALLY
                    ? Config.config.battleLoading.formatLeftNick
                    : Config.config.battleLoading.formatRightNick);
                var b:String = Macros.Format(playerName, team == Defines.TEAM_ALLY
                    ? Config.config.battleLoading.formatLeftVehicle
                    : Config.config.battleLoading.formatRightVehicle);
                proxy.textField.htmlText = "<font color='" + _savedTextFieldColor + "'>" + a + "</font>";
                proxy.vehicleField.htmlText = "<font color='" + _savedTextFieldColor + "'>" + b + "</font>";

                //Logger.add(b);
                //Logger.add(proxy.vehicleField.htmlText);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        private function get team():int
        {
            return (proxy is UI_LeftItemRenderer) ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
        }

        private var _clanIconLoaded:Boolean = false;
        private function attachClanIconToPlayer(data:Object):void
        {
            if (_clanIconLoaded)
                return;
            _clanIconLoaded = true;

            var cfg:CClanIcon = Config.config.battleLoading.clanIcon;
            if (!cfg.show)
                return;
            var icon:ClanIcon = new ClanIcon(cfg, proxy.iconLoader.x, proxy.iconLoader.y, team,
                WGUtils.GetPlayerName(playerName), WGUtils.GetClanNameWithoutBrackets(playerName));
            icon.addEventListener(Event.COMPLETE, function():void
            {
                // don't add empty icons to the form
                if (icon.source == "")
                    return;

                // unpredictable effects appear when added to the renderer item because of scaleXY.
                // add to the main form, that is not scaled, and adjust XY values.
                proxy.parent.parent.parent.addChild(icon);
                icon.x += proxy.parent.parent.x + proxy.parent.x + proxy.x;
                icon.y += proxy.parent.parent.y + proxy.parent.y + proxy.y;
            });
        }

        private function onVehicleIconLoadComplete(e:UILoaderEvent):void
        {
            //Logger.add("onVehicleIconLoadComplete: " + playerName);
            if (/*proxy.iconLoader.width > 84 ||*/ proxy.iconLoader.height > 24)
            {
                //var c:Number = Math.min(84 / proxy.iconLoader.width, 24 / proxy.iconLoader.height);
                var c:Number = 24 / proxy.iconLoader.height;
                proxy.iconLoader.scaleX = c;
                proxy.iconLoader.scaleY = c;
            }
            if (Config.config.battle.mirroredVehicleIcons == false && team == Defines.TEAM_ENEMY)
            {
                proxy.iconLoader.scaleX = -1;
                proxy.iconLoader.x = 4;
                //Logger.add(proxy.iconLoader.width + "x" + proxy.iconLoader.height);
            }
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + proxy.data.label);
            proxy.vehicleField.condenseWhite = false; // TODO StatData.s_empty;
            draw();
        }
    }

}
