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
        private static const VEHICLE_TYPE_ICON_WIDTH:Number = 25;
        private static const MAXIMUM_VEHICLE_ICON_WIDTH:int = 80;

        private var proxy:PlayerItemRenderer;

        private var _model:VehicleInfoVO;

        private var _vehicleIconLoaded:Boolean = false;

        private var squad_x:Number;
        private var textField_x:Number;
        private var textField_width:Number;
        private var vehicleIconLoader_x:Number;
        private var vehicleLevelIcon_x:Number;
        private var vehicleTypeIcon_x:Number;


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
        }

        public function configUI():void
        {
            proxy.vehicleIconLoader.addEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete);

            // Add stat loading handler
            Stat.loadBattleStat(this, onStatLoaded);

            // fix bad align in 0.9.9, 0.9.10
            var dx:int = team == XfwConst.TEAM_ALLY ? 23 : -20;
            proxy.vehicleIconLoader.x += dx;
            proxy.vehicleLevelIcon.x += dx;
            proxy.vehicleTypeIcon.x += dx;

            // Setup controls

            // setup vehicle field
            TextFieldEx.setVerticalAlign(proxy.vehicleField, TextFieldAutoSize.CENTER);
            TextFieldEx.setVerticalAutoSize(proxy.vehicleField, TextFieldAutoSize.CENTER);
            proxy.vehicleField.condenseWhite = true;
            proxy.vehicleField.scaleX = 1;
            proxy.vehicleField.width = VEHICLE_FIELD_WIDTH;

            proxy.vehicleIconLoader.autoSize = false;

            textField_width = proxy.textField.width + 100;
            if (team == XfwConst.TEAM_ALLY)
            {
                squad_x = proxy.squad.x + Config.config.battleLoading.squadIconOffsetXLeft;
                textField_x = proxy.textField.x + Config.config.battleLoading.nameFieldOffsetXLeft;
                vehicleIconLoader_x = proxy.vehicleIconLoader.x + Config.config.battleLoading.vehicleIconOffsetXLeft;
                vehicleLevelIcon_x = proxy.vehicleLevelIcon.x + Config.config.battleLoading.vehicleIconOffsetXLeft;
                vehicleTypeIcon_x = proxy.vehicleTypeIcon.x + Config.config.battleLoading.vehicleIconOffsetXLeft;
            }
            else
            {
                squad_x = proxy.squad.x - Config.config.battleLoading.squadIconOffsetXRight;
                textField_x = proxy.textField.x - Config.config.battleLoading.nameFieldOffsetXRight - 100;
                vehicleIconLoader_x = proxy.vehicleIconLoader.x - Config.config.battleLoading.vehicleIconOffsetXRight;
                vehicleLevelIcon_x = proxy.vehicleLevelIcon.x - Config.config.battleLoading.vehicleIconOffsetXRight;
                vehicleTypeIcon_x = proxy.vehicleTypeIcon.x - Config.config.battleLoading.vehicleIconOffsetXRight;
            }
        }

        public function onDispose():void
        {
            proxy.vehicleIconLoader.removeEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete);
        }

        public function fixData(data:VehicleInfoVO):Object
        {
            if (data != null)
            {
                try
                {
                    _model = data;

                    var fullPlayerName:String = App.utils.commons.getFullPlayerName(
                        App.utils.commons.getUserProps(_model.playerName, _model.clanAbbrev, _model.region, _model.igrType));
                    var vdata:VehicleData = VehicleInfo.getByIcon(_model.vehicleIcon);
                    Macros.RegisterMinimalMacrosData(_model.accountDBID, fullPlayerName, vdata.vid, team);

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
            }

            return _model;
        }

        public function draw():void
        {
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

                    // ClanIcon
                    attachClanIconToPlayer();

                    var isIconHighlighted:Boolean = App.colorSchemeMgr != null && (!Config.config.battleLoading.darkenNotReadyIcon || proxy.enabled) && formatOptions.alive;

                    proxy.vehicleIconLoader.transform.colorTransform =
                        App.colorSchemeMgr.getScheme(isIconHighlighted ? "normal" : "normal_dead").colorTransform;

                    // controls visibility
                    if (Config.config.battleLoading.removeSquadIcon)
                        proxy.squad.visible = false;
                    if (Config.config.battleLoading.removeVehicleLevel)
                        proxy.vehicleLevelIcon.visible = false;
                    if (Config.config.battleLoading.removeVehicleTypeIcon)
                        proxy.vehicleTypeIcon.visible = false;

                    // fields x positions
                    proxy.squad.x = squad_x;
                    proxy.textField.x = textField_x;
                    proxy.textField.width = textField_width;
                    proxy.vehicleIconLoader.x = vehicleIconLoader_x;
                    proxy.vehicleLevelIcon.x = vehicleLevelIcon_x;
                    proxy.vehicleTypeIcon.x = vehicleTypeIcon_x;

                    // vehicleField
                    if (team == XfwConst.TEAM_ALLY)
                    {
                        proxy.vehicleField.x = proxy.vehicleIconLoader.x - VEHICLE_FIELD_WIDTH - 1;
                        if (!Config.config.battleLoading.removeVehicleTypeIcon)
                            proxy.vehicleField.x -= VEHICLE_TYPE_ICON_WIDTH + 2;
                        proxy.vehicleField.x += Config.config.battleLoading.vehicleFieldOffsetXLeft;
                    }
                    else
                    {
                        proxy.vehicleField.x = proxy.vehicleIconLoader.x + (proxy.vehicleIconLoader.scaleX < 0 ? MAXIMUM_VEHICLE_ICON_WIDTH : 0) + 4;
                        if (!Config.config.battleLoading.removeVehicleTypeIcon)
                            proxy.vehicleField.x += VEHICLE_TYPE_ICON_WIDTH + 4;
                        proxy.vehicleField.x -= Config.config.battleLoading.vehicleFieldOffsetXRight;
                    }

                    // Set Text Fields
                    var textFieldColorString:String = proxy.textField.htmlText.match(/ COLOR="(#[0-9A-F]{6})"/)[1];

                    var nickFieldText:String = Macros.Format(_model.playerName, team == XfwConst.TEAM_ALLY
                        ? Config.config.battleLoading.formatLeftNick : Config.config.battleLoading.formatRightNick, formatOptions);
                    proxy.textField.htmlText = "<font color='" + textFieldColorString + "'>" + nickFieldText + "</font>";

                    var vehicleFieldText:String = Macros.Format(_model.playerName, team == XfwConst.TEAM_ALLY
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
            //Logger.add("onVehicleIconLoadComplete: " + _model.playerName);

            try
            {
                // disable icons mirroring (for alternative icons)
                if (!_vehicleIconLoaded)
                {
                    if (Config.config.battle.mirroredVehicleIcons == false && team == XfwConst.TEAM_ENEMY)
                    {
                        vehicleIconLoader_x -= MAXIMUM_VEHICLE_ICON_WIDTH;
                        vehicleLevelIcon_x -= 40;
                    }
                }

                _vehicleIconLoaded = true;

                if (Config.config.battle.mirroredVehicleIcons == false && team == XfwConst.TEAM_ENEMY)
                {
                    proxy.vehicleIconLoader.scaleX = -Math.abs(proxy.vehicleIconLoader.scaleX);
                    proxy.vehicleIconLoader.x = vehicleIconLoader_x;
                    proxy.vehicleLevelIcon.x = vehicleLevelIcon_x;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + _model.playerName);
            proxy.vehicleField.condenseWhite = false;
            if (_model != null && proxy.initialized)
                proxy.invalidate();
        }

        private var _clanIconLoaded:Boolean = false;
        private function attachClanIconToPlayer():void
        {
            if (_clanIconLoaded)
                return;

            var cfg:CClanIcon = Config.config.battleLoading.clanIcon;
            if (!cfg.show)
                return;

            var statData:StatData = Stat.getData(_model.playerName);
            if (statData == null)
                return;

            _clanIconLoaded = true;

            var icon:ClanIcon = new ClanIcon(cfg, proxy.vehicleIconLoader.x, proxy.vehicleIconLoader.y, team,
                _model.accountDBID,
                _model.playerName,
                _model.clanAbbrev,
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
