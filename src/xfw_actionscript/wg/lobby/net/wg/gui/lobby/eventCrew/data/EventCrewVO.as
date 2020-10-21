package net.wg.gui.lobby.eventCrew.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.data.DataProvider;

    public class EventCrewVO extends ToolTipVO
    {

        private static const BONUSES:String = "bonuses";

        public var header:String = "";

        public var label:String = "";

        public var icon:String = "";

        public var progressCurrent:int = -1;

        public var progressTotal:int = -1;

        public var bonuses:DataProvider = null;

        public var healingTimeLeft:String = "";

        public var showPremiumInfo:Boolean = false;

        public var isSick:Boolean = false;

        public var isPremium:Boolean = false;

        public function EventCrewVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == BONUSES)
            {
                this.bonuses = new DataProvider();
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this.bonuses.push(new EventBonusItemVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:EventBonusItemVO = null;
            for each(_loc1_ in this.bonuses)
            {
                _loc1_.dispose();
            }
            this.bonuses.cleanUp();
            this.bonuses = null;
            super.onDispose();
        }
    }
}
