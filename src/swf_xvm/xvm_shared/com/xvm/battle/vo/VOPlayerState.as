/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.wg.*;
    import com.xvm.types.*;
    import com.xvm.types.stat.*;
    import com.xvm.vo.*;
    import flash.utils.*;

    public class VOPlayerState extends VOMacrosOptions
    {
        // DAAPIVehicleInfoVO
        private var _accountDBID:Number = NaN;
        private var _invitationStatus:uint = 0;
        private var _isObserver:Boolean = false;
        private var _isSpeaking:Boolean = false;
        private var _isVehiclePremiumIgr:Boolean = false;
        private var _playerFullName:String = null;
        private var _playerFakeName:String = null;
        private var _playerName:String = null;
        private var _clanAbbrev:String = null;
        private var __badgeId:String = null;
        private var _badgeVO:* = null;
        private var _hasSelectedBadge:Boolean = false;
        private var _suffixBadgeType:String = "";
        private var _playerStatus:uint = 0;
        private var _prebattleID:Number = NaN;
        private var _region:String = null;
        private var _squadIndex:uint = 0;
        private var _rankLevel:uint = 0;
        private var _teamColor:String = null;
        private var _userTags:Array = null;
        private var _vehicleAction:uint = 0;
        private var _vehicleGuiName:String = null;
        private var _vehicleIcon:String = null;
        private var _vehicleIconName:String = null;
        private var _vehicleID:Number = NaN;
        private var __vehicleStatus:uint = 0;
        private var _isAlly:Boolean = false;
        private var _isBlown:Boolean = false;

        // DAAPIVehicleStatsVO
        private var __frags:int = 0;

        // XVM
        private var _marksOnGun:Number = NaN;
        private var _turretCD:int = 0;
        private var _spottedStatus:String = null;
        private var __curHealth:Number = NaN;
        private var _maxHealth:Number = NaN;
        private var _isCrewActive:Boolean = true;

        private var _damageInfo:VODamageInfo = null;
        private var _markerState:VOMarkerState = null;
        private var _xmqpData:VOXmqpData = new VOXmqpData();

        private var _index:int = -1;
        private var _position:Number = NaN;
        private var _vehCD:int = 0;
        private var _vehicleData:VOVehicleData = null;

        // IMacrosOptionsVO implementation

        public function get accountDBID():Number
        {
            return _accountDBID;
        }

        override public function get vehicleID():Number
        {
            return _vehicleID;
        }

        public function get playerFullName():String
        {
            return _playerFullName;
        }

        override public function get playerFakeName():String
        {
            return _playerFakeName;
        }

        override public function get playerName():String
        {
            return _playerName;
        }

        override public function get clanAbbrev():String
        {
            return _clanAbbrev;
        }

        public function get badgeId():String
        {
            return __badgeId;
        }

        public function get hasSelectedBadge():Boolean
        {
            return _hasSelectedBadge;
        }

        public function get badgeVO():*
        {
            return _badgeVO;
        }

        internal function set_badgeVO(value:*):void
        {
            _badgeVO = value;
            if (_badgeVO && _badgeVO.icon)
            {
                __badgeId = _badgeVO.icon.replace("badge_", "");
            }
            else
            {
                __badgeId = null;
            }
        }

        internal function get suffixBadgeType():String
        {
            return _suffixBadgeType;
        }

        // icons of testers and someone else?
        //internal function set_suffixBadgeType(value:String):void
        //{
            //_suffixBadgeType = value;
            //if (value)
            //{
                //__badgeId = value.replace("badge_", "");
            //}
        //}

        override public function get isAlly():Boolean
        {
            return _isAlly;
        }

        override public function get isAlive():Boolean
        {
            return VehicleStatus.isAlive(vehicleStatus) && (isNaN(__curHealth) || __curHealth > 0);
        }

        override public function get isReady():Boolean
        {
            return VehicleStatus.isReady(vehicleStatus);
        }

        override public function get isNotAvailable():Boolean
        {
            return VehicleStatus.isNotAvailable(vehicleStatus);
        }

        override public function get isStopRespawn():Boolean
        {
            return VehicleStatus.isStopRespawn(vehicleStatus);
        }

        public function get isActionDisabled():Boolean
        {
            return PlayerStatus.isActionDisabled(playerStatus);
        }

        override public function get isSelected():Boolean
        {
            return PlayerStatus.isSelected(playerStatus);
        }

        override public function get isSquadPersonal():Boolean
        {
            return PlayerStatus.isSquadPersonal(playerStatus) /* pre-battle squad */ || (isAlly && squadIndex && squadIndex == BattleGlobalData.playerSquad); // dynamic squad
        }

        override public function get isTeamKiller():Boolean
        {
            return PlayerStatus.isTeamKiller(playerStatus);
        }

        public function get isVoipDisabled():Boolean
        {
            return PlayerStatus.isVoipDisabled(playerStatus);
        }

        override public function get isCurrentPlayer():Boolean
        {
            return BattleGlobalData.playerVehicleID == vehicleID;
        }

        public function set_isCurrentPlayer(value:Boolean):void
        {
            //Logger.add("WARNING: attempt to set value for read only property isCurrentPlayer");
        }

        public function get userTags():Array
        {
            return _userTags;
        }

        internal function set_userTags(value:Array):void
        {
            _userTags = value.concat();
        }

        public function get isBusy():Boolean
        {
            return UserTags.isBusy(_userTags);
        }

        override public function get isChatBan():Boolean
        {
            return UserTags.isChatBan(_userTags);
        }

        override public function get isFriend():Boolean
        {
            return UserTags.isFriend(_userTags);
        }

        override public function get isIgnored():Boolean
        {
            return UserTags.isIgnored(_userTags);
        }

        override public function get isMuted():Boolean
        {
            return UserTags.isMuted(_userTags);
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        internal function set_squadIndex(value:Number):void
        {
            _squadIndex = value;
            if (isCurrentPlayer)
            {
                BattleGlobalData.playerSquad = value;
            }
        }

        override public function get rankLevel():Number
        {
            return _rankLevel;
        }

        override public function get position():Number
        {
            return _position;
        }

        override public function get index():int
        {
            return _index;
        }

        override public function get vehCD():int
        {
            return _vehCD;
        }

        override public function get vehicleData():VOVehicleData
        {
            return _vehicleData;
        }

        public function get vehicleIconName():String
        {
            return _vehicleIconName;
        }

        internal function set_vehicleIconName(value:String):void
        {
            _vehicleIconName = value;
            _vehicleData = VehicleInfo.getByIconName(value);
            if (_vehicleData)
            {
                if (_vehCD != _vehicleData.vehCD)
                {
                    Macros.RegisterVehicleMacrosData(playerName, playerFakeName, _vehicleData.vehCD);
                    _vehCD = _vehicleData.vehCD;
                }
            }
        }

        public function get isSPG():Boolean
        {
            return _vehicleData ? _vehicleData.vclass == VehicleClass.SPG : false;
        }

        public function get vehicleStatus():uint
        {
            return __vehicleStatus;
        }

        internal function set_vehicleStatus(value:uint):void
        {
            var wasAlive:Boolean = VehicleStatus.isAlive(vehicleStatus);
            __vehicleStatus = value;
            updateStatData();
            if (wasAlive)
            {
                if (isDead)
                {
                    eventsToDispatch[PlayerStateEvent.VEHICLE_DESTROYED] = true;
                    if (isCurrentPlayer)
                    {
                        BattleState.playerIsAlive = false;
                        eventsToDispatch[PlayerStateEvent.CURRENT_VEHICLE_DESTROYED] = true;
                    }
                }
            }
        }

        public function get playerStatus():uint
        {
            return _playerStatus;
        }

        public function get frags():int
        {
            return __frags;
        }

        internal function set_frags(value:int):void
        {
            __frags = value;
            if (isCurrentPlayer)
            {
                BattleState.playerFrags = value;
            }
        }

        // helpers

        public function getSpottedStatus():String
        {
            return isDead ? "dead" : _spottedStatus == null ? "neverSeen" : _spottedStatus;
        }

        public function get isBlown():Boolean
        {
            return _isBlown;
        }

        override public function get marksOnGun():Number
        {
            return _marksOnGun;
        }

        public function get spottedStatus():String
        {
            return _spottedStatus;
        }

        public function get curHealth():Number
        {
            return isAlive ? __curHealth : 0;
        }

        public function getCurHealthValue():Number
        {
            return __curHealth;
        }

        internal function set_curHealth(value:Number):void
        {
            // DESTR_BY_FALL_RAMMING = -2
            // FUEL_EXPLODED = -3
            // AMMO_BAY_DESTROYED = -5
            // TURRET_DETACHED = -13
            if (value < 0)
            {
                _isBlown = value == -5 || value == -13;
                value = 0;
            }
            __curHealth = value;
            eventsToDispatch[PlayerStateEvent.PLAYERS_HP_CHANGED] = true;
            if (isCurrentPlayer)
            {
                eventsToDispatch[PlayerStateEvent.MY_HP_CHANGED] = true;
            }
        }

        public function get isCrewActive():Boolean
        {
            return _isCrewActive;
        }

        public function get turretCD():int
        {
            return _turretCD;
        }

        public function get maxHealth():Number
        {
            return _maxHealth || (_vehicleData ? _vehicleData.hpTop : NaN);
        }

        public function get damageInfo():VODamageInfo
        {
            return _damageInfo;
        }

        public function set damageInfo(value:VODamageInfo):void
        {
            _damageInfo = value;
        }

        public function get markerState():VOMarkerState
        {
            return _markerState;
        }

        public function set markerState(value:VOMarkerState):void
        {
            _markerState = value;
        }

        public function get xmqpData():VOXmqpData
        {
            return _xmqpData;
        }

        //

        private var eventsToDispatch:Object = { };

        public function VOPlayerState(data:Object = null)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(data);
        }

        private function _init(data:Object):void
        {
            if (!data)
                return;

            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

            update(data);
        }

        override public function update(data:Object):Boolean
        {
            var updated:Boolean = false;
            for (var name:String in data)
            {
                if (_updateValue(name, data[name]))
                    updated = true;
            }
            if (getQualifiedClassName(data) != "Object")
            {
                var describeTypeXML:XML = describeType(data);
                for each (var accessor:XML in describeTypeXML..accessor)
                {
                    if (accessor.@access == "readwrite")
                    {
                        if (_updateValue(accessor.@name, data[accessor.@name]))
                            updated = true;
                    }
                }
                for each (var variable:XML in describeTypeXML..variable)
                {
                    if (_updateValue(variable.@name, data[variable.@name]))
                        updated = true;
                }
            }
            if (updated)
            {
                eventsToDispatch[PlayerStateEvent.CHANGED] = true;
            }
            return updated;
        }

        public function updateXmqpData(data:Object):Boolean
        {
            var updated:Boolean = _xmqpData.update(data);
            if (updated)
            {
                eventsToDispatch[PlayerStateEvent.CHANGED] = true;
            }
            return updated;
        }

        private function _updateValue(name:String, value:*):Boolean
        {
            if (this[name] !== undefined)
            {
                if (this[name] != value)
                {
                    var k:String = "set_" + name;
                    if (this[k] !== undefined)
                    {
                        //Logger.add(playerName + ": " + k + "(" + value + ")");
                        this[k](value);
                    }
                    else
                    {
                        //Logger.add(playerName + ": _" + name + " = " + value);
                        this["_" + name] = value;
                    }
                    return true;
                }
            }
            /*else
            {
                Logger.add(playerName + ": " + name + " = " + value);
            }*/
            return false;
        }

        public function dispatchEvents():void
        {
            for (var eventName:String in eventsToDispatch)
            {
                //Logger.add(playerName + " " + eventName);
                Xvm.dispatchEvent(new PlayerStateEvent(eventName, vehicleID, playerName));
            }
            eventsToDispatch = { };
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e.result)
            {
                var len:int = e.result.length;
                var updated:Boolean = false;
                for (var i:int = 0; i < len; ++i)
                {
                    if (e.result[i] == playerName)
                    {
                        updated = updated || updateStatData();
                        break;
                    }
                }
                if (updated)
                {
                    eventsToDispatch[PlayerStateEvent.CHANGED] = true;
                    dispatchEvents();
                }
            }
        }

        private function updateStatData():Boolean
        {
            var sd:StatData = Stat.battleStat[playerName];
            if (sd)
            {
                sd.alive = isAlive;
                return true;
            }
            return false;
        }
    }
}
