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
        private static const VEHICLE_FIELD_WIDTH:int = 250;
        private static const MAXIMUM_VEHICLE_ICON_WIDTH:int = 80;

        private var proxy:PlayerItemRenderer;

        private var _model:VehicleInfoVO;

        private var _fullPlayerName:String = null;

        private var _vehicleIconLoaded:Boolean = false;

        // for debug
        public function _debug():void
        {
            setInterval(function():void {
                _model.vehicleStatus = 3;
                proxy.setData(_model);
            }, 1000);

            proxy.vehicleField.border = true;
            proxy.vehicleField.borderColor = 0xFFFF00;
            proxy.textField.border = true;
            proxy.textField.borderColor = 0x00FF00;
        }

        public function BattleLoadingItemRenderer(proxy:PlayerItemRenderer)
        {
            this.proxy = proxy;

            //_debug();

            proxy.vehicleIconLoader.addEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete);

            // FIXIT
            //TextFieldEx.setVerticalAlign(proxy.textField,  TextFieldAutoSize.CENTER);
            //TextFieldEx.setVerticalAutoSize(proxy.textField, TextFieldAutoSize.CENTER);

            TextFieldEx.setVerticalAlign(proxy.vehicleField, TextFieldAutoSize.CENTER);
            TextFieldEx.setVerticalAutoSize(proxy.vehicleField, TextFieldAutoSize.CENTER);
            proxy.vehicleField.condenseWhite = true;

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);

            // fix bad align in 0.9.9, 0.9.10
            var dx:int = team == XfwConst.TEAM_ALLY ? 23 : -20;
            proxy.vehicleIconLoader.x += dx;
            proxy.vehicleLevelIcon.x += dx;
            proxy.vehicleTypeIcon.x += dx;
            proxy.vehicleField.width += Math.abs(dx);
            if (team == XfwConst.TEAM_ENEMY)
                proxy.vehicleField.x -= Math.abs(dx);

            // fix scaleX and increase width for vehicleField
            proxy.vehicleField.scaleX = 1;
            proxy.vehicleField.width = VEHICLE_FIELD_WIDTH;
            if (team == XfwConst.TEAM_ALLY)
                proxy.vehicleField.x = proxy.vehicleTypeIcon.x - 15 - VEHICLE_FIELD_WIDTH;

            // Setup controls

            // vehicleTypeIcon
            if (Config.config.battleLoading.removeVehicleTypeIcon)
            {
                if (team == XfwConst.TEAM_ALLY)
                {
                    dx = proxy.vehicleIconLoader.x - (proxy.vehicleField.x + proxy.vehicleField.width);
                }
                else
                {
                    var offset:int = 4;
                    if (_vehicleIconLoaded && Config.config.battle.mirroredVehicleIcons == false && team == XfwConst.TEAM_ENEMY)
                        offset = MAXIMUM_VEHICLE_ICON_WIDTH;
                    dx = proxy.vehicleField.x - (proxy.vehicleIconLoader.x + offset);
                    proxy.vehicleField.x -= dx;
                }
                proxy.vehicleField.width += dx;
            }

            // squad
            if (team == XfwConst.TEAM_ALLY)
            {
                proxy.squad.x += Config.config.battleLoading.squadIconOffsetXLeft;
            }
            else
            {
                proxy.squad.x -= Config.config.battleLoading.squadIconOffsetXRight;
            }

            // textField
            if (team == XfwConst.TEAM_ALLY)
            {
                proxy.textField.x += Config.config.battleLoading.nameFieldOffsetXLeft;
            }
            else
            {
                proxy.textField.x -= Config.config.battleLoading.nameFieldOffsetXRight;
            }

            // vehicleField
            if (team == XfwConst.TEAM_ALLY)
            {
                proxy.vehicleField.x += Config.config.battleLoading.vehicleFieldOffsetXLeft;
            }
            else
            {
                proxy.vehicleField.x -= Config.config.battleLoading.vehicleFieldOffsetXRight;
            }

            // vehicleIconLoader
            if (team == XfwConst.TEAM_ALLY)
            {
                proxy.vehicleIconLoader.x += Config.config.battleLoading.vehicleIconOffsetXLeft;
            }
            else
            {
                proxy.vehicleIconLoader.x -= Config.config.battleLoading.vehicleIconOffsetXRight;
            }
        }

        public function fixData(data:VehicleInfoVO):Object
        {
            if (data != null)
            {
                try
                {
                    _model = data;

                    if (_fullPlayerName == null)
                    {
                        _fullPlayerName = App.utils.commons.getFullPlayerName(
                            App.utils.commons.getUserProps(_model.playerName, _model.clanAbbrev, _model.region, _model.igrType));
                    }

                    var vdata:VehicleData = VehicleInfo.getByIcon(_model.vehicleIcon);
                    Macros.RegisterMinimalMacrosData(_model.accountDBID, _fullPlayerName, vdata.vid, team);
                    _model.playerName = Macros.Format(_model.playerName, "{{name}}");
                    _model.clanAbbrev = Macros.Format(_model.playerName, "{{clannb}}");

                    // Alternative icon set
                    if (!proxy.vehicleIconLoader.sourceAlt || proxy.vehicleIconLoader.sourceAlt == Defines.WG_CONTOUR_ICON_NOIMAGE)
                    {
                        proxy.vehicleIconLoader.sourceAlt = Defines.WG_CONTOUR_ICON_PATH + vdata.sysname + ".png";
                        _model.vehicleIcon = _model.vehicleIcon.replace(Defines.WG_CONTOUR_ICON_PATH,
                            Defines.XVMRES_ROOT + ((team == XfwConst.TEAM_ALLY)
                            ? Config.config.iconset.battleLoadingAlly
                            : Config.config.iconset.battleLoadingEnemy));
                    }
                    else
                    {
                        _model.vehicleIcon = proxy.vehicleIconLoader.source;
                    }
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
            else
            {
                _model = null;
                _fullPlayerName = null;
            }

            return _model;
        }

        public function draw():void
        {
            //Logger.addObject(_model, 1, "_model");
            try
            {
                if (_model != null && proxy.initialized)
                {
                    var formatOptions:MacrosFormatOptions = new MacrosFormatOptions();
                    formatOptions.alive = _model.isAlive();
                    formatOptions.ready = _model.isReady();
                    formatOptions.selected = _model.isCurrentPlayer;
                    formatOptions.isCurrentPlayer = _model.isCurrentPlayer;
                    formatOptions.isCurrentSquad = _model.isCurrentSquad;
                    formatOptions.squadIndex = _model.squadIndex;
                    formatOptions.position = proxy.index + 1;
                    formatOptions.isTeamKiller = _model.isTeamKiller();

                    // controls visibility
                    if (Config.config.battleLoading.removeSquadIcon && proxy.squad != null)
                        proxy.squad.visible = false;
                    if (Config.config.battleLoading.removeVehicleLevel)
                        proxy.vehicleLevelIcon.visible = false;
                    if (Config.config.battleLoading.removeVehicleTypeIcon)
                        proxy.vehicleTypeIcon.visible = false;

                    // ClanIcon
                    attachClanIconToPlayer();

                    var isIconHighlighted:Boolean = App.colorSchemeMgr != null && (!Config.config.battleLoading.darkenNotReadyIcon || proxy.enabled) && formatOptions.alive;

                    proxy.vehicleIconLoader.transform.colorTransform =
                        App.colorSchemeMgr.getScheme(isIconHighlighted ? "normal" : "normal_dead").colorTransform;

                    // Set Text Fields
                    var textFieldColorString:String = proxy.textField.htmlText.match(/ COLOR="(#[0-9A-F]{6})"/)[1];

                    var nickFieldText:String = Macros.Format(WGUtils.GetPlayerName(_fullPlayerName), team == XfwConst.TEAM_ALLY
                        ? Config.config.battleLoading.formatLeftNick : Config.config.battleLoading.formatRightNick, formatOptions);
                    proxy.textField.htmlText = "<font color='" + textFieldColorString + "'>" + nickFieldText + "</font>";

                    var vehicleFieldText:String = Macros.Format(WGUtils.GetPlayerName(_fullPlayerName), team == XfwConst.TEAM_ALLY
                        ? Config.config.battleLoading.formatLeftVehicle : Config.config.battleLoading.formatRightVehicle, formatOptions);
                    proxy.vehicleField.htmlText = "<font color='" + textFieldColorString + "'>" + vehicleFieldText + "</font>";
                }
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
            //Logger.add("onVehicleIconLoadComplete: " + _fullPlayerName);

            // resize icons to avoid invalid resizing of item
            //if (proxy.vehicleIconLoader.width > 84 || proxy.vehicleIconLoader.height > 24)
            /*if (proxy.vehicleIconLoader.height > 24)
            {
                //var c:Number = Math.min(84 / proxy.vehicleIconLoader.width, 24 / proxy.vehicleIconLoader.height);
                var c:Number = 24 / proxy.vehicleIconLoader.height;
                proxy.vehicleIconLoader.scaleX = c;
                proxy.vehicleIconLoader.scaleY = c;
            }*/

            _vehicleIconLoaded = true;

            // crop large icons to avoid invalid resizing of item
            // proxy.vehicleIconLoader.scrollRect = new Rectangle(0, 0, 84, 24);

            // disable icons mirroring (for alternative icons)
            if (Config.config.battle.mirroredVehicleIcons == false)
            {
                if (team == XfwConst.TEAM_ENEMY)
                {
                    proxy.vehicleIconLoader.scaleX = -Math.abs(proxy.vehicleIconLoader.scaleX);
                    proxy.vehicleIconLoader.x -= proxy.vehicleIconLoader.width;
                    //Logger.add(proxy.vehicleIconLoader.width + "x" + proxy.vehicleIconLoader.height);
                }
            }
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + _fullPlayerName);
            proxy.vehicleField.condenseWhite = false;
            if (_model != null && proxy.initialized)
                proxy.invalidate();
        }

        private var _clanIconLoaded:Boolean = false;
        private function attachClanIconToPlayer():void
        {
            if (_clanIconLoaded)
                return;

            _clanIconLoaded = true;

            var cfg:CClanIcon = Config.config.battleLoading.clanIcon;
            if (!cfg.show)
                return;

            var name:String = WGUtils.GetPlayerName(_fullPlayerName);

            var statData:StatData = Stat.getData(name);
            if (statData == null)
                return;

            var icon:ClanIcon = new ClanIcon(cfg, proxy.vehicleIconLoader.x, proxy.vehicleIconLoader.y, team,
                _model.accountDBID,
                name,
                WGUtils.GetClanNameWithoutBrackets(_fullPlayerName),
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
                    offset = MAXIMUM_VEHICLE_ICON_WIDTH;
                icon.x += proxy.parent.parent.x + proxy.parent.x + proxy.x + offset;
                icon.y += proxy.parent.parent.y + proxy.parent.y + proxy.y;
            });
        }
    }

}

/*
_model: { // net.wg.gui.lobby.battleloading.vo::VehicleInfoVO
  "isFallout": false,
  "vLevel": 10,
  "teamColor": "red",
  "vehicleType": "SPG",
  "points": 0,
  "isPlayerTeam": false,
  "isCurrentSquad": false,
  "isCurrentPlayer": false,
  "region": null,
  "clanAbbrev": "OTMK",
  "igrType": 0,
  "playerName": "Chaoticpie_US",
  "vehicleGuiName": "ConquerorGC",
  "vehicleName": "ConquerorGC",
  "vehicleIcon": "../maps/icons/vehicle/contour/uk-GB31_Conqueror_Gun.png",
  "vehicleAction": 0,
  "squadIndex": 0,
  "playerStatus": 0,
  "vehicleStatus": 3,
  "prebattleID": 0,
  "vehicleID": 4633566,
  "isSpeaking": false,
  "isMuted": false,
  "accountDBID": 1011569697
}
*/
