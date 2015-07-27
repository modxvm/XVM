/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading_ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.battleloading.*;
    import net.wg.gui.lobby.battleloading.vo.*;
    import scaleform.gfx.*;
    import xvm.battleloading_ui.*;

    public class BattleLoadingItemRenderer
    {
        private var proxy:PlayerItemRenderer;

        private var playerId:Number = NaN;
        private var fullPlayerName:String = null;

        private var _vehicleIconLoaded:Boolean = false;

        // for debug
        public function _debug():void
        {
            /*setInterval(function():void {
                proxy.data.vehicleStatus = 3;
                proxy.setData(proxy.data);
            }, 1000);*/

            //proxy.vehicleField.border = true;
            //proxy.vehicleField.borderColor = 0xFFFF00;
            //proxy.textField.border = true;
            //proxy.textField.borderColor = 0x00FF00;
        }

        public function BattleLoadingItemRenderer(proxy:PlayerItemRenderer)
        {
            this.proxy = proxy;

            _debug();

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

            var xLeftVeh:Number = (isNaN(Config.config.battleLoading.xPositionLeftVehicle)) ? 0 : Config.config.battleLoading.xPositionLeftVehicle;
            var xRightVeh:Number = (isNaN(Config.config.battleLoading.xPositionRightVehicle)) ? 0 : Config.config.battleLoading.xPositionRightVehicle;

            proxy.vehicleField.width += 100;
            proxy.vehicleField.scaleX = 1;
            if (team == XfwConst.TEAM_ALLY)
            {
                proxy.vehicleField.x -= 103 + xLeftVeh;
            }
            else
            {
                proxy.vehicleField.x += xRightVeh;
            }

        }

        public function setData(data:VehicleInfoVO):void
        {
            //Logger.add("setData: " + (data == null ? "(null)" : data.playerName) + " status=" + data.vehicleStatus);
            //Logger.addObject(data);
            try
            {
                if (data == null)
                    return;

                if (isNaN(playerId))
                    playerId = data.accountDBID;

                // Add stat loading handler
                Stat.loadBattleStat(this, onStatLoaded);

                if (fullPlayerName == null)
                {
                    fullPlayerName = App.utils.commons.getFullPlayerName(
                        App.utils.commons.getUserProps(data.playerName, data.clanAbbrev, data.region, data.igrType));
                }

                var vdata:VehicleData = VehicleInfo.getByIcon(data.vehicleIcon);
                Macros.RegisterMinimalMacrosData(data.accountDBID, fullPlayerName, vdata.vid, team);
                data.playerName = Macros.Format(data.playerName, "{{name}}");
                data.clanAbbrev = Macros.Format(data.playerName, "{{clannb}}");

                // Alternative icon set
                if (proxy.iconLoader.sourceAlt == Defines.WG_CONTOUR_ICON_NOIMAGE)
                {
                    proxy.iconLoader.sourceAlt = Defines.WG_CONTOUR_ICON_PATH + vdata.sysname + ".png";
                    data.vehicleIcon = data.vehicleIcon.replace(Defines.WG_CONTOUR_ICON_PATH,
                        Defines.XVMRES_ROOT + ((team == XfwConst.TEAM_ALLY)
                        ? Config.config.iconset.battleLoadingAlly
                        : Config.config.iconset.battleLoadingEnemy));
                }
                else
                {
                    data.vehicleIcon = proxy.iconLoader.source;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function draw():void
        {
            try
            {
                var data:VehicleInfoVO = proxy.data as VehicleInfoVO;
                if (data == null)
                    return;

                var formatOptions:MacrosFormatOptions = new MacrosFormatOptions();

                formatOptions.alive = data.isAlive();
                formatOptions.ready = data.isReady();
                formatOptions.selected = data.isCurrentPlayer;
                formatOptions.isCurrentPlayer = data.isCurrentPlayer;
                formatOptions.isCurrentSquad = data.isCurrentSquad;
                formatOptions.squadIndex = data.squadIndex;
                formatOptions.position = proxy.index + 1;
                formatOptions.isTeamKiller = data.isTeamKiller();

                var isIconHighlighted:Boolean = App.colorSchemeMgr != null && (!Config.config.battleLoading.darkenNotReadyIcon || proxy.enabled) && formatOptions.alive;

                proxy.iconLoader.transform.colorTransform =
                        App.colorSchemeMgr.getScheme(isIconHighlighted ? "normal" : "normal_dead").colorTransform;

                // Set Text Fields
                var textFieldColorString:String = proxy.textField.htmlText.match(/ COLOR="(#[0-9A-F]{6})"/)[1];

                var nickFieldText:String = Macros.Format(WGUtils.GetPlayerName(fullPlayerName), team == XfwConst.TEAM_ALLY
                    ? Config.config.battleLoading.formatLeftNick : Config.config.battleLoading.formatRightNick, formatOptions);
                proxy.textField.htmlText = "<font color='" + textFieldColorString + "'>" + nickFieldText + "</font>";

                var vehicleFieldText:String = Macros.Format(WGUtils.GetPlayerName(fullPlayerName), team == XfwConst.TEAM_ALLY
                    ? Config.config.battleLoading.formatLeftVehicle : Config.config.battleLoading.formatRightVehicle, formatOptions);
                proxy.vehicleField.htmlText = "<font color='" + textFieldColorString + "'>" + vehicleFieldText + "</font>";

                //Logger.add(vehicleFieldText);
                //Logger.add(proxy.vehicleField.htmlText);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function get team():int
        {
            return (proxy is UI_LeftItemRenderer) ? XfwConst.TEAM_ALLY : XfwConst.TEAM_ENEMY;
        }

        private function onVehicleIconLoadComplete(e:UILoaderEvent):void
        {
            //Logger.add("onVehicleIconLoadComplete: " + fullPlayerName);
            // resize icons to avoid invalid resizing of item
            //if (proxy.iconLoader.width > 84 || proxy.iconLoader.height > 24)
            /*if (proxy.iconLoader.height > 24)
            {
                //var c:Number = Math.min(84 / proxy.iconLoader.width, 24 / proxy.iconLoader.height);
                var c:Number = 24 / proxy.iconLoader.height;
                proxy.iconLoader.scaleX = c;
                proxy.iconLoader.scaleY = c;
            }*/

            _vehicleIconLoaded = true;

            // crop large icons to avoid invalid resizing of item
            // proxy.iconLoader.scrollRect = new Rectangle(0, 0, 84, 24);

            var xLeftVehIcon:Number = (isNaN(Config.config.battleLoading.xPositionLeftVehicleIcon)) ? 0 : Config.config.battleLoading.xPositionLeftVehicleIcon;
            var xRightVehIcon:Number = (isNaN(Config.config.battleLoading.xPositionRightVehicleIcon)) ? 0 : Config.config.battleLoading.xPositionRightVehicleIcon;

            // disable icons mirroring (for alternative icons)
            if (Config.config.battle.mirroredVehicleIcons == false)
            {
                if (team == XfwConst.TEAM_ENEMY)
                {
                    proxy.iconLoader.scaleX = -Math.abs(proxy.iconLoader.scaleX);
                    proxy.iconLoader.x -= 80 - 5 - xRightVehIcon;
                    //Logger.add(proxy.iconLoader.width + "x" + proxy.iconLoader.height);
                } else
                {
                    proxy.iconLoader.x -= xLeftVehIcon;
                }
            }
            else
            {
                if (team == XfwConst.TEAM_ALLY)
                {
                    proxy.iconLoader.x -= xLeftVehIcon;
                }
                else
                {
                    proxy.iconLoader.x += xRightVehIcon;
                }
            }
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + fullPlayerName);
            proxy.vehicleField.condenseWhite = false;
            //draw();
            if (proxy.constraints != null)
                proxy.invalidateData();
            // ClanIcon
            attachClanIconToPlayer();
        }

        private var _clanIconLoaded:Boolean = false;
        private function attachClanIconToPlayer(cnt:int = 0):void
        {
            if (_clanIconLoaded)
                return;

            if (isNaN(playerId))
            {
                Logger.add("WARNING: [attachClanIconToPlayer] playerId is NaN");
                return;
            }

            _clanIconLoaded = true;

            var name:String = WGUtils.GetPlayerName(fullPlayerName);

            var statData:StatData = Stat.getData(name);
            if (statData == null)
                return;

            var cfg:CClanIcon = Config.config.battleLoading.clanIcon;
            if (!cfg.show)
                return;
            var icon:ClanIcon = new ClanIcon(cfg, proxy.iconLoader.x, proxy.iconLoader.y, team,
                playerId,
                name,
                WGUtils.GetClanNameWithoutBrackets(fullPlayerName),
                statData.emblem);
            icon.addEventListener(Event.COMPLETE, function():void
            {
                // don't add empty icons to the form
                if (icon.source == "")
                    return;

                // unpredictable effects appear when added to the renderer item because of scaleXY.
                // add to the main form, that is not scaled, and adjust XY values.
                proxy.parent.parent.parent.addChild(icon);
                var offset:int = 0;
                if (_vehicleIconLoaded && Config.config.battle.mirroredVehicleIcons == false && team == XfwConst.TEAM_ENEMY)
                    offset = 80;
                icon.x += proxy.parent.parent.x + proxy.parent.x + proxy.x + offset;
                icon.y += proxy.parent.parent.y + proxy.parent.y + proxy.y;
            });
        }
    }

}

/*
data: { // net.wg.gui.lobby.battleloading.vo::VehicleInfoVO
  "isPlayerTeam": false,
  "isCurrentSquad": false,
  "isCurrentPlayer": false,
  "region": null,
  "clanAbbrev": "",
  "igrType": 0,
  "playerName": "KKeqpuP4uKK",
  "vehicleName": "Chi-Ni",
  "vehicleIcon": "../../../xvm/res/contour/HARDicons/japan-Chi_Ni.png",
  "vehicleAction": 0,
  "squadIndex": 0,
  "playerStatus": 0,
  "vehicleStatus": 3,
  "prebattleID": 20481354,
  "vehicleID": 23974944,
  "isSpeaking": false,
  "isMuted": false,
  "accountDBID": 5177220
}
*/
