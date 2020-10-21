package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class ResultRewardVO extends DAAPIDataClass
    {

        private static const EXP_TOOLTIP:String = "expTooltip";

        private static const CREDITS_TOOLTIP:String = "creditsTooltip";

        private static const FREE_X_P_TOOLTIP:String = "freeXPTooltip";

        public var credits:int = -1;

        public var exp:int = -1;

        public var freeXP:int = -1;

        public var expTooltip:ToolTipVO = null;

        public var creditsTooltip:ToolTipVO = null;

        public var freeXPTooltip:ToolTipVO = null;

        public function ResultRewardVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == EXP_TOOLTIP)
            {
                this.expTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == CREDITS_TOOLTIP)
            {
                this.creditsTooltip = new ToolTipVO(param2);
                return false;
            }
            if(param1 == FREE_X_P_TOOLTIP)
            {
                this.freeXPTooltip = new ToolTipVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.expTooltip != null)
            {
                this.expTooltip.dispose();
                this.expTooltip = null;
            }
            if(this.creditsTooltip != null)
            {
                this.creditsTooltip.dispose();
                this.creditsTooltip = null;
            }
            if(this.freeXPTooltip != null)
            {
                this.freeXPTooltip.dispose();
                this.freeXPTooltip = null;
            }
            super.onDispose();
        }
    }
}
