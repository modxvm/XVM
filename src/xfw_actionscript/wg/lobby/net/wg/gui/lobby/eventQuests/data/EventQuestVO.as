package net.wg.gui.lobby.eventQuests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class EventQuestVO extends DAAPIDataClass
    {

        private static const TOOLTIP_DATA:String = "tooltipData";

        public var header:String = "";

        public var progressTotal:int = -1;

        public var progressCurrent:int = -1;

        public var progressNewCurrent:int = -1;

        public var progress:int = -1;

        public var icon:String = "";

        public var status:String = "";

        public var completed:Boolean = false;

        private var _tooltipData:ToolTipVO = null;

        public function EventQuestVO(param1:Object)
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
