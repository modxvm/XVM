/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.battle.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.*;

    public dynamic class UI_PlayersPanel extends PlayersPanelUI
    {
        private static const PLAYERS_PANEL_STATE_MAP:Object = {
            none: PLAYERS_PANEL_STATE.HIDEN,
            short: PLAYERS_PANEL_STATE.SHORT,
            medium: PLAYERS_PANEL_STATE.MEDIUM,
            medium2: PLAYERS_PANEL_STATE.LONG,
            large: PLAYERS_PANEL_STATE.FULL
        }

        private var cfg:Object;

        private var m_altMode:int = PLAYERS_PANEL_STATE.NONE;
        private var m_isAltMode:Boolean = false;
        private var m_savedState:int = PLAYERS_PANEL_STATE.NONE;

        public function UI_PlayersPanel()
        {
            Logger.add("UI_PlayersPanel()");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function configUI():void
        {
            //Logger.add("UI_PlayersPanel.configUI()");
            super.configUI();
            onConfigLoaded(null);
        }

        //override public function as_setIsIntaractive(param1:Boolean):void
        //{
            ////Logger.add("UI_PlayersPanel.as_setIsIntaractive(): " + param1);
            //super.as_setIsIntaractive(param1);
        //}
//
        //override public function as_setPanelMode(param1:int):void
        //{
            ////Logger.add("UI_PlayersPanel.as_setPanelMode(): " + param1);
            //super.as_setPanelMode(param1);
        //}
//
        //override public function setVehiclesData(param1:IDAAPIDataClass):void
        //{
            ////Logger.add("UI_PlayersPanel.setVehiclesData(): " + param1);
            //super.setVehiclesData(param1);
        //}
//
        //override public function setArenaInfo(param1:IDAAPIDataClass):void
        //{
            ////Logger.add("UI_PlayersPanel.setArenaInfo(): " + param1);
            //super.setArenaInfo(param1);
        //}
//
        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                cfg = Config.config.playersPanel;
                initPanelModes();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function initPanelModes():void
        {
            var startMode:String = Macros.FormatGlobalStringValue(cfg.startMode).toLowerCase();
            Logger.add(cfg.startMode + " => " + startMode);
            if (PLAYERS_PANEL_STATE_MAP[startMode] == null)
                startMode = "large";
            cfg[startMode].enabled = true;
            xfw_requestState(PLAYERS_PANEL_STATE_MAP[startMode]);

            m_savedState = PLAYERS_PANEL_STATE.NONE;

            var altMode:String = Macros.FormatGlobalStringValue(cfg.altMode).toLowerCase();
            Logger.add("altMode=" + altMode + " < " + cfg.altMode);
            m_altMode = (PLAYERS_PANEL_STATE_MAP[altMode] == null) ? PLAYERS_PANEL_STATE.NONE : PLAYERS_PANEL_STATE_MAP[altMode];
            Logger.add("m_altMode=" + m_altMode);
            if (m_altMode != PLAYERS_PANEL_STATE.NONE)
                Xvm.addEventListener(BattleEvents.PLAYERS_PANEL_ALT_MODE, setAltMode);

            panelSwitch.hidenBt.enabled = Macros.FormatGlobalBooleanValue(cfg["none"].enabled, true);
            panelSwitch.shortBt.enabled = Macros.FormatGlobalBooleanValue(cfg["short"].enabled, true);
            panelSwitch.mediumBt.enabled = Macros.FormatGlobalBooleanValue(cfg["medium"].enabled, true);
            panelSwitch.longBt.enabled = Macros.FormatGlobalBooleanValue(cfg["medium2"].enabled, true);
            panelSwitch.fullBt.enabled = Macros.FormatGlobalBooleanValue(cfg["large"].enabled, true);

            panelSwitch.hidenBt.alpha = panelSwitch.hidenBt.enabled ? 1 : .5;
            panelSwitch.shortBt.alpha = panelSwitch.shortBt.enabled ? 1 : .5;
            panelSwitch.mediumBt.alpha = panelSwitch.mediumBt.enabled ? 1 : .5;
            panelSwitch.longBt.alpha = panelSwitch.longBt.enabled ? 1 : .5;
            panelSwitch.fullBt.alpha = panelSwitch.fullBt.enabled ? 1 : .5;
        }

        private function setAltMode(e:ObjectEvent):void
        {
            //Logger.add("setAltMode: isDown:" + e.result.isDown + " m_altMode:" + m_altMode + " currentMode:" + listLeft.state + " m_isAltMode:" + m_isAltMode + " m_savedState:" + m_savedState);

            if (m_altMode == PLAYERS_PANEL_STATE.NONE)
                return;

            if (Config.config.hotkeys.playersPanelAltMode.onHold)
                m_isAltMode = e.result.isDown;
            else if (e.result.isDown)
                m_isAltMode = !m_isAltMode;
            else
                return;

            if (m_isAltMode)
            {
                if (m_savedState == PLAYERS_PANEL_STATE.NONE)
                    m_savedState = listLeft.state;
                //Logger.add(String(m_altMode));
                xfw_requestState(m_altMode);
            }
            else
            {
                if (m_savedState != PLAYERS_PANEL_STATE.NONE)
                {
                    //Logger.add(String(m_savedState));
                    xfw_requestState(m_savedState);
                }
                m_savedState = PLAYERS_PANEL_STATE.NONE;
            }
        }
    }
}
