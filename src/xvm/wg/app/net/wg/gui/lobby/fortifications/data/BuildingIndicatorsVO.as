package net.wg.gui.lobby.fortifications.data
{
    public class BuildingIndicatorsVO extends BuildingPopoverBaseVO
    {
        
        public function BuildingIndicatorsVO(param1:Object) {
            super(param1);
        }
        
        private static var HP_PROGRESS_LABELS:String = "hpProgressLabels";
        
        private static var DEFRES_PROGRESS_LABELS:String = "defResProgressLabels";
        
        public var hpLabel:String = "";
        
        public var defResLabel:String = "";
        
        public var hpCurrentValue:int = -1;
        
        public var hpTotalValue:int = -1;
        
        public var defResCurrentValue:int = -1;
        
        public var defResTotalValue:int = -1;
        
        public var hpProgressLabels:BuildingProgressLblVO;
        
        public var defResProgressLabels:BuildingProgressLblVO;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            if(param1 == HP_PROGRESS_LABELS)
            {
                this.hpProgressLabels = new BuildingProgressLblVO(param2);
                return false;
            }
            if(param1 == DEFRES_PROGRESS_LABELS)
            {
                this.defResProgressLabels = new BuildingProgressLblVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
