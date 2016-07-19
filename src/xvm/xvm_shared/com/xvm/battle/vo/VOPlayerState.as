/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.wg.*;
    import com.xfw.events.*;
    import com.xvm.vo.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.stat.*;
    import flash.errors.*;

    public class VOPlayerState extends VOMacrosOptions
    {
        // DAAPIVehicleInfoVO
        private var _accountDBID:Number;
        private var _clanAbbrev:String;
        private var _invitationStatus:uint;
        private var _isObserver:Boolean;
        private var _isSpeaking:Boolean;
        private var _isVehiclePremiumIgr:Boolean;
        private var _playerFullName:String;
        private var _playerName:String;
        private var _playerStatus:uint;
        private var _prebattleID:Number;
        private var _region:String;
        private var _squadIndex:uint;
        private var _teamColor:String;
        private var _userTags:Array;
        private var _vehicleAction:uint;
        private var _vehicleGuiName:String;
        private var _vehicleIcon:String;
        private var _vehicleIconName:String;
        private var _vehicleID:Number;
        private var __vehicleStatus:uint;
        private var _isAlly:Boolean;
        private var _isBlown:Boolean;

        // DAAPIVehicleStatsVO
        private var __frags:int = 0;

        // XVM
        private var _marksOnGun:Number = NaN;
        private var _spottedStatus:String = null;
        private var __curHealth:Number = NaN;
        private var _maxHealth:Number = NaN;

        private var _damageInfo:VODamageInfo;
        private var _xmqpData:VOXmqpData;

        private var _hitlogCount:int = 0;
        private var _hitlogDamage:int = 0;

        private var _position:Number = NaN;
        private var _vehCD:int;
        private var _vehicleData:VOVehicleData;

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

        override public function get playerName():String
        {
            return _playerName;
        }

        override public function get isAlly():Boolean
        {
            return _isAlly;
        }

        override public function get isAlive():Boolean
        {
            return VehicleStatus.isAlive(vehicleStatus);
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

        public function get isSquadMan():Boolean
        {
            return PlayerStatus.isSquadMan(playerStatus);
        }

        override public function get isSquadPersonal():Boolean
        {
            return PlayerStatus.isSquadPersonal(playerStatus);
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

        public function get isBusy():Boolean
        {
            return UserTags.isBusy(_userTags);
        }

        public function get isChatBan():Boolean
        {
            return UserTags.isChatBan(_userTags);
        }

        public function get isFriend():Boolean
        {
            return UserTags.isFriend(_userTags);
        }

        public function get isIgnored():Boolean
        {
            return UserTags.isIgnored(_userTags);
        }

        public function get isMuted():Boolean
        {
            return UserTags.isMuted(_userTags);
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        override public function get position():Number
        {
            return _position;
        }

        override public function get vehCD():int
        {
            return _vehCD;
        }

        override public function get vehicleData():VOVehicleData
        {
            return _vehicleData;
        }

        public function get vehicleStatus():uint
        {
            return __vehicleStatus;
        }

        internal function set_vehicleStatus(value:uint):void
        {
            var alive:Boolean = isAlive;
            __vehicleStatus = value;
            updateStatData();
            if (alive && isDead)
            {
                eventsToDispatch[PlayerStateEvent.DEAD] = true;
                if (isCurrentPlayer)
                {
                    eventsToDispatch[PlayerStateEvent.SELF_DEAD] = true;
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

        public function getCurrentHealth():Number
        {
            return isAlive ? curHealth : 0;
        }

        public function get isBlown():Boolean
        {
            return _isBlown;
        }

        public function get marksOnGun():Number
        {
            return _marksOnGun;
        }

        public function get curHealth():Number
        {
            return __curHealth;
        }

        internal function set_curHealth(value:Number):void
        {
            if (value < 0)
            {
                _isBlown = true;
                value = 0;
            }
            __curHealth = value;
            eventsToDispatch[PlayerStateEvent.HP_CHANGED] = true;
        }

        public function get maxHealth():Number
        {
            return _maxHealth;
        }

        public function get damageInfo():VODamageInfo
        {
            return _damageInfo;
        }

        public function get xmqpData():VOXmqpData
        {
            return _xmqpData;
        }

        public function get hitlogCount():int
        {
            return _hitlogCount;
        }

        public function get hitlogDamage():int
        {
            return _hitlogDamage;
        }

        //

        private var eventsToDispatch:Object = { };

        public function VOPlayerState(data:Object = null)
        {
            if (!data)
                return;
            _accountDBID = data.accountDBID;
            _clanAbbrev = data.clanAbbrev;
            _invitationStatus = data.invitationStatus;
            _isObserver = data.isObserver;
            _isSpeaking = data.isSpeaking;
            _isVehiclePremiumIgr = data.isVehiclePremiumIgr;
            _playerFullName = data.playerFullName;
            _playerName = data.playerName;
            _playerStatus = data.playerStatus;
            _prebattleID = data.prebattleID;
            _region = data.region;
            _squadIndex = data.squadIndex;
            _teamColor = data.teamColor;
            if (data.userTags)
            {
                _userTags = data.userTags.concat();
            }
            _vehicleAction = data.vehicleAction;
            _vehicleGuiName = data.vehicleGuiName;
            _vehicleIcon = data.vehicleIcon;
            _vehicleIconName = data.vehicleIconName;
            _vehicleID = data.vehicleID;

            set_vehicleStatus(data.vehicleStatus);

            // TODO: refactor
            _vehicleData = VehicleInfo.getByLocalizedShortName(data.vehicleName);
            if (_vehicleData)
            {
                _vehCD = _vehicleData.vehCD;
            }

            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

            eventsToDispatch[PlayerStateEvent.CHANGED] = true;
        }

        override public function update(data:Object):Boolean
        {
            var updated:Boolean = updateNoEvent(data);
            if (updated)
            {
                eventsToDispatch[PlayerStateEvent.CHANGED] = true;
            }
            dispatchEvents();
            return updated;
        }

        public function updateNoEvent(data:Object):Boolean
        {
            var updated:Boolean = false;
            for (var key:String in data)
            {
                if (this[key] !== undefined && this[key] != data[key])
                {
                    updated = true;
                    var k:String = "set_" + key;
                    if (this[k] !== undefined)
                    {
                        this[k](data[key]);
                    }
                    else
                    {
                        this["_" + key] = data[key];
                    }
                }
            }
            return updated;
        }

        public function dispatchEvents():void
        {
            for (var eventName:String in eventsToDispatch)
            {
                Xvm.dispatchEvent(new PlayerStateEvent(eventName, vehicleID, accountDBID, playerName));
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
