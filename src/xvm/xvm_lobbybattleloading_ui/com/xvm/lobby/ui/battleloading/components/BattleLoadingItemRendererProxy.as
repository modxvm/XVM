/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleloading.components
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.extraFields.*;
    import com.xvm.vo.*;
    import com.xvm.battle.vo.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.lobby.ui.battleloading.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.battleloading.*;
    import net.wg.gui.lobby.battleloading.vo.*;
    import scaleform.gfx.*;

    public class BattleLoadingItemRendererProxy implements IExtraFieldGroupHolder
    {
        public static const UI_TYPE_TABLE:String = "table";
        public static const UI_TYPE_TIPS:String = "tips";

        private static const NAME_FIELD_WIDTH_DELTA_TABLE:int = 100;
        private static const NAME_FIELD_WIDTH_DELTA_TIPS:int = 40;
        private static const VEHICLE_FIELD_WIDTH_TABLE:int = 250;
        private static const VEHICLE_FIELD_WIDTH_TIPS:int = 100;
        private static const VEHICLE_TYPE_ICON_WIDTH:Number = 25;
        private static const MAXIMUM_VEHICLE_ICON_WIDTH:int = 80;

        private static const ICONS_AREA_WIDTH:int = 80;
        private static const SQUAD_ITEMS_AREA_WIDTH:int = 25;

        private var DEFAULT_PLAYER_NAME_X:Number;
        private var DEFAULT_PLAYER_NAME_WIDTH:Number;

        private var ui:PlayerItemRenderer;
        private var uiType:String;
        private var _isLeftPanel:Boolean;

        private var _model:VehicleInfoVO;

        private var _vehicleIconLoaded:Boolean = false;

        private var squad_x:Number;
        private var textField_x:Number;
        private var textField_width:Number;
        private var vehicleIconLoader_x:Number;
        private var vehicleLevelIcon_x:Number;
        private var vehicleTypeIcon_x:Number;

        private var _substrateHolder:MovieClip;
        private var _bottomHolder:MovieClip;
        private var _normalHolder:MovieClip;
        private var _topHolder:MovieClip;

        private var extraFields:ExtraFieldsGroup = null;

        private var currentPlayerState:VOPlayerState;

        // for debug
        public function _debug():void
        {
            setInterval(function():void {
                _model.vehicleStatus = 3;
                ui.setData(_model);
            }, 1000);
        }

        public function BattleLoadingItemRendererProxy(ui:PlayerItemRenderer, uiType:String, isLeftPanel:Boolean)
        {
            this.ui = ui;
            this.uiType = uiType;
            this._isLeftPanel = isLeftPanel;

            if (Macros.FormatBooleanGlobal(cfg.nameFieldShowBorder, false))
            {
                ui.textField.border = true;
                ui.textField.borderColor = 0x00FF00;
            }

            if (Macros.FormatBooleanGlobal(cfg.vehicleFieldShowBorder, false))
            {
                ui.vehicleField.border = true;
                ui.vehicleField.borderColor = 0xFFFF00;
            }

            DEFAULT_PLAYER_NAME_X = ui.textField.x;
            DEFAULT_PLAYER_NAME_WIDTH = ui.textField.width;

            _substrateHolder = ui.addChildAt(new MovieClip(), 0) as MovieClip;
            _bottomHolder = _substrateHolder;
            _normalHolder = ui.addChildAt(new MovieClip(), ui.getChildIndex(ui.playerActionMarker) + 1) as MovieClip;
            _topHolder = ui.addChild(new MovieClip()) as MovieClip;

            createExtraFields();

            //_debug();
        }

        public function configUI():void
        {
            ui.vehicleIconLoader.addEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete, false, 0, true);

            // Load battle stat
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true)
            if (Stat.battleStatLoaded)
            {
                onStatLoaded(null);
            }

            // fix bad align in 0.9.9, 0.9.10
            var dx:int = team == XfwConst.TEAM_ALLY ? 23 : -20;
            ui.vehicleIconLoader.x += dx;
            ui.vehicleLevelIcon.x += dx;
            ui.vehicleTypeIcon.x += dx;

            // Setup controls

            // setup vehicle field
            TextFieldEx.setVerticalAlign(ui.vehicleField, TextFieldAutoSize.CENTER);
            TextFieldEx.setVerticalAutoSize(ui.vehicleField, TextFieldAutoSize.CENTER);
            ui.vehicleField.condenseWhite = true;
            ui.vehicleField.scaleX = 1;
            ui.vehicleField.width = getVehicleFieldWidth();

            ui.vehicleIconLoader.autoSize = false;

            var textFieldWidthDelta:int = getNameFieldWidthDelta();

            textField_width = ui.textField.width + textFieldWidthDelta;

            if (team == XfwConst.TEAM_ALLY)
            {
                squad_x = ui.squad.x + Macros.FormatNumberGlobal(cfg.squadIconOffsetXLeft, 0);
                textField_x = ui.textField.x + Macros.FormatNumberGlobal(cfg.nameFieldOffsetXLeft, 0);
                var vehicleIconOffsetXLeft:Number = Macros.FormatNumberGlobal(cfg.vehicleIconOffsetXLeft, 0);
                vehicleIconLoader_x = ui.vehicleIconLoader.x + vehicleIconOffsetXLeft;
                vehicleLevelIcon_x = ui.vehicleLevelIcon.x + vehicleIconOffsetXLeft;
                vehicleTypeIcon_x = ui.vehicleTypeIcon.x + vehicleIconOffsetXLeft;
            }
            else
            {
                squad_x = ui.squad.x - Macros.FormatNumberGlobal(cfg.squadIconOffsetXRight, 0);
                textField_x = ui.textField.x - Macros.FormatNumberGlobal(cfg.nameFieldOffsetXRight, 0) - textFieldWidthDelta;
                var vehicleIconOffsetXRight:Number = Macros.FormatNumberGlobal(cfg.vehicleIconOffsetXRight, 0);
                vehicleIconLoader_x = ui.vehicleIconLoader.x - vehicleIconOffsetXRight;
                vehicleLevelIcon_x = ui.vehicleLevelIcon.x - vehicleIconOffsetXRight;
                vehicleTypeIcon_x = ui.vehicleTypeIcon.x - vehicleIconOffsetXRight;
            }
        }

        public function onDispose():void
        {
            ui.vehicleIconLoader.removeEventListener(UILoaderEvent.COMPLETE, onVehicleIconLoadComplete);

            disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;
        }

        public function fixData(data:VehicleInfoVO):Object
        {
            if (data)
            {
                try
                {
                    _model = data;

                    var vdata:VOVehicleData = VehicleInfo.getByIcon(_model.vehicleIcon);
                    if (vdata)
                    {
                        Macros.RegisterPlayerMacrosData(_model.vehicleID, _model.accountDBID, _model.playerName, _model.clanAbbrev, team == XfwConst.TEAM_ALLY);
                        Macros.RegisterVehicleMacrosData(_model.playerName, vdata.vehCD);
                    }

                    // Alternative icon set
                    if (!ui.vehicleIconLoader.sourceAlt || ui.vehicleIconLoader.sourceAlt == Defines.WG_CONTOUR_ICON_NOIMAGE)
                    {
                        ui.vehicleIconLoader.sourceAlt = Defines.WG_CONTOUR_ICON_PATH + vdata.sysname + ".png";
                        _model.vehicleIcon = _model.vehicleIcon.replace(Defines.WG_CONTOUR_ICON_PATH,
                            Defines.XVMRES_ROOT + ((team == XfwConst.TEAM_ALLY)
                            ? Macros.FormatStringGlobal(Config.config.iconset.battleLoadingAlly)
                            : Macros.FormatStringGlobal(Config.config.iconset.battleLoadingEnemy)));
                    }
                    else
                    {
                        _model.vehicleIcon = ui.vehicleIconLoader.source;
                    }
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                    Logger.addObject(_model);
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
                if (_model && ui.initialized)
                {
                    currentPlayerState = BattleState.get(_model.vehicleID);

                    var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                    options.vehicleID = _model.vehicleID;
                    options.playerName = _model.playerName;
                    options.vehicleStatus = _model.vehicleStatus;
                    options.playerStatus = _model.playerStatus;
                    options.isSelected = _model.isCurrentPlayer;
                    options.isCurrentPlayer = _model.isCurrentPlayer;
                    options.isSquadPersonal = _model.isCurrentSquad;
                    options.squadIndex = _model.squadIndex;
                    options.position = ui.index + 1;

                    var isIconHighlighted:Boolean = App.colorSchemeMgr && (!Macros.FormatBooleanGlobal(cfg.darkenNotReadyIcon) || ui.enabled) && options.isAlive;

                    ui.vehicleIconLoader.transform.colorTransform =
                        App.colorSchemeMgr.getScheme(isIconHighlighted ? "normal" : "normal_dead").colorTransform;

                    // controls visibility
                    if (Macros.FormatBooleanGlobal(cfg.removeSquadIcon))
                        ui.squad.visible = false;
                    ui.vehicleIconLoader.alpha = Macros.FormatNumberGlobal(cfg.vehicleIconAlpha, 100) / 100.0;
                    if (Macros.FormatBooleanGlobal(cfg.removeVehicleLevel))
                        ui.vehicleLevelIcon.visible = false;
                    if (Macros.FormatBooleanGlobal(cfg.removeVehicleTypeIcon))
                        ui.vehicleTypeIcon.visible = false;

                    // fields x positions
                    ui.squad.x = squad_x;
                    ui.textField.x = textField_x;
                    ui.textField.width = textField_width;
                    ui.vehicleIconLoader.x = vehicleIconLoader_x;
                    ui.vehicleLevelIcon.x = vehicleLevelIcon_x;
                    ui.vehicleTypeIcon.x = vehicleTypeIcon_x;

                    // vehicleField
                    if (team == XfwConst.TEAM_ALLY)
                    {
                        ui.vehicleField.x = ui.vehicleIconLoader.x - getVehicleFieldWidth();
                        if (Macros.FormatBooleanGlobal(cfg.removeVehicleTypeIcon))
                        {
                            if (uiType == UI_TYPE_TIPS)
                            {
                                ui.vehicleField.width = getVehicleFieldWidth() + VEHICLE_TYPE_ICON_WIDTH - 5;
                                ui.vehicleField.x += 5 - VEHICLE_TYPE_ICON_WIDTH;
                            }
                        }
                        else
                        {
                            if (uiType == UI_TYPE_TIPS)
                            {
                                ui.vehicleField.x += 5 - VEHICLE_TYPE_ICON_WIDTH;
                            }
                            else
                            {
                                ui.vehicleField.x += -2 - VEHICLE_TYPE_ICON_WIDTH;
                            }
                        }
                        ui.vehicleField.x += Macros.FormatNumberGlobal(cfg.vehicleFieldOffsetXLeft, 0);
                    }
                    else
                    {
                        ui.vehicleField.x = ui.vehicleIconLoader.x + (ui.vehicleIconLoader.scaleX < 0 ? MAXIMUM_VEHICLE_ICON_WIDTH : 0);
                        if (Macros.FormatBooleanGlobal(cfg.removeVehicleTypeIcon))
                        {
                            if (uiType == UI_TYPE_TIPS)
                            {
                                ui.vehicleField.width = getVehicleFieldWidth() + VEHICLE_TYPE_ICON_WIDTH - 7;
                            }
                        }
                        else
                        {
                            if (uiType == UI_TYPE_TIPS)
                            {
                                ui.vehicleField.x += VEHICLE_TYPE_ICON_WIDTH - 7;
                            }
                            else
                            {
                                ui.vehicleField.x += VEHICLE_TYPE_ICON_WIDTH + 2;
                            }
                        }
                        ui.vehicleField.x -= Macros.FormatNumberGlobal(cfg.vehicleFieldOffsetXRight, 0);
                    }

                    // Set Text Fields
                    var textFieldColorString:String = ui.textField.htmlText.match(/ COLOR="(#[0-9A-F]{6})"/)[1];

                    var nickFieldText:String = Macros.Format(team == XfwConst.TEAM_ALLY ? cfg.formatLeftNick : cfg.formatRightNick, options);
                    ui.textField.htmlText = "<font color='" + textFieldColorString + "'>" + nickFieldText + "</font>";

                    var vehicleFieldText:String = Macros.Format(team == XfwConst.TEAM_ALLY ? cfg.formatLeftVehicle : cfg.formatRightVehicle, options);
                    ui.vehicleField.htmlText = "<font color='" + textFieldColorString + "'>" + vehicleFieldText + "</font>";

                    // Extra Fields
                    updateExtraFields();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return _isLeftPanel;
        }

        public function get substrateHolder():MovieClip
        {
            return _substrateHolder;
        }

        public function get bottomHolder():MovieClip
        {
            return _bottomHolder;
        }

        public function get normalHolder():MovieClip
        {
            return _normalHolder;
        }

        public function get topHolder():MovieClip
        {
            return _topHolder;
        }

        public function getSchemeNameForVehicle():String
        {
            return null;
            /*var highlightVehicleIcon:Boolean = Config.config.battle.highlightVehicleIcon;
            return PlayerStatusSchemeName.getSchemeNameForVehicle(
                currentPlayerState.isCurrentPlayer && highlightVehicleIcon,
                currentPlayerState.isSquadPersonal && highlightVehicleIcon,
                currentPlayerState.isTeamKiller && highlightVehicleIcon,
                currentPlayerState.isDead,
                currentPlayerState.isOffline);*/
        }

        public function getSchemeNameForPlayer():String
        {
            return null;
            /*return PlayerStatusSchemeName.getSchemeNameForPlayer(
                currentPlayerState.isCurrentPlayer,
                currentPlayerState.isSquadPersonal,
                currentPlayerState.isTeamKiller,
                currentPlayerState.isDead,
                currentPlayerState.isOffline);*/
        }

        // PRIVATE

        private function get team():int
        {
            return (ui is UI_LeftItemRendererTable || ui is UI_LeftItemRendererTips) ? XfwConst.TEAM_ALLY : XfwConst.TEAM_ENEMY;
        }

        private function getNameFieldWidthDelta():int
        {
            var w:Number =  (uiType == UI_TYPE_TABLE) ? NAME_FIELD_WIDTH_DELTA_TABLE : NAME_FIELD_WIDTH_DELTA_TIPS;
            if (team == XfwConst.TEAM_ALLY)
            {
                w += Macros.FormatNumberGlobal(cfg.nameFieldWidthDeltaLeft, 0);
            }
            else
            {
                w += Macros.FormatNumberGlobal(cfg.nameFieldWidthDeltaRight, 0);
            }
            return w;
        }

        private function getVehicleFieldWidth():int
        {
            var w:Number = (uiType == UI_TYPE_TABLE) ? VEHICLE_FIELD_WIDTH_TABLE : VEHICLE_FIELD_WIDTH_TIPS;
            if (team == XfwConst.TEAM_ALLY)
            {
                w += Macros.FormatNumberGlobal(cfg.vehicleFieldWidthDeltaLeft, 0);
            }
            else
            {
                w += Macros.FormatNumberGlobal(cfg.vehicleFieldWidthDeltaRight, 0);
            }
            return w;
        }

        private function get cfg():CBattleLoading
        {
            return uiType == UI_TYPE_TABLE ? Config.config.battleLoading : Config.config.battleLoadingTips;
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
                    ui.vehicleIconLoader.scaleX = -Math.abs(ui.vehicleIconLoader.scaleX);
                    ui.vehicleIconLoader.x = vehicleIconLoader_x;
                    ui.vehicleLevelIcon.x = vehicleLevelIcon_x;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            //Logger.add("onStatLoaded: " + _model.playerName);
            ui.vehicleField.condenseWhite = false;
            if (_model && ui.initialized)
                ui.invalidate();
        }

        // extra fields

        private function createExtraFields():void
        {
            var formats:Array = _isLeftPanel ? cfg.extraFieldsLeft : cfg.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFields = new ExtraFieldsGroup(this, formats);
            }
        }

        private function disposeExtraFields():void
        {
            if (extraFields)
            {
                extraFields.dispose();
                extraFields = null;
            }
        }

        private function updateExtraFields():void
        {
            if (extraFields)
            {
                var offsetX:Number;
                var bindToIconOffset:Number;
                if (_isLeftPanel)
                {
                    offsetX = DEFAULT_PLAYER_NAME_X - SQUAD_ITEMS_AREA_WIDTH;
                    bindToIconOffset = ui.vehicleIconLoader.x - offsetX;
                }
                else
                {
                    offsetX = DEFAULT_PLAYER_NAME_X + DEFAULT_PLAYER_NAME_WIDTH + SQUAD_ITEMS_AREA_WIDTH;
                    bindToIconOffset = ui.vehicleIconLoader.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
                }
                extraFields.visible = true;
                extraFields.update(currentPlayerState, bindToIconOffset, offsetX, ui.vehicleIconLoader.y);
            }
        }
    }
}
