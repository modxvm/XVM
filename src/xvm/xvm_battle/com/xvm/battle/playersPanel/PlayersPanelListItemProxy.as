/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.MacrosFormatOptions;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;
    import net.wg.infrastructure.interfaces.*;

    public class PlayersPanelListItemProxy
    {
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
            this.ui = ui;
            this.isLeftPanel = isLeftPanel;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);

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

        public function configUI():void
        {
            onConfigLoaded(null);
        }

        public function dispose():void
        {
            // empty
        }

        public function setIsSelected(isSelected:Boolean):void
        {
            _isSelected = isSelected;
        }

        public function onDrawSelected():void
        {
            ui.selfBg.visible = _isSelected && !opt_removeSelectedBackground;
        }

        public function setPlayerNameProps(userProps:IUserProps):void
        {
            _userProps = userProps;
            updatePlayerName();
        }

        public function updatePlayerName():void
        {
            if (mcfg != null && _userProps != null)
            {
                var opt:MacrosFormatOptions = new MacrosFormatOptions(); // TODO: BattleState.get(data.uid);
                var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.nickFormatLeft : mcfg.nickFormatRight, opt);
                Logger.add(txt);
                ui.playerNameCutTF.htmlText = txt;
                ui.playerNameFullTF.htmlText = txt;
            }
        }

        public function updateVehicleName():void
        {
            if (mcfg != null && _userProps != null)
            {
                var opt:MacrosFormatOptions = new MacrosFormatOptions(); // TODO: BattleState.get(data.uid);
                var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.vehicleFormatLeft : mcfg.vehicleFormatRight, opt);
                ui.vehicleTF.htmlText = txt;
            }
        }

        public function updateFrags():void
        {
            if (mcfg != null && _userProps != null)
            {
                var opt:MacrosFormatOptions = new MacrosFormatOptions(); // TODO: BattleState.get(data.uid);
                var txt:String = Macros.Format(_userProps.userName, isLeftPanel ? mcfg.fragsFormatLeft : mcfg.fragsFormatRight, opt);
                ui.fragsTF.htmlText = txt;
            }
        }

        public function applyState():void
        {
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    mcfg = pcfg[UI_PlayersPanel.PLAYERS_PANEL_STATE_NAMES[ui.xfw_state]];
                    applyStateDefault();
                    break;
                case PLAYERS_PANEL_STATE.HIDEN:
                    applyStateNone(pcfg.none);
                    break;
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

                if (xvm_enabled)
                {
                    var alpha:Number = Macros.GlobalNumber(pcfg.alpha, 80) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = alpha;
                    ui.deadBg.alpha = alpha;

                    ui.vehicleIcon.alpha = Macros.GlobalNumber(pcfg.iconAlpha, 100) / 100.0;

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

        private function applyStateDefault():void
        {
            ui.vehicleLevel.alpha = Macros.GlobalNumber(mcfg.vehicleLevelAlpha, 100) / 100.0;
            updatePlayerName();
            updateVehicleName();
            updateFrags();
        }

        private function applyStateNone(cfg:CPlayersPanelNoneMode):void
        {

        }
    }
}
