package com.xvm.battle.vo
{
    import com.xvm.vo.*;
    import flash.errors.*;
    import net.wg.data.constants.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class VOPlayerState extends VOMacrosOptions
    {
        // DAAPIVehicleInfoVO
        public var accountDBID : Number;
        public var clanAbbrev : String;
        public var invitationStatus : uint;
        public var isObserver : Boolean;
        public var isPlayerTeam : Boolean;
        public var isSpeaking : Boolean;
        public var isVehiclePremiumIgr : Boolean;
        public var playerFullName : String;
        public var playerName : String;
        public var playerStatus : uint;
        public var prebattleID : Number;
        public var region : String;
        private var _squadIndex : uint;
        public var teamColor : String;
        public var userTags : Array;
        public var vehicleAction : uint;
        public var vehicleGuiName : String;
        public var vehicleIcon : String;
        public var vehicleIconName : String;
        public var vehicleID : Number;
        public var vehicleLevel : int;
        public var vehicleName : String;
        public var vehicleStatus : uint;
        public var vehicleType : String;

        // DAAPIVehicleStatsVO
        public var frags : int = 0;

        // XVM
        public var marksOnGun : Number = NaN;       // TODO: set & update
        public var spottedStatus : String = null;   // TODO: set & update
        public var curHealth : Number = NaN;        // TODO: set & update
        public var maxHealth : Number = NaN;        // TODO: set & update
        public var entityName : String = null;      // TODO: set & update

        public var damageInfo : VODamageInfo;       // TODO: set & update

        public var hitlogCount : int = 0;           // TODO: set & update
        public var hitlogDamage : int = 0;          // TODO: set & update

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
            throw new IllegalOperationError("abstract method called");
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        override public function get position():Number
        {
            throw new IllegalOperationError("abstract method called");
        }

        override public function get vehicleData():VOVehicleData
        {
            return _vehicleData;
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
            vehicleID = d.vehicleID;
            vehicleLevel = d.vehicleLevel;
            vehicleName = d.vehicleName;
            vehicleStatus = d.vehicleStatus;
            vehicleType = d.vehicleType;
        }
    }
}
