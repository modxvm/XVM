/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.extraFields.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.ranked.stats.components.playersPanel.list.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;

    public class RankedPlayersPanelListItemProxy extends UIComponent implements IExtraFieldGroupHolder
    {
        // from PlayersPanelListItem.as
        private static const WIDTH:int = 339;
        private static const ICONS_AREA_WIDTH_WG:int = 65;
        private static const ICONS_AREA_WIDTH:int = 80;
        private static const XVM_ICONS_AREA_WIDTH:int = 80;
        private static const RANK_ICON_AREA_WIDTH:int = 24;

        private static const VEHICLE_TF_LEFT_X:int = WIDTH - 63 /* default ICONS_AREA_WIDTH */;
        private static const VEHICLE_ICON_LEFT_X:int = VEHICLE_TF_LEFT_X + 15;
        private static const VEHICLE_LEVEL_LEFT_X:int = VEHICLE_TF_LEFT_X + 30;

        private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + 63 /* default ICONS_AREA_WIDTH */;
        private static const VEHICLE_ICON_RIGHT_X:int = VEHICLE_TF_RIGHT_X - 17;
        private static const VEHICLE_LEVEL_RIGHT_X:int = VEHICLE_TF_RIGHT_X - 47;

        public static const INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static const INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static const INVALIDATE_UPDATE_COLORS:String = "UPDATE_COLORS";
        public static const INVALIDATE_UPDATE_POSITIONS:String = "UPDATE_POSITIONS";

        private static const MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED:String = "MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED";

        private static var s_maxPlayerNameTextWidthsLeft:Dictionary = new Dictionary();
        private static var s_maxPlayerNameTextWidthsRight:Dictionary = new Dictionary();

        public var _isLeftPanel:Boolean;
        public var xvm_enabled:Boolean;

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLE_ICON_X:int;
        private var DEFAULT_VEHICLE_LEVEL_X:int;
        private var DEFAULT_FRAGS_WIDTH:int;
        private var DEFAULT_VEHICLE_WIDTH:int;
        private var DEFAULT_BADGEICON_WIDTH:int;
        private var DEFAULT_PLAYERNAMECUT_WIDTH:int;

        private var bcfg:CBattle;
        private var pcfg:CPlayersPanel;
        private var mcfg:CPlayersPanelMode;
        private var ncfg:CPlayersPanelNoneMode;
        private var ui:PlayersPanelListItem;

        private var _userProps:IUserProps = null;
        private var _vehicleID:Number = NaN;

        private var _standardTextFieldsTexts:Object = {};

        private var opt_removeSelectedBackground:Boolean;
        private var opt_vehicleIconAlpha:Number;
        private var mopt_removeSquadIcon:Boolean;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private var extraFieldsHidden:ExtraFields = null;
        private var extraFieldsShort:ExtraFieldsGroup = null;
        private var extraFieldsMedium:ExtraFieldsGroup = null;
        private var extraFieldsLong:ExtraFieldsGroup = null;
        private var extraFieldsFull:ExtraFieldsGroup = null;

        private var currentPlayerState:VOPlayerState;
        private var _vehicleImage:String;

        public function RankedPlayersPanelListItemProxy(ui:PlayersPanelListItem, isLeftPanel:Boolean)
        {
            this.ui = ui;
            mouseEnabled = false;
            mouseChildren = false;
            _isLeftPanel = isLeftPanel;

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.addEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.addEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, onMaxPlayerNameTextWidthChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);

            _substrateHolder = ui.addChildAt(new Sprite(), 0) as Sprite;
            _bottomHolder = ui.addChildAt(new Sprite(), 1) as Sprite;
            _normalHolder = this;
            _topHolder = ui.addChild(new Sprite()) as Sprite;

            DEFAULT_BG_ALPHA = ui.bg.alpha;
            DEFAULT_SELFBG_ALPHA = ui.selfBg.alpha;
            DEFAULT_DEADBG_ALPHA = ui.deadBg.alpha;
            DEFAULT_VEHICLE_ICON_X = ui.vehicleIcon.x;
            DEFAULT_VEHICLE_LEVEL_X = ui.vehicleLevel.x;
            DEFAULT_FRAGS_WIDTH = ui.fragsTF.width;
            DEFAULT_VEHICLE_WIDTH = ui.vehicleTF.width;
            DEFAULT_BADGEICON_WIDTH = ui.badgeIcon.width;
            DEFAULT_PLAYERNAMECUT_WIDTH = ui.playerNameCutTF.width;

            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.removeEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, onMaxPlayerNameTextWidthChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);

            disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            _userProps = null;

            super.onDispose();
        }

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
            _vehicleID = BattleState.getVehicleIDByPlayerName(_userProps.userName);
            invalidate(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE);
        }

        // TODO:9.15 remove after fix
        // 9.19 - still present
        public function setIsInteractive(isInteractive:Boolean):void
        {
            // fix WG bug (WoT 0.9.15.1+) - cursor position remains on the item when Ctrl key unpressed.
            App.utils.scheduler.scheduleTask(function():void
            {
                App.toolTipMgr.hide();
            }, 500);
        }

        public function setVehicleIcon(vehicleImage:String):void
        {
            if (_vehicleImage != vehicleImage)
            {
                _vehicleImage = vehicleImage;
            }
            if (mcfg == null)
                return;
            var atlasName:String = isLeftPanel ? UI_RankedPlayersPanel.playersPanelLeftAtlas : UI_RankedPlayersPanel.playersPanelRightAtlas;
            if (!App.atlasMgr.isAtlasInitialized(atlasName))
            {
                atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
            }
            ui.vehicleIcon.graphics.clear();
            App.atlasMgr.drawGraphics(atlasName, vehicleImage, ui.vehicleIcon.graphics, "unknown" /*BattleAtlasItem.VEHICLE_TYPE_UNKNOWN*/);
            if (_userProps)
            {
                invalidate(INVALIDATE_UPDATE_POSITIONS);
            }
        }

        // UIComponent

        override protected function draw():void
        {
            try
            {
                super.draw();

                if (!xvm_enabled || mcfg == null || _userProps == null)
                    return;

                if (isInvalid(INVALIDATE_PLAYER_STATE))
                {
                    currentPlayerState = BattleState.get(_vehicleID);
                }
                if (isInvalid(INVALIDATE_UPDATE_COLORS))
                {
                    updateVehicleIcon();
                    _standardTextFieldsTexts = { };
                }
                if (isInvalid(INVALIDATE_PANEL_STATE))
                {
                    applyState();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE, INVALIDATE_UPDATE_COLORS))
                {
                    updateStandardFields();
                }
                if (isInvalid(INVALIDATE_UPDATE_POSITIONS))
                {
                    updatePositions();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE, INVALIDATE_UPDATE_POSITIONS))
                {
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

        public function get substrateHolder():Sprite
        {
            return _substrateHolder;
        }

        public function get bottomHolder():Sprite
        {
            return _bottomHolder;
        }

        public function get normalHolder():Sprite
        {
            return _normalHolder;
        }

        public function get topHolder():Sprite
        {
            return _topHolder;
        }

        public function getSchemeNameForVehicle(options:IVOMacrosOptions):String
        {
            var highlightVehicleIcon:Boolean = bcfg.highlightVehicleIcon;
            return PlayerStatusSchemeName.getSchemeNameForVehicle(
                options.isCurrentPlayer && highlightVehicleIcon,
                options.isSquadPersonal && highlightVehicleIcon,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return PlayerStatusSchemeName.getSchemeNameForPlayer(
                options.isCurrentPlayer,
                options.isSquadPersonal,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        // PRIVATE

        // XVM events handlers

        private function setup():void
        {
            try
            {
                //Logger.add("RankedPlayersPanelListItemProxy.onConfigLoaded()");
                bcfg = Config.config.battle;
                pcfg = Config.config.playersPanel;
                mcfg = pcfg[UI_RankedPlayersPanel.PLAYERS_PANEL_STATE_NAMES[(ui.xfw_state == -1 || ui.xfw_state == PLAYERS_PANEL_STATE.HIDEN) ? PLAYERS_PANEL_STATE.LONG : ui.xfw_state]];
                ncfg = pcfg.none;

                // revert mirrored icon and X offset
                ui.vehicleIcon.scaleX = 1;
                ui.vehicleIcon.x = DEFAULT_VEHICLE_ICON_X;
                ui.vehicleLevel.x = DEFAULT_VEHICLE_LEVEL_X;

                disposeExtraFields();

                xvm_enabled = Macros.FormatBooleanGlobal(pcfg.enabled, true);
                //Logger.add("xvm_enabled = " + xvm_enabled);
                if (xvm_enabled)
                {
                    opt_removeSelectedBackground = Macros.FormatBooleanGlobal(pcfg.removeSelectedBackground, false);
                    opt_vehicleIconAlpha = Macros.FormatNumberGlobal(pcfg.iconAlpha, 100) / 100.0;

                    var alpha:Number = Macros.FormatNumberGlobal(pcfg.alpha, 80) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = opt_removeSelectedBackground ? 0 : alpha;
                    ui.deadBg.alpha = alpha;

                    mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);

                    createExtraFields();
                }
                else
                {
                    ui.bg.alpha = DEFAULT_BG_ALPHA;
                    ui.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    ui.deadBg.alpha = DEFAULT_DEADBG_ALPHA;
                    ui.fragsTF.width = DEFAULT_FRAGS_WIDTH;
                    ui.vehicleTF.width = DEFAULT_VEHICLE_WIDTH;
                    ui.rankIcon.alpha = 1;
                    ui.badgeIcon.width = DEFAULT_BADGEICON_WIDTH;
                    ui.playerNameCutTF.width = DEFAULT_PLAYERNAMECUT_WIDTH;
                }

                ui.invalidateState();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onBattleComponentsVisible(e:BooleanEvent):void
        {
            if (extraFieldsHidden)
            {
                extraFieldsHidden.alpha = e.value ? 1 : 0;
            }
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (xvm_enabled && _userProps && e.vehicleID == _vehicleID)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onMaxPlayerNameTextWidthChanged(e:BooleanEvent):void
        {
            if (xvm_enabled && _userProps && e.value == isLeftPanel)
            {
                invalidate(INVALIDATE_UPDATE_POSITIONS);
            }
        }

        private function onAtlasLoaded(e:Event):void
        {
            if (xvm_enabled)
            {
                setVehicleIcon(_vehicleImage);
            }
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (xvm_enabled && _userProps && playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function applyState():void
        {
            //Logger.add("applyState: " + ui.xfw_state);
            BattleState.playersPanelMode = ui.xfw_state;
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    mcfg = pcfg[UI_RankedPlayersPanel.PLAYERS_PANEL_STATE_NAMES[ui.xfw_state]];
                    mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                    ui.fragsTF.visible = false;
                    ui.vehicleTF.visible = false;
                    ui.badgeIcon.visible = false;
                    ui.playerNameCutTF.visible = false;
                    ui.playerNameFullTF.visible = false;
                    if (mcfg.standardFields)
                    {
                        var len:int = mcfg.standardFields.length;
                        for (var i:int = 0; i < len; ++i)
                        {
                            switch (mcfg.standardFields[i].toLowerCase())
                            {
                                case "frags":
                                    ui.fragsTF.visible = true;
                                    break;
                                case "badge":
                                    ui.badgeIcon.visible = true;
                                    break;
                                case "nick":
                                    ui.playerNameFullTF.visible = true;
                                    break;
                                case "vehicle":
                                    ui.vehicleTF.visible = true;
                                    break;
                            }
                        }
                    }
                    break;
                case PLAYERS_PANEL_STATE.HIDEN:
                case -1:
                    BattleState.playersPanelWidthLeft = 0;
                    BattleState.playersPanelWidthRight = 0;
                    ui.visible = false;
                    //ui.x = isLeftPanel ? -WIDTH : WIDTH;
                    break;
            }
            if (extraFieldsHidden)
                extraFieldsHidden.visible = false;
            if (extraFieldsShort)
                extraFieldsShort.visible = false;
            if (extraFieldsMedium)
                extraFieldsMedium.visible = false;
            if (extraFieldsLong)
                extraFieldsLong.visible = false;
            if (extraFieldsFull)
                extraFieldsFull.visible = false;
            invalidate(INVALIDATE_UPDATE_POSITIONS);
        }

        // update

        private function updateVehicleIcon():void
        {
            var schemeName:String = getSchemeNameForVehicle(currentPlayerState);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleIcon.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleIcon.alpha *= opt_vehicleIconAlpha;
        }

        private function updateStandardFields():void
        {
            //Logger.add("update: " + ui.xfw_state);
            if (ui.xfw_state != -1 && ui.xfw_state != PLAYERS_PANEL_STATE.HIDEN)
            {
                if (ui.fragsTF.visible)
                {
                    updateStandardTextField(ui.fragsTF, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight, isLeftPanel ? mcfg.fragsShadowLeft : mcfg.fragsShadowRight);
                }
                if (ui.playerNameFullTF.visible)
                {
                    updateStandardTextField(ui.playerNameFullTF, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight, isLeftPanel ? mcfg.nickShadowLeft : mcfg.nickShadowRight);
                }
                if (ui.vehicleTF.visible)
                {
                    updateStandardTextField(ui.vehicleTF, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight, isLeftPanel ? mcfg.vehicleShadowLeft : mcfg.vehicleShadowRight);
                }
                updateVehicleLevel();
                updateRankIcon();
            }
        }

        private function updateStandardTextField(tf:TextField, format:String, shadowConfig:CShadow):void
        {
            //if (Config.IS_DEVELOPMENT) tf.border = true; tf.borderColor = 0xFF0000;

            var txt:String = Macros.Format(format, currentPlayerState) || "";
            if (_standardTextFieldsTexts[tf.name] == txt)
                return;
            _standardTextFieldsTexts[tf.name] = txt;
            var schemeName:String = getSchemeNameForPlayer(currentPlayerState);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            tf.htmlText = "<font color='" + XfwUtils.toHtmlColor(colorScheme.rgb) + "'>" + txt + "</font>";
            if (shadowConfig)
            {
                tf.filters = Utils.createShadowFiltersFromConfig(shadowConfig, currentPlayerState);
            }
            else
            {
                tf.filters = null;
            }
            invalidate(INVALIDATE_UPDATE_POSITIONS);
        }

        private function updateVehicleLevel():void
        {
            var schemeName:String = PlayerStatusSchemeName.getSchemeForVehicleLevel(currentPlayerState.isDead);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleLevel.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleLevel.alpha *= Macros.FormatNumber(mcfg.vehicleLevelAlpha, currentPlayerState, 100) / 100.0;
        }

        private function updateRankIcon():void
        {
            if (mopt_removeSquadIcon)
            {
                ui.rankIcon.alpha = 0;
            }
            else
            {
                ui.rankIcon.alpha = Macros.FormatNumber(mcfg.squadIconAlpha, currentPlayerState, 100) / 100.0;
            }
        }

        // update positions

        private function updatePositions():void
        {
            if (ui.xfw_state != -1 && ui.xfw_state != PLAYERS_PANEL_STATE.HIDEN)
            {
                if (mcfg.standardFields)
                {
                    if (isLeftPanel)
                    {
                        updateVehicleIconPositionLeft();
                        updatePositionsLeft();
                    }
                    else
                    {
                        updateVehicleIconPositionRight();
                        updatePositionsRight();
                    }
                }
            }
            this.x = bottomHolder.x = topHolder.x = -ui.x;
        }

        private function updateVehicleIconPositionLeft():void
        {
            var vehicleIconX:int = VEHICLE_ICON_LEFT_X + getFieldOffsetXLeft(ui.vehicleIcon);
            var vehicleLevelX:int = VEHICLE_LEVEL_LEFT_X + getFieldOffsetXLeft(ui.vehicleLevel);
            if (int(ui.vehicleIcon.x) != vehicleIconX)
            {
                ui.vehicleIcon.x = vehicleIconX;
            }
            if (int(ui.vehicleLevel.x) != vehicleLevelX)
            {
                ui.vehicleLevel.x = vehicleLevelX;
            }
        }

        private function updateVehicleIconPositionRight():void
        {
            var vehicleIconScaleX:Number;
            var vehicleIconX:int;
            var vehicleLevelX:int;
            if (bcfg.mirroredVehicleIcons)
            {
                vehicleIconScaleX = 1;
                vehicleIconX = VEHICLE_ICON_RIGHT_X - getFieldOffsetXRight(ui.vehicleIcon);
                vehicleLevelX = VEHICLE_LEVEL_RIGHT_X - getFieldOffsetXRight(ui.vehicleLevel);
            }
            else
            {
                vehicleIconScaleX = -1;
                vehicleIconX =  VEHICLE_ICON_RIGHT_X - getFieldOffsetXRight(ui.vehicleIcon) - ICONS_AREA_WIDTH;
                vehicleLevelX = VEHICLE_ICON_RIGHT_X - getFieldOffsetXRight(ui.vehicleLevel) - ICONS_AREA_WIDTH_WG;
            }
            if (ui.vehicleIcon.scaleX != vehicleIconScaleX)
            {
                ui.vehicleIcon.scaleX = vehicleIconScaleX;
            }
            if (int(ui.vehicleIcon.x) != vehicleIconX)
            {
                ui.vehicleIcon.x = vehicleIconX;
            }
            if (int(ui.vehicleLevel.x) != vehicleLevelX)
            {
                ui.vehicleLevel.x = vehicleLevelX;
            }
        }

        private function updatePositionsLeft():void
        {
            var field:DisplayObject;
            var lastX:int = VEHICLE_TF_LEFT_X;
            var newX:int;
            var width:int;
            var len:int = mcfg.standardFields.length;
            for (var i:int = len - 1; i >= 0; --i)
            {
                field = getFieldByConfigName(mcfg.standardFields[i]);
                if (field)
                {
                    width = updateFieldWidth(field);
                    lastX -= width - 1;
                    newX = lastX + getFieldOffsetXLeft(field);
                    //Logger.add(field.name + " lastX:" + lastX + " newX:" + newX + " x:" + field.x + " offset:" + getFieldOffsetXLeft(field));
                    if (int(field.x) != newX)
                    {
                        field.x = newX;
                    }
                }
            }
            ui.x = -(lastX - (mopt_removeSquadIcon ? 0 : RANK_ICON_AREA_WIDTH));
            //Logger.add("ui.x=" + ui.x + " ui.vehicleIcon.x=" + ui.vehicleIcon.x);
            ui.rankIcon.x = -ui.x;
            BattleState.playersPanelWidthLeft = WIDTH + ui.x;
        }

        private function updatePositionsRight():void
        {
            var field:DisplayObject;
            var lastX:int = VEHICLE_TF_RIGHT_X;
            var newX:int;
            var width:int;
            var len:int = mcfg.standardFields.length;
            for (var i:int = len - 1; i >= 0; --i)
            {
                field = getFieldByConfigName(mcfg.standardFields[i]);
                newX = lastX - getFieldOffsetXRight(field);
                if (field)
                {
                    width = updateFieldWidth(field);
                    if (int(field.x) != newX)
                    {
                        field.x = newX;
                    }
                    lastX += width - 1;
                }
            }
            ui.x = -(lastX + (mopt_removeSquadIcon ? 0 : RANK_ICON_AREA_WIDTH));
            ui.rankIcon.x = -ui.x - RANK_ICON_AREA_WIDTH;
            BattleState.playersPanelWidthRight = WIDTH - ui.x;
        }

        private function getFieldByConfigName(fieldName:String):DisplayObject
        {
            switch (fieldName.toLowerCase())
            {
                case "frags":
                    return ui.fragsTF;
                case "badge":
                    return ui.badgeIcon;
                case "nick":
                    return ui.playerNameFullTF;
                case "vehicle":
                    return  ui.vehicleTF;
            }
            return null;
        }

        private function updateFieldWidth(field:DisplayObject):int
        {
            var w:int;
            switch (field)
            {
                case ui.fragsTF:
                    w = Macros.FormatNumber(mcfg.fragsWidth, currentPlayerState, 0);
                    if (int(ui.fragsTF.width) != w)
                    {
                        ui.fragsTF.width = w;
                    }
                    break;
                case ui.badgeIcon:
                    w = Macros.FormatNumber(mcfg.rankBadgeWidth, currentPlayerState, 0);
                    if (int(ui.badgeIcon.width) != w)
                    {
                        ui.badgeIcon.width = w;
                    }
                    break;
                case ui.playerNameFullTF:
                    var maxPlayerNameTextWidth:int;
                    if (isLeftPanel)
                    {
                        if (int(s_maxPlayerNameTextWidthsLeft[ui.xfw_state]) < int(ui.playerNameFullTF.textWidth))
                        {
                            s_maxPlayerNameTextWidthsLeft[ui.xfw_state] = int(ui.playerNameFullTF.textWidth);
                            App.utils.scheduler.scheduleOnNextFrame(function():void
                            {
                                Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, true));
                            });
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthsLeft[ui.xfw_state] + 4;
                    }
                    else
                    {
                        if (int(s_maxPlayerNameTextWidthsRight[ui.xfw_state]) < int(ui.playerNameFullTF.textWidth))
                        {
                            s_maxPlayerNameTextWidthsRight[ui.xfw_state] = int(ui.playerNameFullTF.textWidth);
                            App.utils.scheduler.scheduleOnNextFrame(function():void
                            {
                                Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, false));
                            });
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthsRight[ui.xfw_state] + 4;
                    }
                    var minW:int = Macros.FormatNumber(mcfg.nickMinWidth, currentPlayerState, 0);
                    var maxW:int = Macros.FormatNumber(mcfg.nickMaxWidth, currentPlayerState, 0);
                    w = Math.min(Math.max(maxPlayerNameTextWidth, minW), maxW);
                    if (int(ui.playerNameFullTF.width) != w)
                    {
                        ui.playerNameFullTF.width = w;
                    }
                    break;
                case ui.vehicleTF:
                    w = Macros.FormatNumber(mcfg.vehicleWidth, currentPlayerState, 0);
                    if (int(ui.vehicleTF.width) != w)
                    {
                        ui.vehicleTF.width = w;
                    }
                    break;
            }
            return w;
        }

        private function getFieldOffsetXLeft(field:*):int
        {
            switch (field)
            {
                case ui.vehicleIcon:
                    return Macros.FormatNumber(mcfg.vehicleIconXOffsetLeft, currentPlayerState, 0);
                case ui.vehicleLevel:
                    return Macros.FormatNumber(mcfg.vehicleLevelXOffsetLeft, currentPlayerState, 0);
                case ui.fragsTF:
                    return Macros.FormatNumber(mcfg.fragsXOffsetLeft, currentPlayerState, 0);
                case ui.badgeIcon:
                    return Macros.FormatNumber(mcfg.rankBadgeXOffsetLeft, currentPlayerState, 0);
                case ui.playerNameFullTF:
                    return Macros.FormatNumber(mcfg.nickXOffsetLeft, currentPlayerState, 0);
                case ui.vehicleTF:
                    return Macros.FormatNumber(mcfg.vehicleXOffsetLeft, currentPlayerState, 0);
            }
            return 0;
        }

        private function getFieldOffsetXRight(field:*):int
        {
            switch (field)
            {
                case ui.vehicleIcon:
                    return Macros.FormatNumber(mcfg.vehicleIconXOffsetRight, currentPlayerState, 0);
                case ui.vehicleLevel:
                    return Macros.FormatNumber(mcfg.vehicleLevelXOffsetRight, currentPlayerState, 0);
                case ui.fragsTF:
                    return Macros.FormatNumber(mcfg.fragsXOffsetRight, currentPlayerState, 0);
                case ui.badgeIcon:
                    return Macros.FormatNumber(mcfg.rankBadgeXOffsetRight, currentPlayerState, 0);
                case ui.playerNameFullTF:
                    return Macros.FormatNumber(mcfg.nickXOffsetRight, currentPlayerState, 0);
                case ui.vehicleTF:
                    return Macros.FormatNumber(mcfg.vehicleXOffsetRight, currentPlayerState, 0);
            }
            return 0;
        }

        // extra fields

        private function createExtraFields():void
        {
            var defaultTextFormatConfig:CTextFormat = CTextFormat.GetDefaultConfigForBattle(isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT);
            var cfg:CPlayersPanelNoneModeExtraField = isLeftPanel ? ncfg.extraFields.leftPanel : ncfg.extraFields.rightPanel;
            var bounds:Rectangle = new Rectangle(
                Macros.FormatNumberGlobal(cfg.x, 0),
                Macros.FormatNumberGlobal(cfg.y, 65),
                Macros.FormatNumberGlobal(cfg.width, 380),
                Macros.FormatNumberGlobal(cfg.height, 28));
            var isFixedLayout:Boolean = Macros.FormatBooleanGlobal(ncfg.fixedPosition, false);
            if (cfg.formats && cfg.formats.length)
            {
                extraFieldsHidden = new ExtraFields(
                    cfg.formats,
                    isLeftPanel,
                    getSchemeNameForPlayer,
                    getSchemeNameForVehicle,
                    bounds,
                    Macros.FormatStringGlobal(ncfg.layout, ExtraFields.LAYOUT_VERTICAL).toLowerCase() + (isFixedLayout ? "_fixed" : ""),
                    null,
                    defaultTextFormatConfig);
                extraFieldsHidden.alpha = BattleGlobalData.battleLoadingVisible ? 0 : 1;
                extraFieldsHidden.mouseEnabled = true;
                extraFieldsHidden.mouseChildren = false;
                extraFieldsHidden.addEventListener(MouseEvent.MOUSE_MOVE, (BattleXvmView.battlePage.playersPanel as UI_RankedPlayersPanel).onMouseMoveHandler);
                extraFieldsHidden.addEventListener(MouseEvent.ROLL_OVER, (BattleXvmView.battlePage.playersPanel as UI_RankedPlayersPanel).onMouseRollOverHandler);
                extraFieldsHidden.addEventListener(MouseEvent.ROLL_OUT, (BattleXvmView.battlePage.playersPanel as UI_RankedPlayersPanel).onMouseRollOutHandler);
                BattleXvmView.battlePage.addChildAt(extraFieldsHidden, BattleXvmView.battlePage.getChildIndex(BattleXvmView.battlePage.playersPanel));
                //_internal_createMenuForNoneState(mc);
                //createMouseHandler(_root["extraPanels"]);
            }

            var formats:Array = isLeftPanel ? pcfg.short.extraFieldsLeft : pcfg.short.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFieldsShort = new ExtraFieldsGroup(this, formats);
            }

            formats = isLeftPanel ? pcfg.medium.extraFieldsLeft : pcfg.medium.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFieldsMedium = new ExtraFieldsGroup(this, formats);
            }

            formats = isLeftPanel ? pcfg.medium2.extraFieldsLeft : pcfg.medium2.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFieldsLong = new ExtraFieldsGroup(this, formats);
            }

            formats = isLeftPanel ? pcfg.large.extraFieldsLeft : pcfg.large.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFieldsFull = new ExtraFieldsGroup(this, formats);
            }
        }

        private function disposeExtraFields():void
        {
            if (extraFieldsHidden)
            {
                extraFieldsHidden.dispose();
                extraFieldsHidden = null;
            }
            if (extraFieldsShort)
            {
                extraFieldsShort.dispose();
                extraFieldsShort = null;
            }
            if (extraFieldsMedium)
            {
                extraFieldsMedium.dispose();
                extraFieldsMedium = null;
            }
            if (extraFieldsLong)
            {
                extraFieldsLong.dispose();
                extraFieldsLong = null;
            }
            if (extraFieldsFull)
            {
                extraFieldsFull.dispose();
                extraFieldsFull = null;
            }
        }

        private function updateExtraFields():void
        {
            var bindToIconOffset:int = ui.vehicleIcon.x - x + (isLeftPanel || bcfg.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
            switch (ui.xfw_state)
            {
                case -1:
                case PLAYERS_PANEL_STATE.HIDEN:
                    if (extraFieldsHidden)
                    {
                        extraFieldsHidden.visible = true;
                        extraFieldsHidden.update(currentPlayerState);
                    }
                case PLAYERS_PANEL_STATE.SHORT:
                    if (extraFieldsShort)
                    {
                        extraFieldsShort.visible = true;
                        extraFieldsShort.update(currentPlayerState, bindToIconOffset);
                    }
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    if (extraFieldsMedium)
                    {
                        extraFieldsMedium.visible = true;
                        extraFieldsMedium.update(currentPlayerState, bindToIconOffset);
                    }
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    if (extraFieldsLong)
                    {
                        extraFieldsLong.visible = true;
                        extraFieldsLong.update(currentPlayerState, bindToIconOffset);
                    }
                    break;
                case PLAYERS_PANEL_STATE.FULL:
                    if (extraFieldsFull)
                    {
                        extraFieldsFull.visible = true;
                        extraFieldsFull.update(currentPlayerState, bindToIconOffset);
                    }
                    break;
            }
        }
    }
}
