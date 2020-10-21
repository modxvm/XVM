package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ResultDataVO extends DAAPIDataClass
    {

        private static const PLAYERS_FIELD:String = "players";

        private static const REWARD_FIELD:String = "reward";

        private static const MISSIONS_FIELD:String = "missions";

        private static const COMMON_FIELD:String = "common";

        private static const MATTER_TOOLTIP:String = "matterTooltip";

        private static const MATTER_ON_TANK_TOOLTIP:String = "matterOnTankTooltip";

        private static const DAMAGE_TOOLTIP:String = "damageTooltip";

        private static const KILLS_TOOLTIP:String = "killsTooltip";

        public var captureStatus:String = "";

        public var tankType:String = "";

        public var tankName:String = "";

        public var deathReason:int = -1;

        public var time:String = "";

        public var matterOnTank:int = -1;

        public var matter:int = -1;

        public var kills:int = -1;

        public var damage:int = -1;

        public var background:String = "";

        public var matterTooltip:ToolTipVO = null;

        public var matterOnTankTooltip:ToolTipVO = null;

        public var damageTooltip:ToolTipVO = null;

        public var killsTooltip:ToolTipVO = null;

        public var players:DataProvider = null;

        public var reward:ResultRewardVO = null;

        public var missions:DataProvider = null;

        public var common:CommonStatsVO = null;

        public var friends:Array = null;

        public function ResultDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
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
            this.missions.cleanUp();
            this.missions = null;
            this.reward.dispose();
            this.reward = null;
            this.common.dispose();
            this.common = null;
            this.matterTooltip.dispose();
            this.matterTooltip = null;
            this.matterOnTankTooltip.dispose();
            this.matterOnTankTooltip = null;
            this.damageTooltip.dispose();
            this.damageTooltip = null;
            this.killsTooltip.dispose();
            this.killsTooltip = null;
            if(this.friends != null)
            {
                this.friends.splice(0,this.friends.length);
                this.friends = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == REWARD_FIELD)
            {
                this.reward = new ResultRewardVO(param2);
                return false;
            }
            if(param1 == COMMON_FIELD)
            {
                this.common = new CommonStatsVO(param2);
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
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this.players.push(new ResultPlayerVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            if(param1 == MATTER_TOOLTIP)
            {
                this.matterTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == MATTER_ON_TANK_TOOLTIP)
            {
                this.matterOnTankTooltip = new ToolTipVO(param2);
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
            return super.onDataWrite(param1,param2);
        }
    }
}
