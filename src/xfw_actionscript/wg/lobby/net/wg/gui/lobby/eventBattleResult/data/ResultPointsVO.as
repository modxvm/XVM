package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class ResultPointsVO extends DAAPIDataClass
    {

        private static const BONUS_TOOLTIP:String = "bonusTooltip";

        public var points:int = -1;

        public var withoutBonus:int = -1;

        public var isBonus:Boolean = false;

        public var bonusIcon:String = "";

        public var bonusText:String = "";

        public var bonusTextMin:String = "";

        public var bonusTooltip:ToolTipVO = null;

        public function ResultPointsVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this.bonusTooltip)
            {
                this.bonusTooltip.dispose();
                this.bonusTooltip = null;
            }
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == BONUS_TOOLTIP)
            {
                this.bonusTooltip = new ToolTipVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
