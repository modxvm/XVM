package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class DirectionVO extends DAAPIDataClass
    {
        
        public function DirectionVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_BUILDINGS:String = "buildings";
        
        public var uid:int = -1;
        
        public var name:String = "";
        
        public var isOpened:Boolean = false;
        
        public var closeButtonVisible:Boolean = false;
        
        public var canBeClosed:Boolean = false;
        
        public var buildings:Array;
        
        public function get hasBuildings() : Boolean
        {
            return (this.buildings) && this.buildings.length > 0;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:BuildingVO = null;
            if(param1 == FIELD_BUILDINGS)
            {
                this.buildings = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new BuildingVO(_loc4_);
                    this.buildings.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeBuildings();
            super.onDispose();
        }
        
        private function disposeBuildings() : void
        {
            var _loc1_:BuildingVO = null;
            if(this.buildings)
            {
                for each(_loc1_ in this.buildings)
                {
                    _loc1_.dispose();
                }
                this.buildings.splice(0);
                this.buildings = null;
            }
        }
    }
}
