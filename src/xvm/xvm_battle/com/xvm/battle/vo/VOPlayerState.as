package com.xvm.battle.vo
{
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.vo.*;
    import com.xvm.types.stat.*;
    import flash.errors.*;
    import net.wg.data.constants.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public class VOPlayerState extends VOMacrosOptions
    {
        // DAAPIVehicleInfoVO
        public var accountDBID:Number;
        public var clanAbbrev:String;
        public var invitationStatus:uint;
        public var isObserver:Boolean;
        public var isPlayerTeam:Boolean;
        public var isSpeaking:Boolean;
        public var isVehiclePremiumIgr:Boolean;
        public var playerFullName:String;
        public var playerName:String;
        public var playerStatus:uint;
        public var prebattleID:Number;
        public var region:String;
        private var _squadIndex:uint;
        public var teamColor:String;
        public var userTags:Array;
        public var vehicleAction:uint;
        public var vehicleGuiName:String;
        public var vehicleIcon:String;
        public var vehicleIconName:String;
        public var vehicleArenaID:Number;
        public var vehicleLevel:int;
        public var vehicleName:String;
        private var _vehicleStatus:uint;
        public var vehicleType:String;

        // DAAPIVehicleStatsVO
        public var frags:int = 0;

        // XVM
        public var marksOnGun:Number = NaN;       // TODO: set & update
        public var spottedStatus:String = null;   // TODO: set & update
        public var curHealth:Number = NaN;        // TODO: set & update
        public var maxHealth:Number = NaN;        // TODO: set & update
        public var entityName:String = null;      // TODO: set & update, is required?
        public var entryName:String = null;       // TODO: set & update, is required?

        public var damageInfo:VODamageInfo;       // TODO: set & update
        public var xmqpData:VOXmqpData;           // TODO: set & update

        public var hitlogCount:int = 0;           // TODO: set & update
        public var hitlogDamage:int = 0;          // TODO: set & update

        private var _position:Number = NaN;
        private var _vehID:int;
        private var _vehicleData:VOVehicleData;

        // IMacrosOptionsVO implementation

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
            return UserTags.isCurrentPlayer(userTags);
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

        override public function get position():Number
        {
            return _position;
        }

        public function set position(value:Number):void
        {
            _position = value;
        }

        override public function get vehID():int
        {
            return _vehID;
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
            _vehicleStatus = value;
            updateStatData();
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
            return curHealth < 0;
        }

        override public function VOPlayerState(data:IDAAPIDataClass, isEnemy:Boolean)
        {
            var d:DAAPIVehicleInfoVO = DAAPIVehicleInfoVO(data);
            accountDBID = d.accountDBID;
            clanAbbrev = d.clanAbbrev;
            invitationStatus = d.invitationStatus;
            isObserver = d.isObserver;
            isPlayerTeam = d.isPlayerTeam;
            isSpeaking = d.isSpeaking;
            isVehiclePremiumIgr = d.isVehiclePremiumIgr;
            playerFullName = d.playerFullName;
            playerName = d.playerName;
            playerStatus = d.playerStatus;
            prebattleID = d.prebattleID;
            region = d.region;
            _squadIndex = d.squadIndex;
            teamColor = d.teamColor;
            if (d.userTags)
            {
                userTags = d.userTags.concat();
            }
            vehicleAction = d.vehicleAction;
            vehicleGuiName = d.vehicleGuiName;
            vehicleIcon = d.vehicleIcon;
            vehicleIconName = d.vehicleIconName;
            vehicleArenaID = d.vehicleID;
            vehicleLevel = d.vehicleLevel;
            vehicleName = d.vehicleName;
            vehicleType = d.vehicleType;

            vehicleStatus = d.vehicleStatus;

            // TODO: refactor
            _vehicleData = VehicleInfo.getByLocalizedShortName(vehicleName);
            if (_vehicleData)
            {
                _vehID = _vehicleData.vehId;
            }

            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);
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
