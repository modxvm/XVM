package net.wg.gui.lobby.hangar.maintenance.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HistoricalAmmoVO extends DAAPIDataClass
    {
        
        public function HistoricalAmmoVO(param1:Object)
        {
            super(param1);
        }
        
        private static var SHELLS_FIELD:String = "shells";
        
        public var price:String = "";
        
        public var shells:Array = null;
        
        public var battleID:int = -1;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:ShellVO = null;
            if(param1 == SHELLS_FIELD)
            {
                this.shells = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new ShellVO(_loc4_);
                    this.shells.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeShells();
            super.onDispose();
        }
        
        private function disposeShells() : void
        {
            var _loc1_:ShellVO = null;
            if(this.shells)
            {
                for each(_loc1_ in this.shells)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.shells.splice(0);
                this.shells = null;
            }
        }
    }
}
