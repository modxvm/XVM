package net.wg.gui.lobby.eventStylesTrade.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class SkinVO extends ToolTipVO
    {

        private static const REWARD_TOOLTIP:String = "rewardTooltip";

        private static const STYLE_TOOLTIP:String = "styleTooltip";

        public var name:String = "";

        public var price:int = -1;

        public var notEnoughCount:int = -1;

        public var currency:String = "";

        public var haveInStorage:Boolean = false;

        public var hasReward:Boolean = false;

        public var haveTank:Boolean = false;

        public var buyButtonEnabled:Boolean = false;

        public var image:String = "";

        public var suitableTank:String = "";

        public var bonus:String = "";

        public var rewardIcon:String = "";

        public var styleTitle:String = "";

        public var styleDescription:String = "";

        public var isShowAuthorImage:Boolean = true;

        public var header:String = "";

        public var description:String = "";

        private var _rewardTooltip:ToolTipVO = null;

        private var _styleTooltip:ToolTipVO = null;

        public function SkinVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this._rewardTooltip)
            {
                this._rewardTooltip.dispose();
                this._rewardTooltip = null;
            }
            if(this._styleTooltip)
            {
                this._styleTooltip.dispose();
                this._styleTooltip = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == REWARD_TOOLTIP)
            {
                this._rewardTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == STYLE_TOOLTIP)
            {
                this._styleTooltip = new ToolTipVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        public function get styleTooltip() : ToolTipVO
        {
            return this._styleTooltip;
        }

        public function get rewardTooltip() : ToolTipVO
        {
            return this._rewardTooltip;
        }
    }
}
