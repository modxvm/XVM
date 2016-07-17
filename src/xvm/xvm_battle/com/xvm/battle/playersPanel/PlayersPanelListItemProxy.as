/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.extraFields.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.AtlasEvent;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.infrastructure.managers.impl.*;
    import scaleform.clik.core.*;

    public class PlayersPanelListItemProxy extends UIComponent
    {
        // from PlayersPanelListItem.as
        private static const ICONS_AREA_WIDTH:int = 63;
        private static const SQUAD_ITEMS_AREA_WIDTH:int = 25;
        private static const WIDTH:int = 339;
        private static const PLAYER_NAME_MARGIN:int = 8;
        private static const VEHICLE_TF_LEFT_X:int = WIDTH - ICONS_AREA_WIDTH;
        private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + ICONS_AREA_WIDTH;

        private static const STD_VEHICLE_LEVEL_MIRRORING_SHIFT:int = 35;

        public static var INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static var INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static var INVALIDATE_UPDATE_COLORS:String = "UPDATE_COLORS";
        public static var INVALIDATE_UPDATE_POSITIONS:String = "UPDATE_POSITIONS";

        private static var MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED:String = "MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED";

        private static var s_maxPlayerNameTextWidthLeft:Number = 0;
        private static var s_maxPlayerNameTextWidthRight:Number = 0;

        public var xvm_enabled:Boolean;

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLE_ICON_X:Number;
        private var DEFAULT_VEHICLE_LEVEL_X:Number;
        private var DEFAULT_FRAGS_WIDTH:Number;
        private var DEFAULT_VEHICLE_WIDTH:Number;
        private var DEFAULT_PLAYERNAMECUT_WIDTH:Number;

        private var bcfg:CBattle;
        private var pcfg:CPlayersPanel;
        private var mcfg:CPlayersPanelMode;
        private var ncfg:CPlayersPanelNoneMode;
        private var ui:PlayersPanelListItem;
        private var isLeftPanel:Boolean;

        private var _userProps:IUserProps = null;

        private var _standardTextFieldsTexts:Object = {};

        private var opt_mirroredVehicleIcons:Boolean;
        private var opt_removeSelectedBackground:Boolean;
        private var opt_vehicleIconAlpha:Number;
        private var mopt_removeSquadIcon:Boolean;

        private var extraFieldsHidden:ExtraFields = null;
        private var extraFieldsShort:ExtraFields = null;
        private var extraFieldsMedium:ExtraFields = null;
        private var extraFieldsLong:ExtraFields = null;
        private var extraFieldsFull:ExtraFields = null;

        private var currentPlayerState:VOPlayerState;
        private var _vehicleImage:String;

        public function PlayersPanelListItemProxy(ui:PlayersPanelListItem, isLeftPanel:Boolean)
        {
            this.ui = ui;
            mouseEnabled = false;
            mouseChildren = false;
            this.isLeftPanel = isLeftPanel;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.addEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, onMaxPlayerNameTextWidthChanged);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            onConfigLoaded(null);

            DEFAULT_BG_ALPHA = ui.bg.alpha;
            DEFAULT_SELFBG_ALPHA = ui.selfBg.alpha;
            DEFAULT_DEADBG_ALPHA = ui.deadBg.alpha;
            DEFAULT_VEHICLE_ICON_X = ui.vehicleIcon.x;
            DEFAULT_VEHICLE_LEVEL_X = ui.vehicleLevel.x;
            DEFAULT_FRAGS_WIDTH = ui.fragsTF.width;
            DEFAULT_VEHICLE_WIDTH = ui.vehicleTF.width;
            DEFAULT_PLAYERNAMECUT_WIDTH = ui.playerNameCutTF.width;
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.removeEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, onMaxPlayerNameTextWidthChanged);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            disposeExtraFields();
            _userProps = null;
            super.onDispose();
        }

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
            currentPlayerState = BattleState.getByPlayerName(_userProps.userName);
        }

        public function setVehicleIcon(vehicleImage:String):void
        {
            if (_vehicleImage != vehicleImage)
            {
                _vehicleImage = vehicleImage;
            }
            if (mcfg == null)
                return;
            var atlasName:String = isLeftPanel ? UI_PlayersPanel.playersPanelLeftAtlas : UI_PlayersPanel.playersPanelRightAtlas;
            if (!App.atlasMgr.isAtlasInitialized(atlasName))
            {
                var atlas:Atlas = (App.atlasMgr as AtlasManager).xfw_getAtlas(atlasName) as Atlas;
                if (atlas)
                {
                    atlas.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler);
                    atlas.addEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler)
                }
                atlasName = AtlasConstants.BATTLE_ATLAS;
            }
            ui.vehicleIcon.graphics.clear();
            App.atlasMgr.drawGraphics(atlasName, BattleAtlasItem.getVehicleIconName(vehicleImage), ui.vehicleIcon.graphics, BattleAtlasItem.VEHICLE_TYPE_UNKNOWN);
            if (xvm_enabled && _userProps != null)
            {
                invalidate(INVALIDATE_UPDATE_POSITIONS);
            }
        }

        // XVM events handlers

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (xvm_enabled && _userProps != null && e.playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (xvm_enabled && _userProps != null && playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onMaxPlayerNameTextWidthChanged(e:BooleanEvent):void
        {
            if (xvm_enabled && _userProps != null && e.value == isLeftPanel)
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

                if (mcfg == null || _userProps == null)
                    return;

                if (isInvalid(INVALIDATE_PLAYER_STATE))
                {
                    currentPlayerState = BattleState.getByPlayerName(_userProps.userName);
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

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                //Logger.add("PlayersPanelListItemProxy.onConfigLoaded()");
                bcfg = Config.config.battle;
                pcfg = Config.config.playersPanel;
                mcfg = pcfg[UI_PlayersPanel.PLAYERS_PANEL_STATE_NAMES[ui.xfw_state == PLAYERS_PANEL_STATE.HIDEN ? PLAYERS_PANEL_STATE.LONG : ui.xfw_state]];
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
                    opt_mirroredVehicleIcons = Macros.FormatBooleanGlobal(bcfg.mirroredVehicleIcons, false)
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
                    ui.vehicleIcon.width = DEFAULT_VEHICLE_WIDTH;
                    ui.playerNameCutTF.width = DEFAULT_PLAYERNAMECUT_WIDTH;
                }

                ui.invalidateState();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function onAtlasInitializedHandler(e:AtlasEvent):void
        {
            e.currentTarget.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler);
            setVehicleIcon(_vehicleImage);
        }

        public function applyState():void
        {
            //Logger.add("applyState: " + ui.xfw_state);
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    mcfg = pcfg[UI_PlayersPanel.PLAYERS_PANEL_STATE_NAMES[ui.xfw_state]];
                    mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                    ui.fragsTF.visible = false;
                    ui.vehicleTF.visible = false;
                    ui.playerNameCutTF.visible = false;
                    ui.playerNameFullTF.visible = false;
                    if (mcfg.standardFields)
                    {
                        for (var i:int = 0; i < mcfg.standardFields.length; ++i)
                        {
                            switch (mcfg.standardFields[i].toLowerCase())
                            {
                                case "frags":
                                    ui.fragsTF.visible = true;
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
            var schemeName:String = getSchemeNameForVehicle();
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleIcon.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleIcon.alpha *= opt_vehicleIconAlpha;
        }

        private function updateStandardFields():void
        {
            //Logger.add("update: " + ui.xfw_state);
            if (ui.xfw_state != PLAYERS_PANEL_STATE.HIDEN)
            {
                if (ui.fragsTF.visible)
                {
                    updateStandardTextField(ui.fragsTF, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight);
                }
                if (ui.playerNameFullTF.visible)
                {
                    updateStandardTextField(ui.playerNameFullTF, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight);
                }
                if (ui.vehicleTF.visible)
                {
                    updateStandardTextField(ui.vehicleTF, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight);
                }
                updateVehicleLevel();
            }
        }

        private function updateStandardTextField(tf:TextField, format:String):void
        {
            //if (Config.IS_DEVELOPMENT) tf.border = true; tf.borderColor = 0xFF0000;

            var txt:String = Macros.Format(format, currentPlayerState);
            if (_standardTextFieldsTexts[tf.name] == txt)
                return;
            _standardTextFieldsTexts[tf.name] = txt;
            var schemeName:String = getSchemeNameForPlayer();
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            tf.htmlText = "<font color='" + XfwUtils.toHtmlColor(colorScheme.rgb) + "'>" + txt + "</font>";
            invalidate(INVALIDATE_UPDATE_POSITIONS);
        }

        private function updateVehicleLevel():void
        {
            var schemeName:String = PlayerStatusSchemeName.getSchemeForVehicleLevel(currentPlayerState.isDead);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleLevel.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleLevel.alpha *= Macros.FormatNumber(mcfg.vehicleLevelAlpha, currentPlayerState, 100) / 100.0;
        }

        // update positions

        private function updatePositions():void
        {
            if (ui.xfw_state != PLAYERS_PANEL_STATE.HIDEN)
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
            this.x = -ui.x;
        }

        private function updateVehicleIconPositionLeft():void
        {
            var vehicleIconX:Number = DEFAULT_VEHICLE_ICON_X + getFieldOffsetXLeft(ui.vehicleIcon);
            var vehicleLevelX:Number = DEFAULT_VEHICLE_LEVEL_X + getFieldOffsetXLeft(ui.vehicleLevel);
            if (ui.vehicleIcon.x != vehicleIconX)
            {
                ui.vehicleIcon.x = vehicleIconX;
            }
            if (ui.vehicleLevel.x != vehicleLevelX)
            {
                ui.vehicleLevel.x = vehicleLevelX;
            }
        }

        private function updateVehicleIconPositionRight():void
        {
            var vehicleIconX:Number = DEFAULT_VEHICLE_ICON_X - getFieldOffsetXRight(ui.vehicleIcon);
            var vehicleLevelX:Number = DEFAULT_VEHICLE_LEVEL_X - getFieldOffsetXRight(ui.vehicleLevel);
            if (!opt_mirroredVehicleIcons)
            {
                ui.vehicleIcon.scaleX = -1;
                vehicleIconX -= ICONS_AREA_WIDTH;
                vehicleLevelX -= STD_VEHICLE_LEVEL_MIRRORING_SHIFT;
            }
            if (ui.vehicleIcon.x != vehicleIconX)
            {
                ui.vehicleIcon.x = vehicleIconX;
            }
            if (ui.vehicleLevel.x != vehicleLevelX)
            {
                ui.vehicleLevel.x = vehicleLevelX;
            }
        }

        private function updatePositionsLeft():void
        {
            var field:TextField;
            var lastX:Number = VEHICLE_TF_LEFT_X;
            var newX:Number;
            for (var i:int = mcfg.standardFields.length - 1; i >= 0; --i)
            {
                field = getFieldByConfigName(mcfg.standardFields[i]);
                if (field)
                {
                    updateFieldWidth(field);
                    lastX -= field.width;
                    newX = lastX + getFieldOffsetXLeft(field);
                    //Logger.add(field.name + " lastX:" + lastX + " newX:" + newX + " x:" + field.x + " offset:" + getFieldOffsetXLeft(field));
                    if (field.x != newX)
                    {
                        field.x = newX;
                    }
                }
            }
            ui.x = -(lastX - (mopt_removeSquadIcon ? 0 : SQUAD_ITEMS_AREA_WIDTH));
            //Logger.add("ui.x=" + ui.x);
            ui.dynamicSquad.x = -ui.x - (mopt_removeSquadIcon ? SQUAD_ITEMS_AREA_WIDTH : 0);
        }

        private function updatePositionsRight():void
        {
            var field:TextField;
            var lastX:Number = VEHICLE_TF_RIGHT_X;
            var newX:Number;
            for (var i:int = mcfg.standardFields.length - 1; i >= 0; --i)
            {
                field = getFieldByConfigName(mcfg.standardFields[i]);
                newX = lastX - getFieldOffsetXRight(field);
                if (field)
                {
                    updateFieldWidth(field);
                    if (field.x != newX)
                    {
                        field.x = newX;
                    }
                    lastX += field.width;
                }
            }
            ui.x = -(lastX + (mopt_removeSquadIcon ? 0 : SQUAD_ITEMS_AREA_WIDTH));
            ui.dynamicSquad.x = -ui.x + (mopt_removeSquadIcon ? SQUAD_ITEMS_AREA_WIDTH : 0);
        }

        private function getFieldByConfigName(fieldName:String):TextField
        {
            switch (fieldName.toLowerCase())
            {
                case "frags":
                    return ui.fragsTF;
                case "nick":
                    return ui.playerNameFullTF;
                case "vehicle":
                    return  ui.vehicleTF;
            }
            return null;
        }

        private function updateFieldWidth(field:TextField):void
        {
            var w:Number;
            switch (field)
            {
                case ui.fragsTF:
                    w = Macros.FormatNumber(mcfg.fragsWidth, currentPlayerState, 0);
                    if (ui.fragsTF.width != w)
                    {
                        ui.fragsTF.width = w;
                    }
                    break;
                case ui.playerNameFullTF:
                    var maxPlayerNameTextWidth:Number;
                    if (isLeftPanel)
                    {
                        if (s_maxPlayerNameTextWidthLeft < ui.playerNameFullTF.textWidth + 4)
                        {
                            s_maxPlayerNameTextWidthLeft = ui.playerNameFullTF.textWidth + 4;
                            Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, true));
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthLeft;
                    }
                    else
                    {
                        if (s_maxPlayerNameTextWidthRight < ui.playerNameFullTF.textWidth + 4)
                        {
                            s_maxPlayerNameTextWidthRight = ui.playerNameFullTF.textWidth + 4;
                            Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, false));
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthRight;
                    }
                    w = Macros.FormatNumber(mcfg.nickMaxWidth, currentPlayerState, 0);
                    if (ui.playerNameFullTF.width > w)
                    {
                        ui.playerNameFullTF.width = w;
                    }
                    else
                    {
                        w = Math.min(w, Math.max(maxPlayerNameTextWidth, Macros.FormatNumber(mcfg.nickMinWidth, currentPlayerState, 0)));
                        if (ui.playerNameFullTF.width != w)
                        {
                            ui.playerNameFullTF.width = w;
                        }
                    }
                    break;
                case ui.vehicleTF:
                    w = Macros.FormatNumber(mcfg.vehicleWidth, currentPlayerState, 0);
                    if (ui.vehicleTF.width != w)
                    {
                        ui.vehicleTF.width = w;
                    }
                    break;
            }
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
            var cfg:CPlayersPanelNoneModeExtraField = isLeftPanel ? ncfg.extraFields.leftPanel : ncfg.extraFields.rightPanel;
            var bounds:Rectangle = new Rectangle(
                Macros.FormatNumberGlobal(cfg.x, 0),
                Macros.FormatNumberGlobal(cfg.y, 65),
                Macros.FormatNumberGlobal(cfg.width, 380),
                Macros.FormatNumberGlobal(cfg.height, 28));
            extraFieldsHidden = new ExtraFields(
                cfg.formats,
                isLeftPanel,
                getSchemeNameForPlayer,
                getSchemeNameForVehicle,
                bounds,
                Macros.FormatStringGlobal(ncfg.layout, ExtraFields.LAYOUT_VERTICAL).toLowerCase());
            BattleXvmView.battlePage.addChildAt(extraFieldsHidden, BattleXvmView.battlePage.getChildIndex(BattleXvmView.battlePage.playersPanel));
            //_internal_createMenuForNoneState(mc);
            //createMouseHandler(_root["extraPanels"]);

            var formats:Array = isLeftPanel ? pcfg.short.extraFieldsLeft : pcfg.short.extraFieldsRight;
            extraFieldsShort = new ExtraFields(formats, isLeftPanel, getSchemeNameForPlayer, getSchemeNameForVehicle);
            addChild(extraFieldsShort);

            formats = isLeftPanel ? pcfg.medium.extraFieldsLeft : pcfg.medium.extraFieldsRight;
            extraFieldsMedium = new ExtraFields(formats, isLeftPanel, getSchemeNameForPlayer, getSchemeNameForVehicle);
            addChild(extraFieldsMedium);

            formats = isLeftPanel ? pcfg.medium2.extraFieldsLeft : pcfg.medium2.extraFieldsRight;
            extraFieldsLong = new ExtraFields(formats, isLeftPanel, getSchemeNameForPlayer, getSchemeNameForVehicle);
            addChild(extraFieldsLong);

            formats = isLeftPanel ? pcfg.large.extraFieldsLeft : pcfg.large.extraFieldsRight;
            extraFieldsFull = new ExtraFields(formats, isLeftPanel, getSchemeNameForPlayer, getSchemeNameForVehicle);
            addChild(extraFieldsFull);
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

        private function getSchemeNameForVehicle():String
        {
            return PlayerStatusSchemeName.getSchemeNameForVehicle(
                currentPlayerState.isCurrentPlayer && bcfg.highlightVehicleIcon,
                currentPlayerState.isSquadPersonal && bcfg.highlightVehicleIcon,
                currentPlayerState.isTeamKiller && bcfg.highlightVehicleIcon,
                currentPlayerState.isDead,
                currentPlayerState.isOffline);
        }

        private function getSchemeNameForPlayer():String
        {
            return PlayerStatusSchemeName.getSchemeNameForPlayer(
                currentPlayerState.isCurrentPlayer,
                currentPlayerState.isSquadPersonal,
                currentPlayerState.isTeamKiller,
                currentPlayerState.isDead,
                currentPlayerState.isOffline);
        }

        private function updateExtraFields():void
        {
            var bindToIconOffset:Number = ui.vehicleIcon.x - x + (isLeftPanel ? ICONS_AREA_WIDTH : 0);
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.HIDEN:
                    extraFieldsHidden.visible = true;
                    extraFieldsHidden.update(currentPlayerState);
                case PLAYERS_PANEL_STATE.SHORT:
                    extraFieldsShort.visible = true;
                    extraFieldsShort.update(currentPlayerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    extraFieldsMedium.visible = true;
                    extraFieldsMedium.update(currentPlayerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    extraFieldsLong.visible = true;
                    extraFieldsLong.update(currentPlayerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.FULL:
                    extraFieldsFull.visible = true;
                    extraFieldsFull.update(currentPlayerState, bindToIconOffset);
                    break;
            }
        }
    }
}


/* TODO

    private function _internal_createMenuForNoneState(mc:MovieClip)
    {
        var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
        if (cf.formats == null || cf.formats.length <= 0)
            return;
        var menu_mc:UIComponent = UIComponent.createInstance(mc, "HiddenButton", MENU_MC_NAME, mc.getNextHighestDepth(), {
            _x: isLeftPanel ? 0 : -cf.width,
            width: cf.width,
            height: cf.height,
            panel: isLeftPanel ? _root["leftPanel"] : _root["rightPanel"],
            owner: this } );
        menu_mc.addEventListener("rollOver", wrapper, "onItemRollOver");
        menu_mc.addEventListener("rollOut", wrapper, "onItemRollOut");
        menu_mc.addEventListener("releaseOutside", wrapper, "onItemReleaseOutside");
    }

        GlobalEventDispatcher.addEventListener(Events.E_UPDATE_STAGE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_HOLA, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_FIRE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_VEHICLE_TIMER, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_SPOTTED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);

    private static function createMouseHandler(extraPanels:MovieClip):Void
    {
        var mouseHandler:Object = new Object();
        Mouse.addListener(mouseHandler);
        mouseHandler.onMouseDown = function(button, target)
        {
            //Logger.add(target + " " + button);
            if (_root["leftPanel"].state != net.wargaming.ingame.PlayersPanel.STATES.none.name)
                return;

            if (!_root.g_cursorVisible)
                return;

            var t = null;
            for (var n in extraPanels)
            {
                var a:MovieClip = extraPanels[n];
                if (a == null)
                    continue;
                var b:MovieClip = a[PlayerListItemRenderer.MENU_MC_NAME];
                if (b == null)
                    continue;
                if (b.hitTest(_root._xmouse, _root._ymouse, true))
                {
                    t = b;
                    break;
                }
            }
            if (t == null)
                return;

            var data = t.owner.wrapper.data;
            if (data == null)
                return;

            if (button == Mouse.RIGHT)
            {
                var xmlKeyConverter = new net.wargaming.managers.XMLKeyConverter();
                net.wargaming.ingame.MinimapEntry.unhighlightLastEntry();
                var ignored = net.wargaming.messenger.MessengerUtils.isIgnored(data);
                net.wargaming.ingame.BattleContextMenuHandler.showMenu(extraPanels, data, [
                    [ { id: net.wargaming.messenger.MessengerUtils.isFriend(data) ? "removeFromFriends" : "addToFriends", disabled: !data.isEnabledInRoaming } ],
                    [ ignored ? "removeFromIgnored" : "addToIgnored" ],
                    t.panel.getDenunciationsSubmenu(xmlKeyConverter, data.denunciations, data.squad),
                    [ !ignored && _global.wg_isShowVoiceChat ? (net.wargaming.messenger.MessengerUtils.isMuted(data) ? "unsetMuted" : "setMuted") : null ]
                    ]);
            }
            else if (!net.wargaming.ingame.BattleContextMenuHandler.hitTestToCurrentMenu())
            {
                gfx.io.GameDelegate.call("Battle.selectPlayer", [data.vehId]);
            }
        }
    }

*/
