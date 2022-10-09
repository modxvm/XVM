/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.playersPanel
{
    import com.xfw.*;
    import com.xfw.events.BooleanEvent;
    import com.xvm.*;
    import com.xvm.battle.BattleEvents;
    import com.xvm.battle.BattleGlobalData;
    import com.xvm.battle.BattleState;
    import com.xvm.battle.BattleXvmView;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.extraFields.ExtraFields;
    import com.xvm.extraFields.ExtraFieldsGroup;
    import com.xvm.extraFields.IExtraFieldGroupHolder;
    import com.xvm.types.cfg.CBattle;
    import com.xvm.types.cfg.CPlayersPanel;
    import com.xvm.types.cfg.CPlayersPanelMode;
    import com.xvm.types.cfg.CPlayersPanelNoneMode;
    import com.xvm.types.cfg.CPlayersPanelNoneModeExtraField;
    import com.xvm.types.cfg.CShadow;
    import com.xvm.types.cfg.CTextFormat;
    import com.xvm.vo.IVOMacrosOptions;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormatAlign;
    import flash.utils.Dictionary;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
    import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.infrastructure.exceptions.AbstractException;
    import scaleform.clik.core.UIComponent;

    public class PlayersPanelListItemProxyBase extends UIComponent implements IExtraFieldGroupHolder
    {
        // PUBLIC CONSTS

        static public const PLAYERS_PANEL_STATE_NAMES:Vector.<String> = new <String>[ "none", "short", "medium", "medium2", "large" ];

        static public const PLAYERS_PANEL_STATE_MAP:Object = {
            none: PLAYERS_PANEL_STATE.HIDDEN,
            short: PLAYERS_PANEL_STATE.SHORT,
            medium: PLAYERS_PANEL_STATE.MEDIUM,
            medium2: PLAYERS_PANEL_STATE.LONG,
            large: PLAYERS_PANEL_STATE.FULL
        }

        public static const INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static const INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static const INVALIDATE_UPDATE_COLORS:String = "UPDATE_COLORS";
        public static const INVALIDATE_UPDATE_POSITIONS:String = "UPDATE_POSITIONS";

        public static const PLAYERS_PANEL_WIDTH_OFFSET:int = -20;

        // PRIVATE CONSTS

        // from PlayersPanelListItem.as
        private static const WIDTH:int = 339;
        private static const ICONS_AREA_WIDTH:int = 80;

        private static const MIRRORED_VEHICLE_LEVEL_ICON_OFFSET:int = 36;

        private static const VEHICLE_TF_LEFT_X:int = WIDTH - 63 /* default ICONS_AREA_WIDTH */;
        private static const VEHICLE_ICON_LEFT_X:int = VEHICLE_TF_LEFT_X + 15;
        private static const VEHICLE_LEVEL_LEFT_X:int = VEHICLE_TF_LEFT_X + 34;

        private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + 63 /* default ICONS_AREA_WIDTH */;
        private static const VEHICLE_ICON_RIGHT_X:int = VEHICLE_TF_RIGHT_X - 17;
        private static const VEHICLE_LEVEL_RIGHT_X:int = VEHICLE_TF_RIGHT_X - 35;

        private static const MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED:String = "MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED";

        private static const CONTENT_NAME:String = "content";

        // PRIVATE STATIC VARS

        private static var s_maxPlayerNameTextWidthsLeft:Dictionary = new Dictionary();
        private static var s_maxPlayerNameTextWidthsRight:Dictionary = new Dictionary();

        // PUBLIC VARS

        public var _isLeftPanel:Boolean;
        public var isXVMEnabled:Boolean;

        // PROTECTED VARS

        protected var extraFieldsHidden:ExtraFields = null;
        protected var extraFieldsShort:ExtraFieldsGroup = null;
        protected var extraFieldsMedium:ExtraFieldsGroup = null;
        protected var extraFieldsLong:ExtraFieldsGroup = null;
        protected var extraFieldsFull:ExtraFieldsGroup = null;

        protected var currentPlayerState:VOPlayerState;

        // PRIVATE VARS

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLE_ICON_X:int;
        private var DEFAULT_VEHICLE_LEVEL_X:int;
        private var DEFAULT_FRAGS_WIDTH:int;
        private var DEFAULT_VEHICLE_WIDTH:int;
        private var DEFAULT_BADGEICON_WIDTH:int;
        private var DEFAULT_PLAYERNAMECUT_WIDTH:int;
        private var DEFAULT_SPOTTED_INDICATOR_X:int;
        private var DEFAULT_SPOTTED_INDICATOR_Y:int;

        private var bcfg:CBattle;
        private var pcfg:CPlayersPanel;
        protected var mcfg:CPlayersPanelMode;
        private var ncfg:CPlayersPanelNoneMode;

        private var ui:BasePlayersPanelListItem;

        private var _userProps:IUserProps = null;
        private var _vehicleID:Number = NaN;

        private var _standardTextFieldsTexts:Dictionary = new Dictionary();

        private var opt_removeSelectedBackground:Boolean;
        private var opt_vehicleIconAlpha:Number;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private var _vehicleImage:String;

        // STATIC PROPERTIES

        static private var _leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        static public function get leftAtlas():String
        {
            return _leftAtlas;
        }

        static public function set leftAtlas(value:String):void
        {
            _leftAtlas = value;
        }

        static private var _rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        static public function get rightAtlas():String
        {
            return _rightAtlas;
        }

        static public function set rightAtlas(value:String):void
        {
            _rightAtlas = value;
        }

        // CTOR

        public function PlayersPanelListItemProxyBase(ui:BasePlayersPanelListItem, isLeftPanel:Boolean)
        {
            this.ui = ui;
            mouseEnabled = false;
            mouseChildren = false;
            _isLeftPanel = isLeftPanel;

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, _setup);
            Xvm.addEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, _onBattleComponentsVisible);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, _onPlayerStateChanged);
            Xvm.addEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, _onMaxPlayerNameTextWidthChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, _onAtlasLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, _onClanIconLoaded);

            _substrateHolder = ui.addChildAt(new Sprite(), 0) as Sprite;
            _bottomHolder = ui.addChildAt(new Sprite(), ui.getChildIndex(ui.selfBg) + 1) as Sprite;
            _normalHolder = this;
            _topHolder = ui.addChild(new Sprite()) as Sprite;

            DEFAULT_BG_ALPHA = ui.bg.alpha;
            DEFAULT_SELFBG_ALPHA = ui.selfBg.alpha;
            DEFAULT_DEADBG_ALPHA = ui.deadBg.alpha;
            DEFAULT_VEHICLE_ICON_X = ui.vehicleIcon.x;
            DEFAULT_VEHICLE_LEVEL_X = ui.vehicleLevel.x;
            DEFAULT_FRAGS_WIDTH = ui.fragsTF.width;
            DEFAULT_VEHICLE_WIDTH = ui.vehicleTF.width;
            // ui.badge.width equal to zero :(
            DEFAULT_BADGEICON_WIDTH = ui.badge.width;
            DEFAULT_PLAYERNAMECUT_WIDTH = ui.playerNameCutTF.width;
            DEFAULT_SPOTTED_INDICATOR_X = ui.spottedIndicator.x;
            DEFAULT_SPOTTED_INDICATOR_Y = ui.spottedIndicator.y;

            _setup();
        }

        // OVERRIDES

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, _setup);
            Xvm.removeEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, _onBattleComponentsVisible);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, _onPlayerStateChanged);
            Xvm.removeEventListener(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, _onMaxPlayerNameTextWidthChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, _onAtlasLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, _onClanIconLoaded);

            _disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            _userProps = null;

            super.onDispose();
        }

        override protected function draw():void
        {
            try
            {
                super.draw();

                if (!isXVMEnabled || mcfg == null || _userProps == null)
                    return;

                if (isInvalid(INVALIDATE_PLAYER_STATE))
                {
                    currentPlayerState = BattleState.get(_vehicleID);
                }
                if (isInvalid(INVALIDATE_UPDATE_COLORS))
                {
                    _updateVehicleIcon();
                    _standardTextFieldsTexts = new Dictionary();
                }
                if (isInvalid(INVALIDATE_PANEL_STATE))
                {
                    _applyState();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE, INVALIDATE_UPDATE_COLORS))
                {
                    _updateStandardFields();
                }
                if (isInvalid(INVALIDATE_UPDATE_POSITIONS))
                {
                    _updatePositions();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE, INVALIDATE_UPDATE_POSITIONS))
                {
                    _updateExtraFields();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PUBLIC

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
            _vehicleID = BattleState.getVehicleIDByPlayerName(_userProps.fakeName);
            invalidate(INVALIDATE_PLAYER_STATE, INVALIDATE_PANEL_STATE);
        }

        public function setVehicleIcon(vehicleImage:String):void
        {
            if (_vehicleImage != vehicleImage)
            {
                _vehicleImage = vehicleImage;
            }
            if (mcfg == null)
                return;
            var atlasName:String = isLeftPanel ? leftAtlas : rightAtlas;
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

        // PROTECTED

        protected function get state():int
        {
			return fix_state(ui.state);
        }


        // VIRTUAL

        protected function fix_state(state:int):int
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }

        protected function setup():void
        {
            // virtual
        }

        protected function applyState():void
        {
            // virtual
        }

        protected function updateStandardFields():void
        {
            // virtual
        }

        protected function updatePositionsLeft(lastX:int):void
        {
            // virtual
        }

        protected function updatePositionsRight(lastX:int):void
        {
            // virtual
        }

        protected function createExtraFields():void
        {
            // virtual
        }

        // PRIVATE

        private function _onBattleComponentsVisible(e:BooleanEvent):void
        {
            if (extraFieldsHidden)
            {
                extraFieldsHidden.alpha = e.value ? 1 : 0;
            }
        }

        private function _onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (isXVMEnabled)
            {
                if (_userProps)
                {
                    if (e.vehicleID == _vehicleID)
                    {
                        invalidate(INVALIDATE_PLAYER_STATE);
                    }
                }
            }
        }

        private function _onMaxPlayerNameTextWidthChanged(e:BooleanEvent):void
        {
            if (isXVMEnabled)
            {
                if (_userProps)
                {
                    if (e.value == isLeftPanel)
                    {
                        invalidate(INVALIDATE_UPDATE_POSITIONS);
                    }
                }
            }
        }

        private function _onAtlasLoaded(e:Event):void
        {
            if (isXVMEnabled)
            {
                setVehicleIcon(_vehicleImage);
            }
        }

        private function _onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (isXVMEnabled)
            {
                if (_userProps)
                {
                    if (playerName == _userProps.userName)
                    {
                        invalidate(INVALIDATE_PLAYER_STATE);
                    }
                }
            }
        }

        private function _setup():void
        {
            try
            {
                //Logger.add("PlayersPanelListItemProxy.onConfigLoaded()");
                bcfg = Config.config.battle;
                pcfg = Config.config.playersPanel;
                mcfg = pcfg[PLAYERS_PANEL_STATE_NAMES[(state == -1 || state == PLAYERS_PANEL_STATE.HIDDEN) ? PLAYERS_PANEL_STATE.LONG : state]];
                ncfg = pcfg.none;

                // revert mirrored icon and X offset
                ui.vehicleIcon.scaleX = 1;
                ui.vehicleIcon.x = DEFAULT_VEHICLE_ICON_X;
                ui.vehicleLevel.x = DEFAULT_VEHICLE_LEVEL_X;

                _disposeExtraFields();

                isXVMEnabled = Macros.FormatBooleanGlobal(pcfg.enabled, true);
                //Logger.add("xvm_enabled = " + xvm_enabled);
                if (isXVMEnabled)
                {
                    opt_removeSelectedBackground = Macros.FormatBooleanGlobal(pcfg.removeSelectedBackground, false);
                    opt_vehicleIconAlpha = Macros.FormatNumberGlobal(pcfg.iconAlpha, 100) / 100.0;

                    var alpha:Number = Macros.FormatNumberGlobal(pcfg.alpha, 80) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = opt_removeSelectedBackground ? 0 : alpha;
                    ui.deadBg.alpha = alpha;

                    _createExtraFields();
                }
                else
                {
                    ui.bg.alpha = DEFAULT_BG_ALPHA;
                    ui.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    ui.deadBg.alpha = DEFAULT_DEADBG_ALPHA;
                    ui.fragsTF.width = DEFAULT_FRAGS_WIDTH;
                    ui.vehicleTF.width = DEFAULT_VEHICLE_WIDTH;
                    ui.badge.width = DEFAULT_BADGEICON_WIDTH;
                    ui.playerNameCutTF.width = DEFAULT_PLAYERNAMECUT_WIDTH;
                    ui.spottedIndicator.x = DEFAULT_SPOTTED_INDICATOR_X;
                    ui.spottedIndicator.y = DEFAULT_SPOTTED_INDICATOR_Y;
                }

                setup();

                ui.invalidateState();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function _applyState():void
        {
            //Logger.add("_applyState: " + state);
            switch (state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    mcfg = pcfg[PLAYERS_PANEL_STATE_NAMES[state]];
                    ui.fragsTF.visible = false;
                    ui.vehicleTF.visible = false;
                    ui.badge.visible = false;
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
                                    ui.badge.visible = true;
                                    break;
                                case "nick":
                                    ui.playerNameFullTF.visible = true;
                                    break;
                                case "vehicle":
                                    ui.vehicleTF.visible = true;
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                    break;
                case PLAYERS_PANEL_STATE.HIDDEN:
                case -1:
                    BattleState.playersPanelWidthLeft = 0;
                    BattleState.playersPanelWidthRight = 0;
                    ui.visible = false;
                    //ui.x = isLeftPanel ? -WIDTH : WIDTH;
                    break;
                default:
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
            applyState();
            invalidate(INVALIDATE_UPDATE_POSITIONS);
        }

        private function _updateVehicleIcon():void
        {
            var schemeName:String = getSchemeNameForVehicle(currentPlayerState);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleIcon.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleIcon.alpha *= opt_vehicleIconAlpha;
        }

        private function _updateStandardFields():void
        {
            //Logger.add("update: " + state);
            if (state != -1)
            {
                if (state != PLAYERS_PANEL_STATE.HIDDEN)
                {
                    if (ui.fragsTF.visible)
                    {
                        _updateStandardTextField(ui.fragsTF, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight, isLeftPanel ? mcfg.fragsShadowLeft : mcfg.fragsShadowRight);
                    }
                    if (ui.playerNameFullTF.visible)
                    {
                        _updateStandardTextField(ui.playerNameFullTF, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight, isLeftPanel ? mcfg.nickShadowLeft : mcfg.nickShadowRight);
                    }
                    if (ui.vehicleTF.visible)
                    {
                        _updateStandardTextField(ui.vehicleTF, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight, isLeftPanel ? mcfg.vehicleShadowLeft : mcfg.vehicleShadowRight);
                    }
                    _updateVehicleLevel();
                    _updateBadgeIcon();
                    _updateSpottedIndicator();
                    updateStandardFields();
                }
            }
        }

        private function _updateStandardTextField(tf:TextField, format:String, shadowConfig:CShadow):void
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

        private function _updateVehicleLevel():void
        {
            var schemeName:String = PlayerStatusSchemeName.getSchemeForVehicleLevel(currentPlayerState.isDead);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleLevel.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleLevel.alpha *= Macros.FormatNumber(mcfg.vehicleLevelAlpha, currentPlayerState, 100) / 100.0;
        }

        private function _updateBadgeIcon():void
        {
            ui.badge.alpha = Macros.FormatNumber(mcfg.rankBadgeAlpha, currentPlayerState, currentPlayerState.isAlive ? 100 : 70) / 100.0;
        }

        private function _updateSpottedIndicator():void
        {
            if (mcfg.removeSpottedIndicator)
            {
                ui.spottedIndicator.alpha = 0;
            }
            else
            {
                ui.spottedIndicator.alpha = Macros.FormatNumber(mcfg.spottedIndicatorAlpha, currentPlayerState, 100) / 100.0;
                ui.spottedIndicator.x = Macros.FormatNumber(mcfg.spottedIndicatorOffsetX, currentPlayerState, 0) + DEFAULT_SPOTTED_INDICATOR_X;
                ui.spottedIndicator.y = Macros.FormatNumber(mcfg.spottedIndicatorOffsetY, currentPlayerState, 0) + DEFAULT_SPOTTED_INDICATOR_Y;
            }
        }

        // update positions

        private function _updatePositions():void
        {
            if (state != -1)
            {
                if (state != PLAYERS_PANEL_STATE.HIDDEN)
                {
                    if (mcfg.standardFields)
                    {
                        if (isLeftPanel)
                        {
                            _updateVehicleIconPositionLeft();
                            _updatePositionsLeft();
                        }
                        else
                        {
                            _updateVehicleIconPositionRight();
                            _updatePositionsRight();
                        }
                    }
                }
            }
            this.x = bottomHolder.x = topHolder.x = -ui.x;
        }

        private function _updateVehicleIconPositionLeft():void
        {
            var vehicleIconX:int = VEHICLE_ICON_LEFT_X + _getFieldOffsetXLeft(ui.vehicleIcon);
            var vehicleLevelX:int = VEHICLE_LEVEL_LEFT_X + _getFieldOffsetXLeft(ui.vehicleLevel) - ui.vehicleLevel.width / 2;
            ui.hpBarPlayersPanelListItem.setParentX(-this.x);
            ui.hpBarPlayersPanelListItem.setVehicleIconX(vehicleIconX);
            if (int(ui.vehicleIcon.x) != vehicleIconX)
            {
                ui.vehicleIcon.x = vehicleIconX;
            }
            if (int(ui.vehicleLevel.x) != vehicleLevelX)
            {
                ui.vehicleLevel.x = vehicleLevelX;
            }
        }

        private function _updateVehicleIconPositionRight():void
        {
            var vehicleIconScaleX:Number;
            var vehicleIconX:int;
            var vehicleLevelX:int;
            ui.hpBarPlayersPanelListItem.setParentX(-this.x);
            if (bcfg.mirroredVehicleIcons)
            {
                vehicleIconScaleX = 1;
                vehicleIconX = VEHICLE_ICON_RIGHT_X - _getFieldOffsetXRight(ui.vehicleIcon);
                vehicleLevelX = VEHICLE_LEVEL_RIGHT_X - _getFieldOffsetXRight(ui.vehicleLevel) - ui.vehicleLevel.width / 2;
                ui.hpBarPlayersPanelListItem.setVehicleIconX(vehicleIconX);
            }
            else
            {
                vehicleIconScaleX = -1;
                vehicleIconX =  VEHICLE_ICON_RIGHT_X - _getFieldOffsetXRight(ui.vehicleIcon) - ICONS_AREA_WIDTH;
                vehicleLevelX = VEHICLE_LEVEL_RIGHT_X - _getFieldOffsetXRight(ui.vehicleLevel) - ICONS_AREA_WIDTH - ui.vehicleLevel.width / 2 + MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                ui.hpBarPlayersPanelListItem.setVehicleIconX(vehicleIconX + ICONS_AREA_WIDTH);
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

        private function _updatePositionsLeft():void
        {
            var field:DisplayObject;
            var lastX:int = VEHICLE_TF_LEFT_X;
            var newX:int;
            var width:int;
            var len:int = mcfg.standardFields.length;
            for (var i:int = len - 1; i >= 0; --i)
            {
                field = _getFieldByConfigName(mcfg.standardFields[i]);
                if (field)
                {
                    width = _updateFieldWidth(field);
                    lastX -= width - 1;
                    newX = lastX + _getFieldOffsetXLeft(field);
                    //Logger.add(field.name + " lastX:" + lastX + " newX:" + newX + " x:" + field.x + " offset:" + getFieldOffsetXLeft(field));
                    if (int(field.x) != newX)
                    {
                        field.x = newX;
                    }
                }
            }
            updatePositionsLeft(lastX);
            BattleState.playersPanelWidthLeft = WIDTH + ui.x;
        }

        private function _updatePositionsRight():void
        {
            var field:DisplayObject;
            var lastX:int = VEHICLE_TF_RIGHT_X;
            var newX:int;
            var width:int;
            var len:int = mcfg.standardFields.length;
            for (var i:int = len - 1; i >= 0; --i)
            {
                field = _getFieldByConfigName(mcfg.standardFields[i]);
                newX = lastX - _getFieldOffsetXRight(field);
                if (field)
                {
                    width = _updateFieldWidth(field);
                    if (int(field.x) != newX)
                    {
                        field.x = newX;
                    }
                    lastX += width - 1;
                }
            }
            updatePositionsRight(lastX);
            BattleState.playersPanelWidthRight = WIDTH - ui.x;
        }

        private function _getFieldByConfigName(fieldName:String):DisplayObject
        {
            switch (fieldName.toLowerCase())
            {
                case "frags":
                    return ui.fragsTF;
                case "badge":
                    return ui.badge;
                case "nick":
                    return ui.playerNameFullTF;
                case "vehicle":
                    return  ui.vehicleTF;
                default:
                    break;
            }
            return null;
        }

        private function _updateFieldWidth(field:DisplayObject):int
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
                case ui.badge:
                    w = Macros.FormatNumber(mcfg.rankBadgeWidth, currentPlayerState, 0);
                    if (int(ui.badge.width) != w)
                    {
                        ui.badge.width = w;
                        var _content:DisplayObject = ui.badge.getChildByName(CONTENT_NAME);
                        if(_content != null && _content.visible)
                        {
                            _content.x = Math.floor((w / ui.badge.scaleX - _content.width) * 0.5);
                        }
                    }
                    break;
                case ui.playerNameFullTF:
                    var maxPlayerNameTextWidth:int;
                    if (isLeftPanel)
                    {
                        if (int(s_maxPlayerNameTextWidthsLeft[state]) < int(ui.playerNameFullTF.textWidth))
                        {
                            s_maxPlayerNameTextWidthsLeft[state] = int(ui.playerNameFullTF.textWidth);
                            App.utils.scheduler.scheduleOnNextFrame(function():void
                            {
                                Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, true));
                            });
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthsLeft[state] + 4;
                    }
                    else
                    {
                        if (int(s_maxPlayerNameTextWidthsRight[state]) < int(ui.playerNameFullTF.textWidth))
                        {
                            s_maxPlayerNameTextWidthsRight[state] = int(ui.playerNameFullTF.textWidth);
                            App.utils.scheduler.scheduleOnNextFrame(function():void
                            {
                                Xvm.dispatchEvent(new BooleanEvent(MAX_PLAYER_NAME_TEXT_WIDTH_CHANGED, false));
                            });
                        }
                        maxPlayerNameTextWidth = s_maxPlayerNameTextWidthsRight[state] + 4;
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
                default:
                    break;
            }
            return w;
        }

        private function _getFieldOffsetXLeft(field:*):int
        {
            switch (field)
            {
                case ui.vehicleIcon:
                    return Macros.FormatNumber(mcfg.vehicleIconOffsetXLeft, currentPlayerState, 0);
                case ui.vehicleLevel:
                    return Macros.FormatNumber(mcfg.vehicleLevelOffsetXLeft, currentPlayerState, 0);
                case ui.fragsTF:
                    return Macros.FormatNumber(mcfg.fragsOffsetXLeft, currentPlayerState, 0);
                case ui.badge:
                    return Macros.FormatNumber(mcfg.rankBadgeOffsetXLeft, currentPlayerState, 0);
                case ui.playerNameFullTF:
                    return Macros.FormatNumber(mcfg.nickOffsetXLeft, currentPlayerState, 0);
                case ui.vehicleTF:
                    return Macros.FormatNumber(mcfg.vehicleOffsetXLeft, currentPlayerState, 0);
                default:
                    break;
            }
            return 0;
        }

        private function _getFieldOffsetXRight(field:*):int
        {
            switch (field)
            {
                case ui.vehicleIcon:
                    return Macros.FormatNumber(mcfg.vehicleIconOffsetXRight, currentPlayerState, 0);
                case ui.vehicleLevel:
                    return Macros.FormatNumber(mcfg.vehicleLevelOffsetXRight, currentPlayerState, 0);
                case ui.fragsTF:
                    return Macros.FormatNumber(mcfg.fragsOffsetXRight, currentPlayerState, 0);
                case ui.badge:
                    return Macros.FormatNumber(mcfg.rankBadgeOffsetXRight, currentPlayerState, 0);
                case ui.playerNameFullTF:
                    return Macros.FormatNumber(mcfg.nickOffsetXRight, currentPlayerState, 0);
                case ui.vehicleTF:
                    return Macros.FormatNumber(mcfg.vehicleOffsetXRight, currentPlayerState, 0);
                default:
                    break;
            }
            return 0;
        }

        // extra fields

        private function _createExtraFields():void
        {
            var defaultTextFormatConfig:CTextFormat = CTextFormat.GetDefaultConfigForBattle(isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT);
            var cfg:CPlayersPanelNoneModeExtraField = isLeftPanel ? ncfg.extraFields.leftPanel : ncfg.extraFields.rightPanel;
            var bounds:Rectangle = new Rectangle(
                Macros.FormatNumberGlobal(cfg.x, 0),
                Macros.FormatNumberGlobal(cfg.y, 65),
                Macros.FormatNumberGlobal(cfg.width, 380),
                Macros.FormatNumberGlobal(cfg.height, 28));
            var isFixedLayout:Boolean = Macros.FormatBooleanGlobal(ncfg.fixedPosition, false);
            if (cfg.formats)
            {
                if (cfg.formats.length)
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
                    createExtraFields();
                    //_internal_createMenuForNoneState(mc);
                    //createMouseHandler(_root["extraPanels"]);
                }
            }

            var formats:Array = isLeftPanel ? pcfg.short.extraFieldsLeft : pcfg.short.extraFieldsRight;
            if (formats)
            {
                if (formats.length)
                {
                    extraFieldsShort = new ExtraFieldsGroup(this, formats);
                }
            }

            formats = isLeftPanel ? pcfg.medium.extraFieldsLeft : pcfg.medium.extraFieldsRight;
            if (formats)
            {
                if (formats.length)
                {
                    extraFieldsMedium = new ExtraFieldsGroup(this, formats);
                }
            }

            formats = isLeftPanel ? pcfg.medium2.extraFieldsLeft : pcfg.medium2.extraFieldsRight;
            if (formats)
            {
                if (formats.length)
                {
                    extraFieldsLong = new ExtraFieldsGroup(this, formats);
                }
            }

            formats = isLeftPanel ? pcfg.large.extraFieldsLeft : pcfg.large.extraFieldsRight;
            if (formats)
            {
                if (formats.length)
                {
                    extraFieldsFull = new ExtraFieldsGroup(this, formats);
                }
            }
        }

        private function _disposeExtraFields():void
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

        private function _updateExtraFields():void
        {
            var bindToIconOffset:int = ui.vehicleIcon.x - x + (isLeftPanel || bcfg.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
            switch (state)
            {
                case -1:
                case PLAYERS_PANEL_STATE.HIDDEN:
                    if (extraFieldsHidden)
                    {
                        extraFieldsHidden.visible = true;
                        extraFieldsHidden.update(currentPlayerState);
                    }
                    break;
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
                default:
                    break;
            }
        }
    }
}

/* TODO

    private function _internal_createMenuForNoneState(mc:MovieClip)
    {
        var cf:Object = cfg.none.extraFields[isLeftPanel ? "leftPanel" : "rightPanel"];
        if (!cf.formats)
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
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);

    private static function createMouseHandler(extraPanels:MovieClip):Void
    {
        var mouseHandler:Object = {};
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
