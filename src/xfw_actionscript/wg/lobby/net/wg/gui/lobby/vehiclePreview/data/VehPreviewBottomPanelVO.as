package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.data.VehCompareEntrypointVO;

    public class VehPreviewBottomPanelVO extends DAAPIDataClass
    {

        private static const VEH_COMPARE_DATA_FIELD_NAME:String = "vehCompareData";

        public var buyingLabel:String = "";

        public var isCanTrade:Boolean = false;

        public var isBuyingAvailable:Boolean = false;

        public var showStatusInfoTooltip:Boolean = false;

        public var vehicleId:Number = -1;

        public var vehCompareVO:VehCompareEntrypointVO = null;

        public var vehCompareIcon:String = "";

        public function VehPreviewBottomPanelVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == VEH_COMPARE_DATA_FIELD_NAME)
            {
                this.clearVehCompareVO();
                this.vehCompareVO = new VehCompareEntrypointVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            this.clearVehCompareVO();
            super.onDispose();
        }

        private function clearVehCompareVO() : void
        {
            if(this.vehCompareVO != null)
            {
                this.vehCompareVO.dispose();
                this.vehCompareVO = null;
            }
        }
    }
}
