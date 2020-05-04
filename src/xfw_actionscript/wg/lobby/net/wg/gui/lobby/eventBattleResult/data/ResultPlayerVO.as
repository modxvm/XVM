package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import net.wg.data.constants.VehicleTypes;
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class ResultPlayerVO extends TeamMemberItemVO
    {

        private static const TOOLTIP_DATA:String = "tooltipData";

        private static const TANK_TYPE_SORT:Array = [VehicleTypes.HEAVY_TANK,VehicleTypes.MEDIUM_TANK,VehicleTypes.LIGHT_TANK,VehicleTypes.AT_SPG];

        public var tankType:String = "";

        public var generalLevel:int = 0;

        public var assist:int = 0;

        public var armor:int = 0;

        public var friendSent:Boolean = false;

        public var squadSent:Boolean = false;

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

        public function get tankTypeSortIndex() : int
        {
            return TANK_TYPE_SORT.indexOf(this.tankType);
        }
    }
}
