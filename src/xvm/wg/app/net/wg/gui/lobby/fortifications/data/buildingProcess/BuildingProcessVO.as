package net.wg.gui.lobby.fortifications.data.buildingProcess
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BuildingProcessVO extends DAAPIDataClass
    {
        
        public function BuildingProcessVO(param1:Object)
        {
            this.listItems = [];
            super(param1);
        }
        
        private static var LIST_ITEMS:String = "listItems";
        
        public var windowTitle:String = "";
        
        public var availableCount:String = "";
        
        public var listItems:Array;
        
        public var textInfo:String = "";
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:uint = 0;
            var _loc5_:uint = 0;
            var _loc6_:BuildingProcessListItemVO = null;
            if(param1 == LIST_ITEMS)
            {
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc6_ = new BuildingProcessListItemVO(_loc3_[_loc5_]);
                    this.listItems.push(_loc6_);
                    _loc5_++;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:BuildingProcessListItemVO = null;
            for each(_loc1_ in this.listItems)
            {
                _loc1_.dispose();
            }
            this.listItems.splice(0,this.listItems.length);
            this.listItems = null;
            this.windowTitle = null;
            this.availableCount = null;
            super.onDispose();
        }
    }
}
