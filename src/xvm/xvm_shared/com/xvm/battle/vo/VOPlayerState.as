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
        // TODO: change to properties
        // DAAPIVehicleInfoVO
        public var accountDBID:Number;
        public var clanAbbrev:String;
        public var invitationStatus:uint;
        public var isObserver:Boolean;
        public var isSpeaking:Boolean;
        public var isVehiclePremiumIgr:Boolean;
        public var playerFullName:String;
        private var _playerName:String;
        private var _playerStatus:uint;
        public var prebattleID:Number;
        public var region:String;
        private var _squadIndex:uint;
        public var teamColor:String;
        public var userTags:Array;
        public var vehicleAction:uint;
        public var vehicleGuiName:String;
        public var vehicleIcon:String;
        public var vehicleIconName:String;
        private var _vehicleID:Number;
        //public var vehicleLevel:int;
        //public var vehicleName:String;
        private var _vehicleStatus:uint;
        //public var vehicleType:String;
        private var _isAlly:Boolean;
        private var _isBlown:Boolean;

        // DAAPIVehicleStatsVO
        private var _frags:int = 0;

        // XVM
        public var marksOnGun:Number = NaN;       // TODO: set & update
        public var spottedStatus:String = null;   // TODO: set & update
        public var _curHealth:Number = NaN;       // TODO: set & update
        public var _maxHealth:Number = NaN;       // TODO: set & update

        public var damageInfo:VODamageInfo;       // TODO: set & update
        public var xmqpData:VOXmqpData;           // TODO: set & update

        public var hitlogCount:int = 0;           // TODO: set & update
        public var hitlogDamage:int = 0;          // TODO: set & update

        private var _position:Number = NaN;
        private var _vehCD:int;
        private var _vehicleData:VOVehicleData;

        // IMacrosOptionsVO implementation

        override public function get vehicleID():Number
        {
            return _vehicleID;
        }

        public function set vehicleID(value:Number):void
        {
            _vehicleID = value;
        }

        override public function get playerName():String
        {
            return _playerName;
        }

        public function set playerName(value:String):void
        {
            _playerName = value;
        }

        override public function get isAlly():Boolean
        {
            return _isAlly;
        }

        public function set isAlly(value:Boolean):void
        {
            _isAlly = value;
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
            return UserTags.isBusy(userTags);
        }

        public function get isChatBan():Boolean
        {
            return UserTags.isChatBan(userTags);
        }

        public function get isFriend():Boolean
        {
            return UserTags.isFriend(userTags);
        }

        public function get isIgnored():Boolean
        {
            return UserTags.isIgnored(userTags);
        }

        public function get isMuted():Boolean
        {
            return UserTags.isMuted(userTags);
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        public function set squadIndex(value:Number):void
        {
            if (_squadIndex != value)
            {
                _squadIndex = value;
                dispatchPlayerStateChangedEvent();
            }
        }

        override public function get position():Number
        {
            return _position;
        }

        public function set position(value:Number):void
        {
            if (_position != value)
            {
                _position = value;
                dispatchPlayerStateChangedEvent();
            }
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
            return _vehicleStatus;
        }

        public function set vehicleStatus(value:uint):void
        {
            if (_vehicleStatus != value)
            {
                var alive:Boolean = isAlive;
                _vehicleStatus = value;
                updateStatData();
                dispatchPlayerStateChangedEvent();
                if (alive && isDead)
                {
                    Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.PLAYER_DEAD, vehicleID, accountDBID, playerName));
                }
            }
        }

        public function get playerStatus():uint
        {
            return _playerStatus;
        }

        public function set playerStatus(value:uint):void
        {
            if (_playerStatus != value)
            {
                _playerStatus = value;
            }
        }

        public function get frags():int
        {
            return _frags;
        }

        public function set frags(value:int):void
        {
            if (_frags != value)
            {
                _frags = value;
                if (isCurrentPlayer)
                    BattleState.playerFrags = value;
                dispatchPlayerStateChangedEvent();
            }
        }

        // helpers

        public function getSpottedStatus():String
        {
            return isDead ? "dead" : spottedStatus == null ? "neverSeen" : spottedStatus;
        }

        public function getCurrentHealth():Number
        {
            return isAlive ? curHealth : 0;
        }

        public function get isBlown():Boolean
        {
            return _isBlown;
        }

        public function set isBlown(value:Boolean):void
        {
            _isBlown = value;
        }

        public function get curHealth():Number
        {
            return _curHealth;
        }

        public function set curHealth(value:Number):void
        {
            if (value < 0)
            {
                isBlown = true;
                value = 0;
            }
            if (_curHealth != value)
            {
                _curHealth = value;
                dispatchPlayerStateChangedEvent();
            }
        }

        public function get maxHealth():Number
        {
            return _maxHealth;
        }

        public function set maxHealth(value:Number):void
        {
            if (_maxHealth != value)
            {
                _maxHealth = value;
                dispatchPlayerStateChangedEvent();
            }
        }

        public function VOPlayerState(data:Object = null)
        {
            if (!data)
                return;
            accountDBID = data.accountDBID;
            clanAbbrev = data.clanAbbrev;
            invitationStatus = data.invitationStatus;
            isObserver = data.isObserver;
            isSpeaking = data.isSpeaking;
            isVehiclePremiumIgr = data.isVehiclePremiumIgr;
            playerFullName = data.playerFullName;
            playerName = data.playerName;
            playerStatus = data.playerStatus;
            prebattleID = data.prebattleID;
            region = data.region;
            _squadIndex = data.squadIndex;
            teamColor = data.teamColor;
            if (data.userTags)
            {
                userTags = data.userTags.concat();
            }
            vehicleAction = data.vehicleAction;
            vehicleGuiName = data.vehicleGuiName;
            vehicleIcon = data.vehicleIcon;
            vehicleIconName = data.vehicleIconName;
            vehicleID = data.vehicleID;
            //vehicleLevel = data.vehicleLevel;
            //vehicleName = data.vehicleName;
            //vehicleType = data.vehicleType;

            vehicleStatus = data.vehicleStatus;

            // TODO: refactor
            _vehicleData = VehicleInfo.getByLocalizedShortName(data.vehicleName);
            if (_vehicleData)
            {
                _vehCD = _vehicleData.vehCD;
            }

            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);

            dispatchPlayerStateChangedEvent();
        }

        private function dispatchPlayerStateChangedEvent():void
        {
            Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.PLAYER_STATE_CHANGED, vehicleID, accountDBID, playerName));
        }

        override public function update(data:Object):Boolean
        {
            var updated:Boolean = super.update(data);
            if (updated)
            {
                dispatchPlayerStateChangedEvent();
            }
            return updated;
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e.result)
            {
                var len:int = e.result.length;
                for (var i:int = 0; i < len; ++i)
                {
                    if (e.result[i] == playerName)
                    {
                        updateStatData();
                        break;
                    }
                }
                dispatchPlayerStateChangedEvent();
            }
        }

        private function updateStatData():void
        {
            var sd:StatData = Stat.battleStat[playerName];
            if (sd)
            {
                sd.alive = isAlive;
            }
        }
    }
}
