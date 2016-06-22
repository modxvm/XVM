/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;

    public class PlayersPanelListItemProxy extends UIComponent
    {
        public static var INVALIDATE_PLAYER_STATE:String = "PLAYER_STATE";
        public static var INVALIDATE_USER_PROPS:String = "USER_PROPS";
        public static var INVALIDATE_VEHICLE_NAME:String = "VEHICLE_NAME";
        public static var INVALIDATE_FRAGS:String = "FRAGS";
        public static var INVALIDATE_SELECTED:String = "SELECTED";
        public static var INVALIDATE_PANEL_STATE:String = "PANEL_STATE";
        public static var INVALIDATE_UPDATE_COLORS:String = "INVALIDATE_UPDATE_COLORS";

        public var xvm_enabled:Boolean;

        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLEICON_ALPHA:Number;
        private var DEFAULT_VEHICLELEVEL_ALPHA:Number;

        private var pcfg:CPlayersPanel;
        private var mcfg:CPlayersPanelMode;
        private var ncfg:CPlayersPanelNoneMode;
        private var ui:PlayersPanelListItem;
        private var isLeftPanel:Boolean;

        private var _isSelected:Boolean = false;
        private var _userProps:IUserProps = null;

        private var opt_removeSelectedBackground:Boolean;

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
            DEFAULT_VEHICLEICON_ALPHA = ui.vehicleIcon.alpha;
            DEFAULT_VEHICLELEVEL_ALPHA = ui.vehicleLevel.alpha;

            // TODO: is required?
            //if (wrapper.m_names.condenseWhite)
            //    wrapper.m_names.condenseWhite = false;
            //if (wrapper.m_vehicles.condenseWhite)
            //    wrapper.m_vehicles.condenseWhite = false;
            //if (wrapper.m_frags.wordWrap)
            //    wrapper.m_frags.wordWrap = false;

        }

        public function onProxyConfigUI():void
        {
            // empty
        }

        public function onProxyDispose():void
        {
            // empty
        }

        public function setIsSelected(isSelected:Boolean):void
        {
            _isSelected = isSelected;
        }

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
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
            invalidate(INVALIDATE_PANEL_STATE);
        }

        // UIComponent

        override protected function draw():void
        {
            super.draw();

            if (mcfg == null || _userProps == null)
                return;

            if (isInvalid(INVALIDATE_UPDATE_COLORS))
            {
                updateVehicleIcon();
                updateVehicleLevel();
            }
            if (isInvalid(INVALIDATE_PLAYER_STATE, INVALIDATE_USER_PROPS, INVALIDATE_VEHICLE_NAME, INVALIDATE_FRAGS, INVALIDATE_SELECTED, INVALIDATE_PANEL_STATE))
            {
                update();
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
                xvm_enabled = Macros.GlobalBoolean(pcfg.enabled, true);
                //Logger.add("xvm_enabled = " + xvm_enabled);

                if (xvm_enabled)
                {
                    var alpha:Number = Macros.GlobalNumber(pcfg.alpha, 80) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = alpha;
                    ui.deadBg.alpha = alpha;

                    updateVehicleIcon();

                    opt_removeSelectedBackground = Macros.GlobalBoolean(pcfg.removeSelectedBackground, false);
                }
                else
                {
                    ui.bg.alpha = DEFAULT_BG_ALPHA;
                    ui.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    ui.deadBg.alpha = DEFAULT_DEADBG_ALPHA;

                    ui.vehicleIcon.alpha = DEFAULT_VEHICLEICON_ALPHA;
                    ui.vehicleLevel.alpha = DEFAULT_VEHICLELEVEL_ALPHA;
                }

                ui.invalidate();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_userProps != null && e.playerName == _userProps.userName)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        // update

        private function update():void
        {
            //Logger.add("update: " + ui.xfw_state);

            if (ui.xfw_state == PLAYERS_PANEL_STATE.HIDEN)
            {
                updateNoneMode();
                return;
            }

            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                    updatePlayerName();
                    updateVehicleName();
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    updateVehicleName();
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    updatePlayerName();
                    break;
            }
            updateFrags();
            updateExtraFields();
            ui.selfBg.visible = _isSelected && !opt_removeSelectedBackground;
            updateVehicleLevel();
        }

        private function updateVehicleIcon():void
        {
            ui.vehicleIcon.alpha = Macros.GlobalNumber(pcfg.iconAlpha, 100) / 100.0;
        }

        private function updateVehicleLevel():void
        {
            ui.vehicleLevel.alpha = Macros.GlobalNumber(mcfg.vehicleLevelAlpha, 100) / 100.0;
        }

        private function updatePlayerName():void
        {
            var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight, BattleState.getByPlayerName(_userProps.userName));
            //Logger.add("updatePlayerName: " + txt);
            ui.playerNameCutTF.htmlText = txt;
            ui.playerNameFullTF.htmlText = txt;
        }

        private function updateVehicleName():void
        {
            var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight, BattleState.getByPlayerName(_userProps.userName));
            //Logger.add("updateVehicleName: " + txt);
            ui.vehicleTF.htmlText = txt;
        }

        private function updateFrags():void
        {
            var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight, BattleState.getByPlayerName(_userProps.userName));
            //Logger.add("updateFrags: " + (isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight) + " => " + txt);
            ui.fragsTF.htmlText = txt;
        }

        private function updateExtraFields():void
        {

        }

        // update none mode

        private function updateNoneMode():void
        {

        }
    }
}
