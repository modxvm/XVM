/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.extraFields.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.IVOMacrosOptions;
    import flash.events.*;
    import flash.text.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.core.*;

    public class PlayersPanelListItemProxy extends UIComponent
    {
        // from PlayersPanelListItem.as
        private static const ICONS_AREA_WIDTH:Number = 63;
        private static const SQUAD_ITEMS_AREA_WIDTH:Number = 25;
        private static const WIDTH:Number = 339;
        private static const PLAYER_NAME_MARGIN:Number = 8;
        private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + ICONS_AREA_WIDTH;
        private static const VEHICLE_TF_LEFT_X:int = WIDTH - ICONS_AREA_WIDTH;

        private static const STD_VEHICLE_LEVEL_MIRRORING_SHIFT:Number = 35;

        public static var INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static var INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static var INVALIDATE_UPDATE_POSITIONS:String = "UPDATE_POSITIONS";
        public static var INVALIDATE_UPDATE_COLORS:String = "UPDATE_COLORS";

        public var xvm_enabled:Boolean;

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLE_ICON_X:Number;
        private var DEFAULT_VEHICLE_LEVEL_X:Number;
        private var DEFAULT_FRAGS_WIDTH:Number;
        private var DEFAULT_VEHICLE_WIDTH:Number;
        private var DEFAULT_PLAYERNAMECUT_WIDTH:Number;

        private var pcfg:CPlayersPanel;
        private var mcfg:CPlayersPanelMode;
        private var ncfg:CPlayersPanelNoneMode;
        private var ui:PlayersPanelListItem;
        private var isLeftPanel:Boolean;

        private var _userProps:IUserProps = null;

        private var _standardTextFieldsTexts:Object = {};

        private var opt_removeSelectedBackground:Boolean;
        private var opt_vehicleIconAlpha:Number;

        private var extraFieldsHidden:ExtraFields = null;
        private var extraFieldsShort:ExtraFields = null;
        private var extraFieldsMedium:ExtraFields = null;
        private var extraFieldsLong:ExtraFields = null;
        private var extraFieldsFull:ExtraFields = null;

        public function PlayersPanelListItemProxy(ui:PlayersPanelListItem, isLeftPanel:Boolean)
        {
            this.ui = ui;
            mouseEnabled = false;
            mouseChildren = false;
            this.isLeftPanel = isLeftPanel;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
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
            Xvm.removeEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            disposeExtraFields();
            _userProps = null;
            super.onDispose();
        }

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
        }

        public function setVehicleIcon(vehicleImage:String):void
        {
            if (mcfg == null)
                return;
            var atlas:String = isLeftPanel ? UI_PlayersPanel.playersPanelLeftAtlas : UI_PlayersPanel.playersPanelRightAtlas;
            if (!App.atlasMgr.isAtlasInitialized(atlas))
                atlas = AtlasConstants.BATTLE_ATLAS;
            setupMirroredVehicleIcon();
            App.atlasMgr.drawGraphics(atlas, BattleAtlasItem.getVehicleIconName(vehicleImage), ui.vehicleIcon.graphics, BattleAtlasItem.VEHICLE_TYPE_UNKNOWN);
        }

        // UIComponent

        override protected function draw():void
        {
            try
            {
                super.draw();

                if (mcfg == null || _userProps == null)
                    return;

                if (isInvalid(INVALIDATE_UPDATE_COLORS))
                {
                    updateVehicleIcon();
                    _standardTextFieldsTexts = { };
                }
                if (isInvalid(INVALIDATE_PANEL_STATE))
                {
                    applyState();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_UPDATE_POSITIONS, INVALIDATE_UPDATE_COLORS))
                {
                    updateStandardFields();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_UPDATE_POSITIONS))
                {
                    updatePositions();
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
                pcfg = Config.config.playersPanel;
                mcfg = pcfg[UI_PlayersPanel.PLAYERS_PANEL_STATE_NAMES[ui.xfw_state]];
                ncfg = pcfg.none;

                // revert mirrored icon
                if (!isLeftPanel)
                {
                    ui.vehicleIcon.scaleX = 1;
                    ui.vehicleIcon.x = DEFAULT_VEHICLE_ICON_X;
                    ui.vehicleLevel.x = DEFAULT_VEHICLE_LEVEL_X;
                }

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

                ui.invalidate();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function setupMirroredVehicleIcon():void
        {
            if (!isLeftPanel && !Macros.FormatBooleanGlobal(Config.config.battle.mirroredVehicleIcons, false))
            {
                ui.vehicleIcon.scaleX = -1;
                ui.vehicleIcon.x = DEFAULT_VEHICLE_ICON_X - ICONS_AREA_WIDTH;
                ui.vehicleLevel.x = DEFAULT_VEHICLE_LEVEL_X - STD_VEHICLE_LEVEL_MIRRORING_SHIFT;
            }
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_userProps != null && e.playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (_userProps != null && playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
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
                    break;
                case PLAYERS_PANEL_STATE.HIDEN:
                    ui.visible = true;
                    break;
            }
            if (extraFieldsHidden)
                extraFieldsHidden.visible = false;
            if (extraFieldsHidden)
                extraFieldsShort.visible = false;
            if (extraFieldsHidden)
                extraFieldsMedium.visible = false;
            if (extraFieldsHidden)
                extraFieldsLong.visible = false;
            if (extraFieldsHidden)
                extraFieldsFull.visible = false;
            invalidate(INVALIDATE_UPDATE_POSITIONS, INVALIDATE_PLAYER_STATE);
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

            var playerState:VOPlayerState = BattleState.getByPlayerName(_userProps.userName);

            if (ui.xfw_state == PLAYERS_PANEL_STATE.HIDEN)
            {
                updateNoneMode(playerState);
                return;
            }

            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                    updatePlayerName(playerState);
                    updateVehicleName(playerState);
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    updateVehicleName(playerState);
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    updatePlayerName(playerState);
                    break;
            }
            updateFrags(playerState);
            updateVehicleLevel(playerState);
        }

        private function updateVehicleLevel(playerState:VOPlayerState):void
        {
            var schemeName:String = PlayerStatusSchemeName.getSchemeForVehicleLevel(playerState.isDead);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleLevel.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleLevel.alpha *= Macros.FormatNumber(mcfg.vehicleLevelAlpha, playerState, 100) / 100.0;
        }

        private function updatePlayerName(playerState:VOPlayerState):void
        {
            if (updateStandardTextField(ui.playerNameFullTF, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight, playerState))
            {
                ui.playerNameCutTF.htmlText = ui.playerNameFullTF.htmlText;
            }
        }

        private function updateVehicleName(playerState:VOPlayerState):void
        {
            updateStandardTextField(ui.vehicleTF, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight, playerState);
        }

        private function updateFrags(playerState:VOPlayerState):void
        {
            updateStandardTextField(ui.fragsTF, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight, playerState);
        }

        private function updateStandardTextField(tf:TextField, format:String, playerState:VOPlayerState):Boolean
        {
            //if (Config.IS_DEVELOPMENT) tf.border = true; tf.borderColor = 0xFF0000;

            var txt:String = Macros.Format(format, playerState);
            if (_standardTextFieldsTexts[tf.name] == txt)
                return false;
            _standardTextFieldsTexts[tf.name] = txt;
            var schemeName:String = getSchemeNameForPlayer(playerState);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            tf.htmlText = "<font color='" + XfwUtils.toHtmlColor(colorScheme.rgb) + "'>" + txt + "</font>";
            return true;
        }

        // update positions

        private function updatePositions():void
        {
            if (ui.xfw_state != PLAYERS_PANEL_STATE.HIDEN && mcfg.removeSquadIcon)
            {
                //ui.x = _savedXValue + isLeftPanel ? -SQUAD_ITEMS_AREA_WIDTH : SQUAD_ITEMS_AREA_WIDTH;
            }
            x = -ui.x;
            updateExtraFields();
        }

        // update none mode

        private function updateNoneMode(playerState:VOPlayerState):void
        {

        }

        // extra fields

        private function createExtraFields():void
        {
            var cfg:CPlayersPanelNoneModeExtraField = isLeftPanel ? ncfg.extraFields.leftPanel : ncfg.extraFields.rightPanel;
            var size:Rectangle = new Rectangle(cfg.x, cfg.y, cfg.width, cfg.height);
            extraFieldsHidden = new ExtraFields(cfg.formats, isLeftPanel, getSchemeNameForPlayer, getSchemeNameForVehicle, size, Macros..FormatStringGlobal(ncfg.layout, "vertical"));
            addChild(extraFieldsHidden);
            //_internal_createMenuForNoneState(mc);

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

        private function getSchemeNameForVehicle(playerState:IVOMacrosOptions = null):String
        {
            if (!playerState)
                playerState = BattleState.getByPlayerName(_userProps.userName);
            var isCurrentPlayer:Boolean = playerState.isCurrentPlayer && Config.config.battle.highlightVehicleIcon;
            var isSquadPersonal:Boolean = playerState.isSquadPersonal && Config.config.battle.highlightVehicleIcon;
            var isTeamKiller:Boolean = playerState.isTeamKiller && Config.config.battle.highlightVehicleIcon;
            return PlayerStatusSchemeName.getSchemeNameForVehicle(isCurrentPlayer, isSquadPersonal, isTeamKiller, playerState.isDead, playerState.isOffline);
        }

        private function getSchemeNameForPlayer(playerState:IVOMacrosOptions = null):String
        {
            if (!playerState)
                playerState = BattleState.getByPlayerName(_userProps.userName);
            return PlayerStatusSchemeName.getSchemeNameForPlayer(playerState.isCurrentPlayer, playerState.isSquadPersonal, playerState.isTeamKiller, playerState.isDead, playerState.isOffline);
        }

        private function updateExtraFields():void
        {
            var playerState:VOPlayerState = BattleState.getByPlayerName(_userProps.userName);
            var bindToIconOffset:Number = ui.vehicleIcon.x - x + (isLeftPanel ? ICONS_AREA_WIDTH : 0);
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.HIDEN:
                    extraFieldsHidden.visible = true;
                    extraFieldsHidden.update(playerState);
                case PLAYERS_PANEL_STATE.SHORT:
                    extraFieldsShort.visible = true;
                    extraFieldsShort.update(playerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    extraFieldsMedium.visible = true;
                    extraFieldsMedium.update(playerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    extraFieldsLong.visible = true;
                    extraFieldsLong.update(playerState, bindToIconOffset);
                    break;
                case PLAYERS_PANEL_STATE.FULL:
                    extraFieldsFull.visible = true;
                    extraFieldsFull.update(playerState, bindToIconOffset);
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


    public static var DEFAULT_SQUAD_SIZE:Number;

    private var DEFAULT_WIDTH:Number = 33;
    private var DEFAULT_NAMES_WIDTH_LARGE:Number = 263;
    private var DEFAULT_NAMES_WIDTH_MEDIUM:Number = 79;
    private var DEFAULT_VEHICLES_WIDTH:Number = 98;

    private var m_data_arguments:Array;
    private var m_data:Object;

    private var m_knownPlayersCount:Number = 0; // for Fog of War mode.
    private var m_postmortemIndex:Number = 0;

    private var m_lastPosition:Number = 0;

    ...

        if (!DEFAULT_SQUAD_SIZE)
            DEFAULT_SQUAD_SIZE = net.wargaming.ingame.PlayersPanel.SQUAD_SIZE + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN * 2;

        GlobalEventDispatcher.addEventListener(Events.E_UPDATE_STAGE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_HOLA, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_FIRE, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_VEHICLE_TIMER, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.XMQP_SPOTTED, this, invalidate);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);

    ...

    private function XVMAdjustPanelSize()
    {
        //Logger.add("PlayersPanel.XVMAdjustPanelSize()");

        //wrapper.m_frags.border = true;
        //wrapper.m_frags.borderColor = 0xFF0000;
        //wrapper.m_names.border = true;
        //wrapper.m_names.borderColor = 0x00FF00;
        //wrapper.m_vehicles.border = true;
        //wrapper.m_vehicles.borderColor = 0x0000FF;

        var namesWidth:Number = DEFAULT_NAMES_WIDTH_MEDIUM;
        var vehiclesWidth:Number = DEFAULT_VEHICLES_WIDTH;
        var widthDelta:Number = 0;

        var isLeftPanel:Boolean = wrapper.type == "left";
        var w:Number = Macros.FormatGlobalNumberValue(cfg[wrapper.state].width);
        var x:Number;

        switch (wrapper.state)
        {
            case "short":
                widthDelta = -w;
                break;
            case "medium":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                widthDelta = DEFAULT_NAMES_WIDTH_MEDIUM - namesWidth - DEFAULT_WIDTH;
                break;
            case "medium2":
                vehiclesWidth = w;
                widthDelta = DEFAULT_VEHICLES_WIDTH - vehiclesWidth - DEFAULT_WIDTH;
                break;
            case "large":
                namesWidth = Math.max(XVMGetMaximumFieldWidth(wrapper.m_names), w);
                vehiclesWidth = XVMGetMaximumFieldWidth(wrapper.m_vehicles);
                //Logger.add("w: " + vehiclesWidth + " " + wrapper.m_vehicles.htmlText);
                widthDelta = DEFAULT_NAMES_WIDTH_LARGE - namesWidth + DEFAULT_VEHICLES_WIDTH - vehiclesWidth;
                break;
            default:
                x = isLeftPanel
                    ? net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x
                    : wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x;
                if (wrapper.m_list._x != x || wrapper.players_bg._x != x)
                {
                    wrapper.players_bg._x = x;
                    wrapper.m_list._x = x;
                    var sqx:Number = isLeftPanel
                        ? -x + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN
                        : wrapper.players_bg._width - x - DEFAULT_SQUAD_SIZE + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN;
                    wrapper.m_list.updateSquadIconPosition();
                    GlobalEventDispatcher.dispatchEvent({
                        type: isLeftPanel ? Events.E_LEFT_PANEL_SIZE_ADJUSTED : Events.E_RIGHT_PANEL_SIZE_ADJUSTED,
                        state: wrapper.state
                    });
                }
                return;
        }

        var squadSize:Number = cfg[wrapper.state].removeSquadIcon ? 0 : DEFAULT_SQUAD_SIZE;
        widthDelta += DEFAULT_SQUAD_SIZE - squadSize;

        var changed:Boolean = false;

        if (wrapper.m_names._visible && wrapper.m_names._width != namesWidth)
        {
            changed = true;
            wrapper.m_names._width = namesWidth;
        }

        if (wrapper.m_vehicles._visible && wrapper.m_vehicles._width != vehiclesWidth)
        {
            changed = true;
            wrapper.m_vehicles._width = vehiclesWidth;
        }

        if (isLeftPanel)
        {
            x = net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x - widthDelta;
            if (wrapper.players_bg._x != x)
            {
                changed = true;
                wrapper.players_bg._x = x;
                wrapper.m_list._x = x;
                wrapper.m_list.updateSquadIconPosition(-x + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN);
            }

            x = squadSize;

            if (wrapper.m_names._visible)
            {
                if (wrapper.m_names._x != x)
                {
                    changed = true;
                    wrapper.m_names._x = x;
                }
                x += wrapper.m_names._width;
            }

            if (wrapper.m_frags._visible)
            {
                if (wrapper.m_frags._x != x)
                {
                    changed = true;
                    wrapper.m_frags._x = x;
                }
                x += wrapper.m_frags._width;
            }

            if (wrapper.m_vehicles._visible)
            {
                if (wrapper.m_vehicles._x != x)
                {
                    changed = true;
                    wrapper.m_vehicles._x = x;
                }
            }
        }
        else
        {
            x = wrapper.players_bg._width - net.wargaming.ingame.PlayersPanel.STATES[wrapper.state].bg_x + widthDelta;
            if (wrapper.players_bg._x != x)
            {
                changed = true;
                wrapper.players_bg._x = x;
                wrapper.m_list._x = x;
                wrapper.m_list.updateSquadIconPosition(wrapper.players_bg._width - x - squadSize + net.wargaming.ingame.PlayersPanel.SQUAD_ICO_MARGIN);
            }

            x = wrapper.players_bg._width - squadSize;

            if (wrapper.m_names._visible)
            {
                x -= wrapper.m_names._width;
                if (wrapper.m_names._x != x)
                {
                    changed = true;
                    wrapper.m_names._x = x;
                }
            }

            if (wrapper.m_frags._visible)
            {
                x -= wrapper.m_frags._width;
                if (wrapper.m_frags._x != x)
                {
                    changed = true;
                    wrapper.m_frags._x = x;
                }
            }

            if (wrapper.m_vehicles._visible)
            {
                x -= wrapper.m_vehicles._width;
                if (wrapper.m_vehicles._x != x)
                {
                    changed = true;
                    wrapper.m_vehicles._x = x;
                }
            }
        }

        if (changed)
        {
            GlobalEventDispatcher.dispatchEvent({
                type: isLeftPanel ? Events.E_LEFT_PANEL_SIZE_ADJUSTED : Events.E_RIGHT_PANEL_SIZE_ADJUSTED,
                state: wrapper.state
            });
        }
    }

    private function XVMGetMaximumFieldWidth(field:TextField)
    {
        var max_width = 0;
        var len:Number = field.numLines;
        for (var i = 0; i < len; ++i)
        {
            var w:Number = field.getLineMetrics(i).width;
            if (w > max_width)
                max_width = w;
        }
        return Math.round(max_width) + 4; // 4 is the size of gutters
    }

    // set leading and centering on cell, because of align=top
    private function AdjustLeading(field:TextField)
    {
        if (!field._visible)
            return;

        var leading:Number = Math.round(33.95 - (field.textHeight + 9) / field.numLines);
        if (leading != 9)
            field.htmlText = field.htmlText.split('LEADING="9"').join('LEADING="' + leading + '"');

        field._y = centeredTextY + leading / 2.0;

        //Logger.add(field.htmlText);
    }

    private static function get extraPanelsHolder():MovieClip
    {
        if (_root["extraPanels"] == null)
        {
            var depth:Number = -16377; // the only one free depth for panels
            _root["extraPanels"] = _root.createEmptyMovieClip("extraPanels", depth);
            createMouseHandler(_root["extraPanels"]);
        }
        return _root["extraPanels"];
    }

    var _savedScreenWidth = 0;
    var _savedX = 0;
    private function adjustExtraFieldsLeft(e)
    {
        var state:String = e.state || panel.m_state;
        //Logger.add("adjustExtraFieldsLeft: " + state);
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg:Object = mc.cfg;
        if (cfg != null)
        {
            // none state
            switch (extraFieldsLayout)
            {
                case "horizontal":
                    mc._x = cfg.x + mc.idx * cfg.width;
                    mc._y = cfg.y;
                    break;
                default:
                    mc._x = cfg.x;
                    mc._y = cfg.y + mc.idx * cfg.height;
                    break;
            }
        }
        else
        {
            // other states
            mc._x = -panel.m_list._x;
            mc._y = 0;
        }

        if (_savedX != panel.m_list._x)
        {
            _savedX = panel.m_list._x;
            updateExtraFields();
        }
    }

    private function adjustExtraFieldsRight(e)
    {
        var state:String = e.state || panel.m_state;
        //Logger.add("adjustExtraFieldsRight: " + state);
        var mc:MovieClip = extraFields[state];
        if (mc == null)
            return;

        var cfg:Object = mc.cfg;
        if (cfg != null)
        {
            // none state
            switch (extraFieldsLayout)
            {
                case "horizontal":
                    mc._x = App.appWidth - cfg.x - mc.idx * cfg.width;
                    mc._y = cfg.y;
                    break;
                default:
                    mc._x = App.appWidth - cfg.x;
                    mc._y = cfg.y + mc.idx * cfg.height;
                    break;
            }
        }
        else
        {
            // other states
            mc._x = panel.m_list.width - panel.m_list._x;
            mc._y = 0;
        }
        //Logger.add(App.appWidth + " " + panel.m_list.width + " " + panel.m_list._x);

        if (_savedScreenWidth != App.appWidth || _savedX != panel.m_list._x)
        {
            //Logger.add('updateExtraFields');
            _savedScreenWidth = App.appWidth;
            _savedX = panel.m_list._x;
            updateExtraFields();
        }
    }

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
