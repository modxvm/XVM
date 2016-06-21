package com.xvm.battle.vo
{
    import com.xvm.vo.*;
    import net.wg.data.constants.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class VehicleInfoVO extends MacrosOptionsVO
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
        public var squadIndex : uint;
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

        public var damageInfo : DamageInfoVO;       // TODO: set & update

        public var hitlogCount : int = 0;           // TODO: set & update
        public var hitlogDamage : int = 0;          // TODO: set & update

        // IMacrosOptionsVO implementation

        public function get isAlive():Boolean
        {
            return VehicleStatus.isAlive(vehicleStatus);
        }

        public function get isReady():Boolean
        {
            return VehicleStatus.isReady(vehicleStatus);
        }

        public function get isDead():Boolean
        {
            return !isAlive;
        }

        public function get isNotAvailable():Boolean
        {
            return VehicleStatus.isNotAvailable(vehicleStatus);
        }

        public function get isStopRespawn():Boolean
        {
            return VehicleStatus.isStopRespawn(vehicleStatus);
        }

        public function get isActionDisabled():Boolean
        {
            return PlayerStatus.isActionDisabled(playerStatus);
        }

        public function get isSelected():Boolean
        {
            return PlayerStatus.isSelected(playerStatus);
        }

        public function get isSquadPersonal():Boolean
        {
            return PlayerStatus.isSquadMan(playerStatus);
        }

        public function get isSquadPersonal():Boolean
        {
            return PlayerStatus.isSquadPersonal(playerStatus);
        }

        public function get isTeamKiller():Boolean
        {
            return PlayerStatus.isTeamKiller(playerStatus);
        }

        public function get isVoipDisabled():Boolean
        {
            return PlayerStatus.isVoipDisabled(playerStatus);
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

        public function VehicleInfoVO(data:IDAAPIDataClass, isEnemy:Boolean)
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
            squadIndex = d.squadIndex;
            teamColor = d.teamColor;
            if(this.userTags)
            {
                _loc1_.userTags = this.userTags.concat();
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
