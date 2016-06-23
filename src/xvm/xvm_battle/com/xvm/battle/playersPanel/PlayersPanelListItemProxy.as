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
        public static var INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static var INVALIDATE_USER_PROPS:String = "USER_PROPS";
        public static var INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static var INVALIDATE_UPDATE_COLORS:String = "UPDATE_COLORS";
        public static var INVALIDATE_UPDATE_PANEL_SIZE:String = "UPDATE_PANEL_SIZE";

        public var xvm_enabled:Boolean;

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLE_ICON_X:Number;
        private var DEFAULT_VEHICLE_LEVEL_X:Number;

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
            visible = false;

            this.ui = ui;
            this.isLeftPanel = isLeftPanel;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
            onConfigLoaded(null);

            DEFAULT_BG_ALPHA = ui.bg.alpha;
            DEFAULT_SELFBG_ALPHA = ui.selfBg.alpha;
            DEFAULT_DEADBG_ALPHA = ui.deadBg.alpha;
            DEFAULT_VEHICLE_ICON_X = ui.vehicleIcon.x;
            DEFAULT_VEHICLE_LEVEL_X = ui.vehicleLevel.x;
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
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
            invalidate(INVALIDATE_PANEL_STATE);
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
                    updateStandardFields();
                }
                if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_USER_PROPS, INVALIDATE_PANEL_STATE))
                {
                    if (!isInvalid(INVALIDATE_UPDATE_COLORS))
                        updateStandardFields();
                    updateExtraFields();
                }
                if (isInvalid(INVALIDATE_UPDATE_PANEL_SIZE))
                {
                    updatePanelSize();
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

                xvm_enabled = Macros.GlobalBoolean(pcfg.enabled, true);
                //Logger.add("xvm_enabled = " + xvm_enabled);
                if (xvm_enabled)
                {
                    var alpha:Number = Macros.GlobalNumber(pcfg.alpha, 80) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = alpha;
                    ui.deadBg.alpha = alpha;

                    opt_removeSelectedBackground = Macros.GlobalBoolean(pcfg.removeSelectedBackground, false);
                    opt_vehicleIconAlpha = Macros.GlobalNumber(pcfg.iconAlpha, 100) / 100.0;

                    createExtraFields();
                }
                else
                {
                    ui.bg.alpha = DEFAULT_BG_ALPHA;
                    ui.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    ui.deadBg.alpha = DEFAULT_DEADBG_ALPHA;
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
            if (!isLeftPanel && !Macros.GlobalBoolean(Config.config.battle.mirroredVehicleIcons))
            {
                ui.vehicleIcon.scaleX = -1;
                ui.vehicleIcon.x = DEFAULT_VEHICLE_ICON_X - 80;
                ui.vehicleLevel.x = DEFAULT_VEHICLE_LEVEL_X - 35;
            }
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_userProps != null && e.playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        // update

        private function updateVehicleIcon():void
        {
            var playerState:VOPlayerState = BattleState.getByPlayerName(_userProps.userName);
            var isCurrentPlayer:Boolean = playerState.isCurrentPlayer && Config.config.battle.highlightVehicleIcon;
            var isSquadPersonal:Boolean = playerState.isSquadPersonal && Config.config.battle.highlightVehicleIcon;
            var isTeamKiller:Boolean = playerState.isTeamKiller && Config.config.battle.highlightVehicleIcon;
            var schemeName:String = PlayerStatusSchemeName.getSchemeNameForVehicle(isCurrentPlayer, isSquadPersonal, isTeamKiller, playerState.isDead, playerState.isOffline);
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
            updateSelfBg(playerState);
        }

        private function updateVehicleLevel(playerState:VOPlayerState):void
        {
            var schemeName:String = PlayerStatusSchemeName.getSchemeForVehicleLevel(playerState.isDead);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            ui.vehicleLevel.transform.colorTransform = colorScheme.colorTransform;
            ui.vehicleLevel.alpha *= Macros.GlobalNumber(mcfg.vehicleLevelAlpha, 100) / 100.0;
        }

        private function updateSelfBg(playerState:VOPlayerState):void
        {
            ui.selfBg.visible = playerState.isSelected && !opt_removeSelectedBackground;
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
            var txt:String = Macros.Format(_userProps.userName, format, playerState);
            if (_standardTextFieldsTexts[tf.name] == txt)
                return false;
            _standardTextFieldsTexts[tf.name] = txt;
            var schemeName:String = PlayerStatusSchemeName.getSchemeNameForPlayer(
                playerState.isCurrentPlayer, playerState.isSquadPersonal, playerState.isTeamKiller, playerState.isDead, playerState.isOffline);
            var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
            tf.htmlText = "<font color='" + XfwUtils.toHtmlColor(colorScheme.rgb) + "'>" + txt + "</font>";
            invalidate(INVALIDATE_UPDATE_PANEL_SIZE);
            return true;
        }

        // update panel size

        private function updatePanelSize():void
        {

        }

        // update none mode

        private function updateNoneMode(playerState:VOPlayerState):void
        {

        }

        // extra fields

        private function createExtraFields():void
        {
            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;

            var cfg:CPlayersPanelNoneModeExtraField = isLeftPanel ? ncfg.extraFields.leftPanel : ncfg.extraFields.rightPanel;
            var size:Rectangle = new Rectangle(cfg.x, cfg.y, cfg.width, cfg.height);
            extraFieldsHidden = new ExtraFields(cfg.formats, defaultAlign, size, Macros.GlobalString(ncfg.layout, "vertical"));
            addChild(extraFieldsHidden);
            //_internal_createMenuForNoneState(mc);

            var formats:Array = isLeftPanel ? pcfg.short.extraFieldsLeft : pcfg.short.extraFieldsRight;
            extraFieldsShort = new ExtraFields(formats, defaultAlign);
            addChild(extraFieldsShort);

            formats = isLeftPanel ? pcfg.medium.extraFieldsLeft : pcfg.medium.extraFieldsRight;
            extraFieldsMedium = new ExtraFields(formats, defaultAlign);
            addChild(extraFieldsMedium);

            formats = isLeftPanel ? pcfg.medium2.extraFieldsLeft : pcfg.medium2.extraFieldsRight;
            extraFieldsLong = new ExtraFields(formats, defaultAlign);
            addChild(extraFieldsLong);

            formats = isLeftPanel ? pcfg.large.extraFieldsLeft : pcfg.large.extraFieldsRight;
            extraFieldsFull = new ExtraFields(formats, defaultAlign);
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

        private function updateExtraFields():void
        {
            var playerState:VOPlayerState = BattleState.getByPlayerName(_userProps.userName);

            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.HIDEN:
                    extraFieldsHidden.visible = true;
                    extraFieldsHidden.update(playerState);
                case PLAYERS_PANEL_STATE.SHORT:
                    extraFieldsShort.visible = true;
                    extraFieldsShort.update(playerState);
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    extraFieldsMedium.visible = true;
                    extraFieldsMedium.update(playerState);
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    extraFieldsLong.visible = true;
                    extraFieldsLong.update(playerState);
                    break;
                case PLAYERS_PANEL_STATE.FULL:
                    extraFieldsFull.visible = true;
                    extraFieldsFull.update(playerState);
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
*/
