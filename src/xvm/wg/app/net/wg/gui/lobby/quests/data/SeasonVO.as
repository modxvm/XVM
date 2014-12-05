package net.wg.gui.lobby.quests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class SeasonVO extends DAAPIDataClass
    {
        
        public function SeasonVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_TILES:String = "tiles";
        
        public var id:Number = -1;
        
        public var title:String = "";
        
        public var tiles:Array = null;
        
        public function hasTiles() : Boolean
        {
            return (this.tiles) && this.tiles.length > 0;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:SeasonTileVO = null;
            if(param1 == FIELD_TILES)
            {
                this.tiles = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = _loc4_?new SeasonTileVO(_loc4_):null;
                    this.tiles.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeTiles();
            super.onDispose();
        }
        
        private function disposeTiles() : void
        {
            var _loc1_:SeasonTileVO = null;
            if(this.tiles)
            {
                for each(_loc1_ in this.tiles)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.tiles.splice(0);
                this.tiles = null;
            }
        }
    }
}
