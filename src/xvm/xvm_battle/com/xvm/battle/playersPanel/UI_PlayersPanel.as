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
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;

    public dynamic class UI_PlayersPanel extends PlayersPanelUI
    {
        // from PlayersPanel.as
        private static const EXPAND_AREA_WIDTH:Number = 230;

        public static const PLAYERS_PANEL_STATE_NAMES:Array = [ "none", "short", "medium", "medium2", "large" ];
        public static const PLAYERS_PANEL_STATE_MAP:Object = {
            none: PLAYERS_PANEL_STATE.HIDEN,
            short: PLAYERS_PANEL_STATE.SHORT,
            medium: PLAYERS_PANEL_STATE.MEDIUM,
            medium2: PLAYERS_PANEL_STATE.LONG,
            large: PLAYERS_PANEL_STATE.FULL
        }

        public static var playersPanelLeftAtlas:String = AtlasConstants.BATTLE_ATLAS;
        public static var playersPanelRightAtlas:String = AtlasConstants.BATTLE_ATLAS;

        private var DEFAULT_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE:String = PlayersPanelListLeft.LINKAGE;
        private var XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE:String = getQualifiedClassName(UI_PlayersPanelListItemLeft);
        private var DEFAULT_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE:String = PlayersPanelListRight.LINKAGE;
        private var XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE:String = getQualifiedClassName(UI_PlayersPanelListItemRight);

        private var cfg:CPlayersPanel;
        private var xvm_enabled:Boolean;

        private var m_altMode:int = PLAYERS_PANEL_STATE.NONE;
        private var m_isAltMode:Boolean = false;
        private var m_savedState:int = PLAYERS_PANEL_STATE.NONE;

        public function UI_PlayersPanel()
        {
            //Logger.add("UI_PlayersPanel()");
            super();
            PlayersPanelListLeft.LINKAGE = XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE;
            PlayersPanelListRight.LINKAGE = XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function configUI():void
        {
            //Logger.add("UI_PlayersPanel.configUI()");
            super.configUI();
            onConfigLoaded(null);
        }

        override public function as_setPanelMode(state:int):void
        {
            //Logger.add("UI_PlayersPanel.as_setPanelMode(): " + param1);

            if (xvm_enabled)
            {
                // skip disabled modes
                if (state != PLAYERS_PANEL_STATE.NONE && m_savedState == PLAYERS_PANEL_STATE.NONE)
                {
                    if (!Macros.FormatBooleanGlobal(cfg[PLAYERS_PANEL_STATE_NAMES[state]].enabled, true))
                    {
                        xfw_requestState((state + 1) % PLAYERS_PANEL_STATE_NAMES.length);
                        return;
                    }
                }
            }

            super.as_setPanelMode(state);

            var expandAreaWidth:Number = Macros.FormatNumberGlobal(cfg[PLAYERS_PANEL_STATE_NAMES[state]].expandAreaWidth, EXPAND_AREA_WIDTH);
            xfw_expandRectLeft.width = expandAreaWidth;
            xfw_expandRectRight.width = expandAreaWidth;
            xfw_expandRectRight.x = App.appWidth - xfw_expandRectRight.width;
        }

        override public function updateStageSize(param1:Number, param2:Number):void
        {
            super.updateStageSize(param1, param2);
            xfw_expandRectRight.x = App.appWidth - xfw_expandRectRight.width;
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                Xvm.removeEventListener(BattleEvents.PLAYERS_PANEL_ALT_MODE, setAltMode);

                cfg = Config.config.playersPanel;
                xvm_enabled = Macros.FormatBooleanGlobal(cfg.enabled, true);

                if (xvm_enabled)
                {
                    initPanelModes();
                    registerVehicleIconAtlases();
                    panelSwitch.visible = !Macros.FormatBooleanGlobal(cfg.removePanelsModeSwitcher, false);
                }
                else
                {
                    panelSwitch.visible = true;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function initPanelModes():void
        {
            var startMode:String = Macros.FormatStringGlobal(cfg.startMode, "").toLowerCase();
            if (PLAYERS_PANEL_STATE_MAP[startMode] == null)
                startMode = "large";
            cfg[startMode].enabled = true;
            xfw_requestState(PLAYERS_PANEL_STATE_MAP[startMode]);

            m_savedState = PLAYERS_PANEL_STATE.NONE;

            var altMode:String = Macros.FormatStringGlobal(cfg.altMode, "").toLowerCase();
            m_altMode = (PLAYERS_PANEL_STATE_MAP[altMode] == null) ? PLAYERS_PANEL_STATE.NONE : PLAYERS_PANEL_STATE_MAP[altMode];
            if (m_altMode != PLAYERS_PANEL_STATE.NONE)
                Xvm.addEventListener(BattleEvents.PLAYERS_PANEL_ALT_MODE, setAltMode);

            panelSwitch.hidenBt.enabled = Macros.FormatBooleanGlobal(cfg.none.enabled, true);
            panelSwitch.shortBt.enabled = Macros.FormatBooleanGlobal(cfg.short.enabled, true);
            panelSwitch.mediumBt.enabled = Macros.FormatBooleanGlobal(cfg.medium.enabled, true);
            panelSwitch.longBt.enabled = Macros.FormatBooleanGlobal(cfg.medium2.enabled, true);
            panelSwitch.fullBt.enabled = Macros.FormatBooleanGlobal(cfg.large.enabled, true);

            panelSwitch.hidenBt.alpha = panelSwitch.hidenBt.enabled ? 1 : .5;
            panelSwitch.shortBt.alpha = panelSwitch.shortBt.enabled ? 1 : .5;
            panelSwitch.mediumBt.alpha = panelSwitch.mediumBt.enabled ? 1 : .5;
            panelSwitch.longBt.alpha = panelSwitch.longBt.enabled ? 1 : .5;
            panelSwitch.fullBt.alpha = panelSwitch.fullBt.enabled ? 1 : .5;
        }

        private function registerVehicleIconAtlases():void
        {
            var newAtlas:String;
            try
            {
                newAtlas = Macros.FormatStringGlobal(Config.config.iconset.playersPanelLeftAtlas);
                if (playersPanelLeftAtlas != newAtlas)
                {
                    App.atlasMgr.registerAtlas(newAtlas);
                    playersPanelLeftAtlas = newAtlas;
                }
            }
            catch (ex:Error)
            {
                playersPanelLeftAtlas = AtlasConstants.BATTLE_ATLAS;
                Logger.err(ex);
            }
            try
            {
                newAtlas = Macros.FormatStringGlobal(Config.config.iconset.playersPanelRightAtlas);
                if (playersPanelRightAtlas != newAtlas)
                {
                    App.atlasMgr.registerAtlas(newAtlas);
                    playersPanelRightAtlas = newAtlas;
                }
            }
            catch (ex:Error)
            {
                playersPanelRightAtlas = AtlasConstants.BATTLE_ATLAS;
                Logger.err(ex);
            }
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
