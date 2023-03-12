/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.playersPanel
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.shared.playersPanel.PlayersPanelListItemProxyBase;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.impl.*;

    public class UI_PlayersPanel extends PlayersPanelUI
    {
        // from PlayersPanel.as
        static private const EXPAND_AREA_WIDTH:Number = 230;

        static private const XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE:String = getQualifiedClassName(UI_PlayersPanelListItemLeft);
        static private const XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE:String = getQualifiedClassName(UI_PlayersPanelListItemRight);

        private var DEFAULT_INVITE_INDICATOR_X_LEFT:int;
        private var DEFAULT_INVITE_INDICATOR_Y_LEFT:int;
        private var DEFAULT_INVITE_INDICATOR_X_RIGHT:int;
        private var DEFAULT_INVITE_INDICATOR_Y_RIGHT:int;

        private var cfg:CPlayersPanel;
        private var xvm_enabled:Boolean;

        private var m_altMode:int = PLAYERS_PANEL_STATE.NONE;
        private var m_isAltMode:Boolean = false;
        private var m_savedState:int = PLAYERS_PANEL_STATE.NONE;
        private var m_startModePending:Number = NaN;
        private var mopt_fixedPosition:Boolean = false;
        private var mopt_expandAreaWidth:Number = EXPAND_AREA_WIDTH;

        private var _isMouseRollOver:Boolean = false;

        private var _leftHasBadges:Boolean = false;
        private var _rightHasBadges:Boolean = false;

        static public function fix_state(state:int):int
        {
            switch (state)
            {
                case PLAYERS_PANEL_STATE.SHORT_NO_BADGES:
                    return PLAYERS_PANEL_STATE.SHORT;
                case PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES:
                    return PLAYERS_PANEL_STATE.MEDIUM;
                case PLAYERS_PANEL_STATE.FULL_NO_BADGES:
                    return PLAYERS_PANEL_STATE.FULL;
                case PLAYERS_PANEL_STATE.LONG_NO_BADGES:
                    return PLAYERS_PANEL_STATE.LONG;
                default:
                    return state;
            }
        }

        public function UI_PlayersPanel()
        {
            Logger.add("UI_PlayersPanel()");
            super();

            XfwAccess.setPrivateField(PlayersPanelListLeft, "LINKAGE", XVM_PLAYERS_PANEL_LIST_ITEM_LEFT_LINKAGE);
            XfwAccess.setPrivateField(PlayersPanelListRight, "LINKAGE", XVM_PLAYERS_PANEL_LIST_ITEM_RIGHT_LINKAGE);

            registerPlayersPanelMacros();

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);

            DEFAULT_INVITE_INDICATOR_X_LEFT = (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.x;
            DEFAULT_INVITE_INDICATOR_Y_LEFT = (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.y;
            DEFAULT_INVITE_INDICATOR_X_RIGHT = (listRight as PlayersPanelListRight).inviteReceivedIndicator.x;
            DEFAULT_INVITE_INDICATOR_Y_RIGHT = (listRight as PlayersPanelListRight).inviteReceivedIndicator.y;

            setup();
        }

        override protected function configUI():void
        {
            super.configUI();
            listLeft.removeEventListener(MouseEvent.ROLL_OVER, XfwAccess.getPrivateField(this, 'xfw_onListRollOverHandler'));
            listLeft.removeEventListener(MouseEvent.ROLL_OUT, XfwAccess.getPrivateField(this, 'xfw_onListRollOutHandler'));

            listRight.removeEventListener(MouseEvent.ROLL_OVER, XfwAccess.getPrivateField(this, 'xfw_onListRollOverHandler'));
            listRight.removeEventListener(MouseEvent.ROLL_OUT, XfwAccess.getPrivateField(this, 'xfw_onListRollOutHandler'));

            listLeft.addEventListener(MouseEvent.ROLL_OVER, onListRollOverHandler, false, 0, true);
            listLeft.addEventListener(MouseEvent.ROLL_OUT, onListRollOutHandler, false, 0, true);
            listLeft.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler, false, 0, true);

            listRight.addEventListener(MouseEvent.ROLL_OVER, onListRollOverHandler, false, 0, true);
            listRight.addEventListener(MouseEvent.ROLL_OUT, onListRollOutHandler, false, 0, true);
            listRight.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler, false, 0, true);
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            listLeft.removeEventListener(MouseEvent.ROLL_OVER, onListRollOverHandler);
            listLeft.removeEventListener(MouseEvent.ROLL_OUT, onListRollOutHandler);
            listLeft.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            listRight.removeEventListener(MouseEvent.ROLL_OVER, onListRollOverHandler);
            listRight.removeEventListener(MouseEvent.ROLL_OUT, onListRollOutHandler);
            listRight.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
            super.onDispose();
        }

        override protected function setListsState(state:int):void
        {
            //Logger.add("UI_PlayersPanel.setListsState(): " + state);
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
                    if (state != PLAYERS_PANEL_STATE.NONE)
                    {
                        if (m_savedState == PLAYERS_PANEL_STATE.NONE)
                        {
                            if (!Macros.FormatBooleanGlobal(cfg[PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_NAMES[state]].enabled, true))
                            {
                                requestState((state + 1) % PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_NAMES.length);
                                return;
                            }
                        }
                    }
                }

                super.setListsState(state);

                var mcfg:* = cfg[PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_NAMES[state]];
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

                updateBattleStatePlayersPanelData();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setPersonalStatus(param1:uint):void
        {
            if (Config.IS_DEVELOPMENT)
            {
                param1 |= PersonalStatus.CAN_SEND_INVITE_TO_ALLY;
            }
            super.setPersonalStatus(param1);
        }

        override public function setVehiclesData(data:IDAAPIDataClass) : void
        {
            super.setVehiclesData(data);
            var d:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);
            updateHasBadges(d);
            if (mopt_fixedPosition)
            {
                setFixedOrder(d);
            }
        }

        override public function updateVehiclesData(data:IDAAPIDataClass) : void
        {
            super.updateVehiclesData(data);
            var d:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);
            updateHasBadges(d);
            if (mopt_fixedPosition)
            {
                setFixedOrder(d);
            }
        }

        override public function addVehiclesInfo(data:IDAAPIDataClass) : void
        {
            super.addVehiclesInfo(data);
            var d:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);
            updateHasBadges(d);
            if (mopt_fixedPosition)
            {
                setFixedOrder(d);
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

        override protected function applyVehicleData(param1:IDAAPIDataClass):void
        {
            super.applyVehicleData(param1);
            updateBattleStatePlayersPanelData();
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
            try
            {
                if (mopt_expandAreaWidth > 0)
                {
                    if (_isMouseRollOver)
                    {
                        var isInExpandArea:Boolean = (e.stageX < mopt_expandAreaWidth) || (e.stageX > App.appWidth - mopt_expandAreaWidth);
                        if (isInExpandArea)
                        {
                            XfwAccess.getPrivateField(this, "xfw_onListRollOverHandler")(e);
                        }
                        else
                        {
                            XfwAccess.getPrivateField(this, "xfw_onListRollOutHandler")(e);
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onListRollOverHandler(e:MouseEvent):void
        {
            _isMouseRollOver = true;
        }

        private function onListRollOutHandler(e:MouseEvent):void
        {
            _isMouseRollOver = false;
        }

        private function registerPlayersPanelMacros():void
        {
            // {{hasBadges}}
            Macros.Globals["hasBadges"] = function(o:IVOMacrosOptions):* {
                return (o.isEnemy ? _rightHasBadges : _leftHasBadges) ? "true" : null;
            }
        }

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
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.alpha = Macros.FormatNumberGlobal(cfg.none.inviteIndicatorAlpha, 100) / 100.0;
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.x = DEFAULT_INVITE_INDICATOR_X_LEFT + Macros.FormatNumberGlobal(cfg.none.inviteIndicatorX, 0);
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.y = DEFAULT_INVITE_INDICATOR_Y_LEFT + Macros.FormatNumberGlobal(cfg.none.inviteIndicatorY, 0);
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.alpha = Macros.FormatNumberGlobal(cfg.none.inviteIndicatorAlpha, 100) / 100.0;
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.x = DEFAULT_INVITE_INDICATOR_X_RIGHT - Macros.FormatNumberGlobal(cfg.none.inviteIndicatorX, 0);
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.y = DEFAULT_INVITE_INDICATOR_Y_RIGHT + Macros.FormatNumberGlobal(cfg.none.inviteIndicatorY, 0);
                }
                else
                {
                    panelSwitch.visible = true;
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.alpha = 1;
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.x = DEFAULT_INVITE_INDICATOR_X_LEFT;
                    (listLeft as PlayersPanelListLeft).inviteReceivedIndicator.y = DEFAULT_INVITE_INDICATOR_Y_LEFT;
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.alpha = 1;
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.x = DEFAULT_INVITE_INDICATOR_X_RIGHT;
                    (listRight as PlayersPanelListRight).inviteReceivedIndicator.y = DEFAULT_INVITE_INDICATOR_Y_RIGHT;
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
            if (PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_MAP[startMode] == null)
                startMode = "large";
            cfg[startMode].enabled = true;
            m_startModePending = PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_MAP[startMode];

            m_savedState = PLAYERS_PANEL_STATE.NONE;

            var altMode:String = Macros.FormatStringGlobal(cfg.altMode, "").toLowerCase();
            m_altMode = (PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_MAP[altMode] == null)
                ? PLAYERS_PANEL_STATE.NONE
                : PlayersPanelListItemProxyBase.PLAYERS_PANEL_STATE_MAP[altMode];
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
            PlayersPanelListItemProxyBase.leftAtlas = registerVehicleIconAtlas(PlayersPanelListItemProxyBase.leftAtlas, Config.config.iconset.playersPanelLeftAtlas);
            PlayersPanelListItemProxyBase.rightAtlas = registerVehicleIconAtlas(PlayersPanelListItemProxyBase.rightAtlas, Config.config.iconset.playersPanelRightAtlas);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlasMgr:AtlasManager = App.atlasMgr as AtlasManager;
                var atlas:Atlas = XfwAccess.getPrivateField(atlasMgr , 'getAtlas')(newAtlas);

                if (atlas == null)
                {
                    atlasMgr.registerAtlas(newAtlas);
                    atlas = XfwAccess.getPrivateField(atlasMgr , 'getAtlas')(newAtlas);
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
                requestState(m_altMode);
            }
            else
            {
                if (m_savedState != PLAYERS_PANEL_STATE.NONE)
                {
                    //Logger.add(String(m_savedState));
                    requestState(fix_state(m_savedState));
                }
                m_savedState = PLAYERS_PANEL_STATE.NONE;
            }
        }

        private function updateHasBadges(data:DAAPIVehiclesDataVO):void
        {
            _leftHasBadges = false;
            _rightHasBadges = false;
            var vi:DAAPIVehicleInfoVO;

            for each (vi in data.leftVehicleInfos)
            {
                if (vi.badgeVO)
                {
                    _leftHasBadges = true;
                    break;
                }
            }

            for each(vi in data.rightVehicleInfos)
            {
                if (vi.badgeVO)
                {
                    _rightHasBadges = true;
                    break;
                }
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

        private function updateBattleStatePlayersPanelData():void
        {
            BattleState.playersPanelMode = state;
            if (!xvm_enabled)
            {
                BattleState.playersPanelWidthLeft = listLeft.getRenderersVisibleWidth() + PlayersPanelListItemProxyBase.PLAYERS_PANEL_WIDTH_OFFSET;
                BattleState.playersPanelWidthRight = listRight.getRenderersVisibleWidth() + PlayersPanelListItemProxyBase.PLAYERS_PANEL_WIDTH_OFFSET;
            }
        }
    }
}
