package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BuildingsComponentVO extends DAAPIDataClass
    {
        
        public function BuildingsComponentVO(param1:Object)
        {
            this.buildingData = new Vector.<BuildingVO>();
            super(param1);
        }
        
        private static var BUILDING_DATA:String = "buildingData";
        
        public var isCommander:Boolean = false;
        
        public var buildingData:Vector.<BuildingVO>;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:BuildingVO = null;
            if(param1 == BUILDING_DATA)
            {
                for each(_loc3_ in param2)
                {
                    _loc4_ = new BuildingVO(_loc3_);
                    this.buildingData.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:BuildingVO = null;
            for each(_loc1_ in this.buildingData)
            {
                _loc1_.dispose();
            }
            this.buildingData.splice(0,this.buildingData.length);
            super.onDispose();
        }
    }
}
