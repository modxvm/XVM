package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ResultMissionRewardVO extends DAAPIDataClass
    {

        private static const TOOLTIP_DATA:String = "tooltipData";

        private static const REWARDS:String = "rewards";

        private static const TANK:String = "tank";

        public var isCommander:Boolean = false;

        public var isCrew:Boolean = false;

        public var isWulfTooltip:Boolean = false;

        public var description:String = "";

        public var iconCrew:String = "";

        public var iconLevel:String = "";

        public var progressDelta:int = -1;

        public var header:String = "";

        public var progressLabel:String = "";

        public var completeLabel:String = "";

        public var progressTotal:int = -1;

        public var progressCurrent:int = -1;

        public var progressNewCurrent:int = -1;

        public var progress:int = -1;

        private var _tooltipData:ToolTipVO = null;

        private var _rewards:DataProvider;

        private var _tank:RewardItemVO = null;

        public function ResultMissionRewardVO(param1:Object)
        {
            this._rewards = new DataProvider();
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == REWARDS)
            {
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._rewards.push(new RewardItemVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            if(param1 == TANK)
            {
                this._tank = new RewardItemVO(param2);
                return false;
            }
            if(param1 == TOOLTIP_DATA)
            {
                this._tooltipData = new ToolTipVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        public function get tooltipData() : ToolTipVO
        {
            return this._tooltipData;
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._rewards)
            {
                _loc1_.dispose();
            }
            this._rewards.cleanUp();
            this._rewards = null;
            if(this._tooltipData != null)
            {
                this._tooltipData.dispose();
                this._tooltipData = null;
            }
            if(this._tank != null)
            {
                this._tank.dispose();
                this._tank = null;
            }
            super.onDispose();
        }

        public function get rewards() : DataProvider
        {
            return this._rewards;
        }

        public function get tank() : RewardItemVO
        {
            return this._tank;
        }
    }
}
