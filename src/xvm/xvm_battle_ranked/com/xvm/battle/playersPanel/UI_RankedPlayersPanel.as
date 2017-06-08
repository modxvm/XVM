/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.vo.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.ranked.stats.components.playersPanel.list.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.impl.*;

    public /*dynamic*/ class UI_RankedPlayersPanel extends RankedPlayersPanelUI
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

        public static var playersPanelLeftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;
        public static var playersPanelRightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        private var DEFAULT_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE:String = PlayersPanelListLeft.LINKAGE;
        private var XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE:String = getQualifiedClassName(UI_RankedPlayersPanelListItemLeft);
        private var DEFAULT_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE:String = PlayersPanelListRight.LINKAGE;
        private var XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE:String = getQualifiedClassName(UI_RankedPlayersPanelListItemRight);

        private var cfg:CPlayersPanel;
        private var xvm_enabled:Boolean;

        private var m_altMode:int = PLAYERS_PANEL_STATE.NONE;
        private var m_isAltMode:Boolean = false;
        private var m_savedState:int = PLAYERS_PANEL_STATE.NONE;
        private var m_startModePending:Number = NaN;
        private var mopt_fixedPosition:Boolean = false;
        private var mopt_expandAreaWidth:Number = EXPAND_AREA_WIDTH;

        private var _isStateRequested:Boolean = false;
        private var _isInteractive:Boolean = false;
        private var _isMouseRollOver:Boolean = false;

        public function UI_RankedPlayersPanel()
        {
            //Logger.add("UI_RankedPlayersPanel()");
            super();
            PlayersPanelListLeft.LINKAGE = XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE;
            PlayersPanelListRight.LINKAGE = XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);

            setup();
        }

        override protected function configUI():void
        {
            super.configUI();
            listLeft.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            listRight.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            listLeft.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            listRight.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            super.onDispose();
        }

        override public function as_setIsIntaractive(value:Boolean):void
        {
            _isInteractive = value;
            super.as_setIsIntaractive(value);
        }

        override public function as_setPanelMode(state:int):void
        {
            //Logger.add("UI_PlayersPanel.as_setPanelMode(): " + state);
            try
            {
                if (!isNaN(m_startModePending))
                {
                    state = m_startModePending;
                    m_startModePending = NaN;
                }

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

                _isStateRequested = false;

                super.as_setPanelMode(state);

                var mcfg:* = cfg[PLAYERS_PANEL_STATE_NAMES[state]];
                var new_mopt_fixedPosition:Boolean = Macros.FormatBooleanGlobal(mcfg.fixedPosition, false);
                if (mopt_fixedPosition != new_mopt_fixedPosition)
                {
                    mopt_fixedPosition = new_mopt_fixedPosition;
                    var playersDataVO:VOPlayersData = BattleState.playersDataVO;
                    if (playersDataVO)
                    {
                        if (playersDataVO.leftVehiclesIDs)
                        {
                            listLeft.updateOrder(mopt_fixedPosition ? fixIdxOrder(playersDataVO.leftVehiclesIDs) : playersDataVO.leftVehiclesIDs);
                        }
                        if (playersDataVO.rightVehiclesIDs)
                        {
                            listRight.updateOrder(mopt_fixedPosition ? fixIdxOrder(playersDataVO.rightVehiclesIDs) : playersDataVO.rightVehiclesIDs);
                        }
                    }
                }

                mopt_expandAreaWidth = state == PLAYERS_PANEL_STATE.FULL ? 0 : Macros.FormatNumberGlobal(mcfg.expandAreaWidth, EXPAND_AREA_WIDTH);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setVehiclesData(data:IDAAPIDataClass) : void
        {
            super.setVehiclesData(data);
            if (mopt_fixedPosition)
            {
                setFixedOrder(DAAPIVehiclesDataVO(data));
            }
        }

        override public function updateVehiclesData(data:IDAAPIDataClass) : void
        {
            super.updateVehiclesData(data);
            if (mopt_fixedPosition)
            {
                setFixedOrder(DAAPIVehiclesDataVO(data));
            }
        }

        override public function addVehiclesInfo(data:IDAAPIDataClass) : void
        {
            super.addVehiclesInfo(data);
            if (mopt_fixedPosition)
            {
                setFixedOrder(DAAPIVehiclesDataVO(data));
            }
        }

        override public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            super.updateVehicleStatus(data);
            if (mopt_fixedPosition)
            {
                var vehicleStatus:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(data);
                if (!vehicleStatus.isEnemy)
                {
                    if (vehicleStatus.leftVehiclesIDs)
                    {
                        listLeft.updateOrder(fixIdxOrder(vehicleStatus.leftVehiclesIDs));
                    }
                }
                else
                {
                    if (vehicleStatus.rightVehiclesIDs)
                    {
                        listRight.updateOrder(fixIdxOrder(vehicleStatus.rightVehiclesIDs));
                    }
                }
            }
        }

        override protected function onListRollOverHandler(e:MouseEvent):void
        {
            _isMouseRollOver = true;
        }

        override protected function onListRollOutHandler(e:MouseEvent):void
        {
            _isMouseRollOver = false;
        }

        override public function tryToSetPanelModeByMouseS(state:int):void
        {
            _isStateRequested = true;
            super.tryToSetPanelModeByMouseS(state);
        }

        // for extraFields in the "none" mode
        public function onMouseRollOverHandler(e:MouseEvent):void
        {
            onListRollOverHandler(e);
        }

        // for extraFields in the "none" mode
        public function onMouseRollOutHandler(e:MouseEvent):void
        {
            onListRollOutHandler(e);
        }

        public function onMouseMoveHandler(e:MouseEvent):void
        {
            if (_isInteractive && _isMouseRollOver && !_isStateRequested && mopt_expandAreaWidth > 0)
            {
                var isInExpandArea:Boolean = (e.stageX < mopt_expandAreaWidth) || (e.stageX > App.appWidth - mopt_expandAreaWidth);
                if (this.xfw_expandState == PLAYERS_PANEL_STATE.NONE && isInExpandArea)
                {
                    super.onListRollOverHandler(e);
                }
                else if (this.xfw_expandState != PLAYERS_PANEL_STATE.NONE && !isInExpandArea)
                {
                    super.onListRollOutHandler(e);
                }
            }
        }

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_PlayersPanel.setup()");
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
            //Xvm.swfProfilerEnd("UI_PlayersPanel.setup()");
            return null;
        }

        private function initPanelModes():void
        {
            var startMode:String = Macros.FormatStringGlobal(cfg.startMode, "").toLowerCase();
            if (PLAYERS_PANEL_STATE_MAP[startMode] == null)
                startMode = "large";
            cfg[startMode].enabled = true;
            m_startModePending = PLAYERS_PANEL_STATE_MAP[startMode];

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
            playersPanelLeftAtlas = registerVehicleIconAtlas(playersPanelLeftAtlas, Config.config.iconset.playersPanelLeftAtlas);
            playersPanelRightAtlas = registerVehicleIconAtlas(playersPanelRightAtlas, Config.config.iconset.playersPanelRightAtlas);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlas:Atlas = (App.atlasMgr as AtlasManager).xfw_getAtlas(newAtlas) as Atlas;
                if (atlas == null)
                {
                    App.atlasMgr.registerAtlas(newAtlas);
                    atlas = (App.atlasMgr as AtlasManager).xfw_getAtlas(newAtlas) as Atlas;
                    atlas.addEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler, false, 0, true);
                }
            }
            return newAtlas;
        }

        private function onAtlasInitializedHandler(e:AtlasEvent):void
        {
            e.currentTarget.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_ATLAS_LOADED));
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

        private function setFixedOrder(data:DAAPIVehiclesDataVO):void
        {
            if (data != null)
            {
                if (data.leftVehiclesIDs)
                {
                    listLeft.updateOrder(fixIdxOrder(data.leftVehiclesIDs));
                }
                if (data.rightVehiclesIDs)
                {
                    listRight.updateOrder(fixIdxOrder(data.rightVehiclesIDs));
                }
            }
        }

        private function fixIdxOrder(ids:Vector.<Number>):Vector.<Number>
        {
            var playerState:VOPlayerState;
            var res:Vector.<Number> = new Vector.<Number>(ids.length);
            for each (var id:Number in ids)
            {
                playerState = BattleState.get(id);
                res[playerState.position - 1] = id;
            }
            return res;
        }
    }
}
