package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
    
    public class ToolTipFortBuildingInfoVO extends DAAPIDataClass
    {
        
        public function ToolTipFortBuildingInfoVO(param1:Object)
        {
            super(param1);
        }
        
        private static var INDICATOR_MODEL:String = "indicatorModel";
        
        public var indicatorModel:BuildingIndicatorsVO = null;
        
        public var buildingName:String = "";
        
        public var currentMap:String = "";
        
        public var buildingLevel:String = "";
        
        public var descrAction:String = "";
        
        public var statusMsg:String = "";
        
        public var statusLevel:String = "";
        
        public var buildingUID:String = "";
        
        public var infoMessage:String = "";
        
        public var isAvailable:Boolean = false;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == INDICATOR_MODEL && !(param2 == null))
            {
                this.indicatorModel = new BuildingIndicatorsVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            if(this.indicatorModel)
            {
                this.indicatorModel.dispose();
                this.indicatorModel = null;
            }
            this.buildingName = null;
            this.currentMap = null;
            this.buildingLevel = null;
            this.descrAction = null;
            this.statusMsg = null;
            this.buildingUID = null;
            super.onDispose();
        }
    }
}
