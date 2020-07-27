/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.Xvm;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.battle.vo.VOPlayersData;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.battle.vo.VOCaptureBarData;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.core.UIComponent;

    public class BattleState extends UIComponent // implements IBattleComponentDataController
    {
        private static const INVALIDATE_PLAYERS_PANEL_MODE:String = "INVALIDATE_PLAYERS_PANEL_MODE";

        public static function get(vehicleID:Number):VOPlayerState
        {
            return instance._playersDataVO ? instance._playersDataVO.get(vehicleID) : null;
        }

        public static function getVehicleIDByPlayerName(playerFakeName:String):Number
        {
            return instance._playersDataVO ? instance._playersDataVO.getVehicleIDByPlayerName(playerFakeName) : NaN;
        }

        public static function getVehicleIDByAccountDBID(accountDBID:Number):Number
        {
            return instance._playersDataVO ? instance._playersDataVO.getVehicleIDByAccountDBID(accountDBID) : NaN;
        }

        public static function get playersDataVO():VOPlayersData
        {
            return instance._playersDataVO;
        }

        private var _captureBarData:VOCaptureBarData = new VOCaptureBarData();

        public static function get captureBarDataVO():VOCaptureBarData
        {
            return instance._captureBarDataVO;
        }

        public static function set captureBarDataVO(value:VOCaptureBarData):void
        {
            instance._captureBarDataVO = value;
        }

        public static function get playerIsAlive():Boolean
        {
            return instance._playerIsAlive;
        }

        public static function set playerIsAlive(value:Boolean):void
        {
            instance._playerIsAlive = value;
        }

        public static function get playerFrags():int
        {
            return instance._playerFrags;
        }

        public static function set playerFrags(value:int):void
        {
            instance._playerFrags = value;
        }

        // zoom

        public static function get currentAimZoom():Number
        {
            return instance._currentAimZoom;
        }

        public static function set currentAimZoom(value:Number):void
        {
            instance._currentAimZoom = value;
        }

        // players panel

        public static function get playersPanelMode():int
        {
            return instance._playersPanelMode;
        }

        public static function set playersPanelMode(value:int):void
        {
            if (instance._playersPanelMode != value)
            {
                instance._playersPanelMode = value;
                instance.invalidate(INVALIDATE_PLAYERS_PANEL_MODE);
            }
        }

        public static function get playersPanelWidthLeft():int
        {
            return instance._playersPanelWidthLeft;
        }

        public static function set playersPanelWidthLeft(value:int):void
        {
            if (instance._playersPanelWidthLeft != value)
            {
                instance._playersPanelWidthLeft = value;
                instance.invalidate(INVALIDATE_PLAYERS_PANEL_MODE);
            }
        }

        public static function get playersPanelWidthRight():int
        {
            return instance._playersPanelWidthRight;
        }

        public static function set playersPanelWidthRight(value:int):void
        {
            if (instance._playersPanelWidthRight != value)
            {
                instance._playersPanelWidthRight = value;
                instance.invalidate(INVALIDATE_PLAYERS_PANEL_MODE);
            }
        }

        // instance
        private static var _instance:BattleState = null;
        public static function get instance():BattleState
        {
            if (_instance == null)
            {
                _instance = new BattleState();
            }
            return _instance;
        }

        private var _playersDataVO:VOPlayersData = null;
        private var _captureBarDataVO:VOCaptureBarData = new VOCaptureBarData();
        private var _personalStatus:uint;
        private var _playerIsAlive:Boolean = true;
        private var _playerFrags:int = 0;
        private var _currentAimZoom:Number = 0;
        private var _playersPanelMode:int = 0;
        private var _playersPanelWidthLeft:int = 0;
        private var _playersPanelWidthRight:int = 0;

        private var _invalidationStates:Object = {};

        // .ctor should be private for Singleton
        function BattleState()
        {
            focusable = false;
            visible = false;
            Xfw.addCommandListener(BattleCommands.AS_UPDATE_PLAYER_STATE, onUpdatePlayerState);
            Xfw.addCommandListener(BattleCommands.AS_UPDATE_DEVICE_STATE, onUpdateDeviceState);
        }

        override protected function draw():void
        {
            try
            {
                if (isInvalid(InvalidationType.STATE))
                {
                    if (_playersDataVO)
                    {
                        _playersDataVO.dispatchEvents();
                    }
                }
                if (isInvalid(InvalidationType.DATA))
                {
                    for (var key:String in _invalidationStates)
                    {
                        var playerState:VOPlayerState = get(Number(key));
                        if (playerState)
                        {
                            playerState.dispatchEvents();
                        }
                    }
                    _invalidationStates = {};
                }
                if (isInvalid(INVALIDATE_PLAYERS_PANEL_MODE))
                {
                    Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_PANEL_MODE_CHANGED));
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // IBattleComponentDataController implementation

        public function setVehiclesData(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] setVehiclesData');
            updateVehiclesData(data);
        }

        public function addVehiclesInfo(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] addVehiclesInfo');
            updateVehiclesData(data);
        }

        public function updateVehiclesData(data:Object):void
        {
            //Logger.addObject(data, 3, '[BattleState] updateVehiclesData');
            //Xvm.swfProfilerBegin("BattleState.updateVehiclesData()");
            try
            {
                if (_playersDataVO == null)
                {
                    _playersDataVO = new VOPlayersData();
                }
                _playersDataVO.updateVehiclesData(data);
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                //Xvm.swfProfilerEnd("BattleState.updateVehiclesData()");
            }
        }

        public function updateVehicleStatus(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] updateVehicleStatus');
            //Xvm.swfProfilerBegin("BattleState.updateVehicleStatus()");
            try
            {
                if (_playersDataVO == null)
                    return;
                _playersDataVO.updatePlayerState(data.vehicleID, { vehicleStatus: data.status });
                if (data.rightVehiclesIDs || data.rightItemsIDs)
                    _playersDataVO.rightVehiclesIDs = Vector.<Number>(data.rightVehiclesIDs || data.rightItemsIDs);
                if (data.leftVehiclesIDs || data.leftItemsIDs)
                    _playersDataVO.leftVehiclesIDs = Vector.<Number>(data.leftVehiclesIDs || data.leftItemsIDs);
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                //Xvm.swfProfilerEnd("BattleState.updateVehicleStatus()");
            }
        }

        public function updateTriggeredChatCommands(data:Object):void
        {

        }


        public function updatePersonalStatus(param1:uint, param2:uint):void
        {
            //Logger.add("[BattleState] updatePersonalStatus: " + param1 + ", " + param2);
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            {
                this._allyVehicleMarkersList.isVehicleCounterShown = this._enemyVehicleMarkersList.isVehicleCounterShown = true;
            }
            else if (PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param2)
            {
                this._allyVehicleMarkersList.isVehicleCounterShown = this._enemyVehicleMarkersList.isVehicleCounterShown = false;
            }
            */
        }

        public function resetFrags():void
        {
            // empty
        }

        public function setFrags(data:Object):void
        {
            //Logger.addObject(data, 2, "[BattleState] setFrags");
            try
            {
                updateVehiclesStat(data);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateVehiclesStat(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] updateVehiclesStat');
            //Xvm.swfProfilerBegin("BattleState.updateVehiclesStat()");
            try
            {
                if (_playersDataVO == null)
                    return;
                if (data.leftItems)
                {
                    _playersDataVO.updateVehicleFrags(data.leftItems);
                }
                if (data.rightItems)
                {
                    _playersDataVO.updateVehicleFrags(data.rightItems);
                }
                if (data.leftFrags)
                {
                    _playersDataVO.updateVehicleFrags(data.leftFrags);
                }
                if (data.rightFrags)
                {
                    _playersDataVO.updateVehicleFrags(data.rightFrags);
                }
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                //Xvm.swfProfilerEnd("BattleState.updateVehiclesStat()");
            }
        }

        public function updatePlayerStatus(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] updatePlayerStatus');
            //Xvm.swfProfilerBegin("BattleState.updatePlayerStatus()");
            try
            {
                if (_playersDataVO == null)
                    return;
                _playersDataVO.updatePlayerState(data.vehicleID, { playerStatus: data.status } );
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                //Xvm.swfProfilerEnd("BattleState.updatePlayerStatus()");
            }
        }

        public function setUserTags(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] setUserTags');
            try
            {
                if (_playersDataVO == null)
                    return;
                _playersDataVO.setUserTags(data);
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateUserTags(data:Object):void
        {
            //Logger.addObject(data, 2, '[BattleState] updateUserTags');
            try
            {
                if (_playersDataVO == null)
                    return;
                _playersDataVO.updateUserTags(data);
                invalidate(InvalidationType.STATE);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function setPersonalStatus(param1:uint):void
        {
            //Logger.add("[BattleState] setPersonalStatus: " + param1);
            try
            {
                _personalStatus = param1;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateInvitationsStatuses(data:Object) : void
        {
            //Logger.addObject(data, 2, "[BattleState] updateInvitationsStatuses");
        }

        public function setQuestStatus(data:Object):void
        {
            //Logger.addObject(data, 2, "[BattleState] setQuestStatus");
        }

        // XVM events

        private function onUpdatePlayerState(vehicleID:Number, data:Object):void
        {
            //Logger.addObject(data, 2, "[BattleState] onUpdatePlayerState: " + vehicleID);
            //Xvm.swfProfilerBegin("BattleState.onUpdatePlayerState()");
            try
            {
                var playerState:VOPlayerState = get(vehicleID);
                if (playerState)
                {
                    var damageCaused:Boolean = data.__damageCaused;
                    if (damageCaused)
                    {
                        delete data.__damageCaused;
                    }
                    playerState.update(data);
                    if (damageCaused)
                    {
                        Xvm.dispatchEvent(new PlayerStateEvent(playerState.isEnemy
                            ? PlayerStateEvent.DAMAGE_CAUSED
                            : PlayerStateEvent.DAMAGE_CAUSED_ALLY));
                    }
                    _invalidationStates[playerState.vehicleID] = true;
                    invalidate(InvalidationType.DATA);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                //Xvm.swfProfilerEnd("BattleState.onUpdatePlayerState()");
            }
        }

        private function onUpdateDeviceState(moduleName:String, state:String, state2:String):void
        {
            //Logger.add("[BattleState] onUpdateDeviceState: " + arguments);
            try
            {
                var eventType:String = null;
                switch (state)
                {
                    case "critical":
                        eventType = PlayerStateEvent.MODULE_CRITICAL;
                        break;
                    case "destroyed":
                        eventType = PlayerStateEvent.MODULE_DESTROYED;
                        break;
                    case "repaired":
                        eventType = PlayerStateEvent.MODULE_REPAIRED;
                        break;
                }
                if (eventType)
                {
                    Xvm.dispatchEvent(new PlayerStateEvent(eventType, NaN, null, { moduleName: moduleName }));
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
