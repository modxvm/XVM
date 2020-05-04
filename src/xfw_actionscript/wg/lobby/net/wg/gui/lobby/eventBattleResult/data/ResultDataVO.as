package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ResultDataVO extends DAAPIDataClass
    {

        private static const CAPTURE_STATUS_FIELD:String = "captureStatus";

        private static const PLAYERS_FIELD:String = "players";

        private static const MISSIONS_FIELD:String = "missions";

        private static const COMMON_FIELD:String = "common";

        private static const KILLS_TOOLTIP:String = "killsTooltip";

        private static const DAMAGE_TOOLTIP:String = "damageTooltip";

        private static const ASSIST_TOOLTIP:String = "assistTooltip";

        private static const ARMOR_TOOLTIP:String = "armorTooltip";

        private static const ALLIES_KILLS_TOOLTIP:String = "alliesKillsTooltip";

        private static const ALLIES_DAMAGE_TOOLTIP:String = "alliesDamageTooltip";

        private static const ALLIES_ASSIST_TOOLTIP:String = "alliesAssistTooltip";

        private static const ALLIES_ARMOR_TOOLTIP:String = "alliesArmorTooltip";

        private static const ALLIES_VEHICLES_TOOLTIP:String = "alliesVehiclesTooltip";

        private static const PERSONAL_MISSION:String = "personalMission";

        private static const CREW_MISSION:String = "crewMission";

        private static const OBJECTIVES:String = "objectives";

        private static const POINTS:String = "points";

        private static const TANK_STATUS:String = "tankStatus";

        private static const GAME_STATUS:String = "gameStatus";

        public var captureStatus:ResultStatusVO = null;

        public var tankStatus:ResultBottomStatusVO = null;

        public var gameStatus:ResultBottomStatusVO = null;

        public var time:String = "";

        public var kills:int = -1;

        public var damage:int = -1;

        public var assist:int = -1;

        public var armor:int = -1;

        public var background:String = "";

        public var killsTooltip:ToolTipVO = null;

        public var damageTooltip:ToolTipVO = null;

        public var assistTooltip:ToolTipVO = null;

        public var armorTooltip:ToolTipVO = null;

        public var alliesKillsTooltip:ToolTipVO = null;

        public var alliesDamageTooltip:ToolTipVO = null;

        public var alliesAssistTooltip:ToolTipVO = null;

        public var alliesArmorTooltip:ToolTipVO = null;

        public var alliesVehiclesTooltip:ToolTipVO = null;

        public var players:DataProvider = null;

        public var objectives:ResultObjectivesVO = null;

        public var missions:DataProvider = null;

        public var personalMission:ResultMissionRewardVO = null;

        public var crewMission:ResultMissionRewardVO = null;

        public var points:ResultPointsVO = null;

        public var common:CommonStatsVO = null;

        public var maxValues:ResultMaxValuesVO = null;

        public function ResultDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            this.captureStatus.dispose();
            this.captureStatus = null;
            for each(_loc1_ in this.players)
            {
                _loc1_.dispose();
            }
            this.players.cleanUp();
            this.players = null;
            for each(_loc1_ in this.missions)
            {
                _loc1_.dispose();
            }
            if(this.missions)
            {
                this.missions.cleanUp();
                this.missions = null;
            }
            if(this.objectives)
            {
                this.objectives.dispose();
                this.objectives = null;
            }
            this.common.dispose();
            this.common = null;
            if(this.damageTooltip)
            {
                this.damageTooltip.dispose();
                this.damageTooltip = null;
            }
            if(this.killsTooltip)
            {
                this.killsTooltip.dispose();
                this.killsTooltip = null;
            }
            if(this.assistTooltip)
            {
                this.assistTooltip.dispose();
                this.assistTooltip = null;
            }
            if(this.armorTooltip)
            {
                this.armorTooltip.dispose();
                this.armorTooltip = null;
            }
            if(this.alliesDamageTooltip)
            {
                this.alliesDamageTooltip.dispose();
                this.alliesDamageTooltip = null;
            }
            if(this.alliesKillsTooltip)
            {
                this.alliesKillsTooltip.dispose();
                this.alliesKillsTooltip = null;
            }
            if(this.alliesAssistTooltip)
            {
                this.alliesAssistTooltip.dispose();
                this.alliesAssistTooltip = null;
            }
            if(this.alliesArmorTooltip)
            {
                this.alliesArmorTooltip.dispose();
                this.alliesArmorTooltip = null;
            }
            if(this.alliesVehiclesTooltip)
            {
                this.alliesVehiclesTooltip.dispose();
                this.alliesVehiclesTooltip = null;
            }
            if(this.crewMission != null)
            {
                this.crewMission.dispose();
                this.crewMission = null;
            }
            if(this.personalMission != null)
            {
                this.personalMission.dispose();
                this.personalMission = null;
            }
            if(this.points != null)
            {
                this.points.dispose();
                this.points = null;
            }
            this.tankStatus.dispose();
            this.tankStatus = null;
            this.gameStatus.dispose();
            this.gameStatus = null;
            this.maxValues = null;
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:ResultPlayerVO = null;
            if(param1 == COMMON_FIELD)
            {
                this.common = new CommonStatsVO(param2);
                return false;
            }
            if(param1 == CAPTURE_STATUS_FIELD)
            {
                this.captureStatus = new ResultStatusVO(param2);
                return false;
            }
            if(param1 == OBJECTIVES)
            {
                this.objectives = new ResultObjectivesVO(param2);
                return false;
            }
            if(param1 == MISSIONS_FIELD)
            {
                this.missions = new DataProvider();
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this.missions.push(new ResultMissionRewardVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            if(param1 == PLAYERS_FIELD)
            {
                this.players = new DataProvider();
                this.maxValues = new ResultMaxValuesVO();
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc6_ = new ResultPlayerVO(_loc3_[_loc5_]);
                    this.players.push(_loc6_);
                    if(_loc6_.armor > this.maxValues.armor)
                    {
                        this.maxValues.armor = _loc6_.armor;
                    }
                    if(_loc6_.assist > this.maxValues.assist)
                    {
                        this.maxValues.assist = _loc6_.assist;
                    }
                    if(_loc6_.damageDealt > this.maxValues.damageDealt)
                    {
                        this.maxValues.damageDealt = _loc6_.damageDealt;
                    }
                    if(_loc6_.kills > this.maxValues.kills)
                    {
                        this.maxValues.kills = _loc6_.kills;
                    }
                    _loc5_++;
                }
                return false;
            }
            if(param1 == CREW_MISSION)
            {
                this.crewMission = new ResultMissionRewardVO(param2);
                return false;
            }
            if(param1 == PERSONAL_MISSION)
            {
                this.personalMission = new ResultMissionRewardVO(param2);
                return false;
            }
            if(param1 == DAMAGE_TOOLTIP)
            {
                this.damageTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == KILLS_TOOLTIP)
            {
                this.killsTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ASSIST_TOOLTIP)
            {
                this.assistTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ARMOR_TOOLTIP)
            {
                this.armorTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ALLIES_DAMAGE_TOOLTIP)
            {
                this.alliesDamageTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ALLIES_KILLS_TOOLTIP)
            {
                this.alliesKillsTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ALLIES_ASSIST_TOOLTIP)
            {
                this.alliesAssistTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ALLIES_ARMOR_TOOLTIP)
            {
                this.alliesArmorTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == ALLIES_VEHICLES_TOOLTIP)
            {
                this.alliesVehiclesTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == POINTS)
            {
                this.points = new ResultPointsVO(param2);
                return false;
            }
            if(param1 == TANK_STATUS)
            {
                this.tankStatus = new ResultBottomStatusVO(param2);
                return false;
            }
            if(param1 == GAME_STATUS)
            {
                this.gameStatus = new ResultBottomStatusVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
