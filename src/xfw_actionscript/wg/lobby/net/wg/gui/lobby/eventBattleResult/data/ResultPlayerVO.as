package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class ResultPlayerVO extends TeamMemberItemVO
    {

        private static const TOOLTIP_DATA:String = "tooltipData";

        public var tankType:String = "";

        public var matter:int = 0;

        public var matterOnTank:int = 0;

        public var banStatus:String = "";

        public var banStatusTooltip:String = "";

        private var _tooltipData:ToolTipVO = null;

        public function ResultPlayerVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
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
            if(this._tooltipData != null)
            {
                this._tooltipData.dispose();
                this._tooltipData = null;
            }
            super.onDispose();
        }
    }
}
