/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;

    public class PlayersPanelListItemProxy
    {
        private var DEFAULT_BG_ALPHA:Number;
        private var DEFAULT_SELFBG_ALPHA:Number;
        private var DEFAULT_DEADBG_ALPHA:Number;
        private var DEFAULT_VEHICLEICON_ALPHA:Number;
        private var DEFAULT_VEHICLELEVEL_ALPHA:Number;

        private var pcfg:CPlayersPanel;
        private var xvm_enabled:Boolean;
        private var ui:PlayersPanelListItem;

        public function PlayersPanelListItemProxy(ui:PlayersPanelListItem)
        {
            this.ui = ui;
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

        public function applyState():void
        {
            switch (ui.xfw_state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                    applyStateDefault(pcfg.large);
                    break;
                case PLAYERS_PANEL_STATE.LONG:
                    applyStateDefault(pcfg.medium2);
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM:
                    applyStateDefault(pcfg.medium);
                    break;
                case PLAYERS_PANEL_STATE.SHORT:
                    applyStateDefault(pcfg.short);
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
                xvm_enabled = Macros.GlobalBoolean(pcfg.enabled, true);

                if (xvm_enabled)
                {
                    var alpha:Number = Macros.GlobalNumber(pcfg.alpha, 60) / 100.0;
                    ui.bg.alpha = alpha;
                    ui.selfBg.alpha = alpha;
                    ui.deadBg.alpha = alpha;

                    ui.vehicleIcon.alpha = Macros.GlobalNumber(pcfg.iconAlpha, 100) / 100.0;

                    applyState();
                }
                else
                {
                    ui.bg.alpha = DEFAULT_BG_ALPHA;
                    ui.selfBg.alpha = DEFAULT_SELFBG_ALPHA;
                    ui.deadBg.alpha = DEFAULT_DEADBG_ALPHA;

                    ui.vehicleIcon.alpha = DEFAULT_VEHICLEICON_ALPHA;
                    ui.vehicleLevel.alpha = DEFAULT_VEHICLELEVEL_ALPHA;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        public function applyStateDefault(cfg:CPlayersPanelMode):void
        {
            ui.vehicleLevel.alpha = Macros.GlobalNumber(cfg.vehicleLevelAlpha, 100) / 100.0;
        }

        public function applyStateNone(cfg:CPlayersPanelNoneMode):void
        {

        }
    }
}
