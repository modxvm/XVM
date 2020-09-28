package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import net.wg.data.constants.generated.EVENT_CONSTS;
    import net.wg.data.constants.VehicleStatus;
    import net.wg.data.constants.PlayerStatus;

    public class DAAPIPlayerPanelInfoVO extends DAAPIDataClass
    {

        private static const BADGE_FIELD_NAME:String = "badgeVO";

        public var playerName:String = "";

        public var playerFakeName:String = "";

        public var playerFullName:String = "";

        public var playerStatus:uint = 0;

        public var clanAbbrev:String = "";

        public var region:String = "";

        public var squadIndex:uint = 0;

        public var invitationStatus:uint = 0;

        public var userTags:Array = null;

        public var vehID:uint = 0;

        public var sessionID:String = "";

        public var nameVehicle:String = "";

        public var typeVehicle:String = "";

        public var vehicleAction:uint = 0;

        public var vehicleStatus:uint = 0;

        public var isObserver:Boolean = false;

        public var hpMax:int = 0;

        public var hpCurrent:int = 0;

        public var isSquad:Boolean = false;

        public var isResurrect:Boolean = false;

        public var isPlayer:Boolean = false;

        public var isEnemy:Boolean = false;

        public var badgeVO:BadgeVisualVO = null;

        public var suffixBadgeIcon:String = "";

        public var countPoints:int = 0;

        public var countLives:int = 0;

        public var eventRole:int = 0;

        public var kills:int = 0;

        public function DAAPIPlayerPanelInfoVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == BADGE_FIELD_NAME)
            {
                this.badgeVO = new BadgeVisualVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.badgeVO)
            {
                this.badgeVO.dispose();
                this.badgeVO = null;
            }
            if(this.userTags)
            {
                this.userTags.splice(0,this.userTags.length);
                this.userTags = null;
            }
            super.onDispose();
        }

        public function get isBoss() : Boolean
        {
            return (this.eventRole & EVENT_CONSTS.BOSS) > 0;
        }

        public function get isHunter() : Boolean
        {
            return (this.eventRole & EVENT_CONSTS.HUNTER) > 0;
        }

        public function get isSpecialBoss() : Boolean
        {
            return (this.eventRole & EVENT_CONSTS.SPECIAL_BOSS) > 0;
        }

        public function isAlive() : Boolean
        {
            return (this.vehicleStatus & VehicleStatus.IS_ALIVE) > 0;
        }

        public function isNotAvailable() : Boolean
        {
            return (this.vehicleStatus & VehicleStatus.NOT_AVAILABLE) > 0;
        }

        public function isReady() : Boolean
        {
            return (this.vehicleStatus & VehicleStatus.IS_READY) > 0;
        }

        public function isSquadMan() : Boolean
        {
            return (this.playerStatus & PlayerStatus.IS_SQUAD_MAN) > 0;
        }

        public function isSquadPersonal() : Boolean
        {
            return (this.playerStatus & PlayerStatus.IS_SQUAD_PERSONAL) > 0;
        }

        public function isTeamKiller() : Boolean
        {
            return (this.playerStatus & PlayerStatus.IS_TEAM_KILLER) > 0;
        }

        public function get isAnonymized() : Boolean
        {
            return this.playerFakeName && this.playerFakeName != this.playerName;
        }
    }
}
