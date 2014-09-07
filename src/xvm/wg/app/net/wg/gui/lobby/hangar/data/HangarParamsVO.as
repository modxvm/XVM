package net.wg.gui.lobby.hangar.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HangarParamsVO extends DAAPIDataClass
    {
        
        public function HangarParamsVO(param1:Object)
        {
            super(param1);
        }
        
        private var _params:Array = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            if(param1 == "params")
            {
                this._params = [];
                for each(_loc3_ in param2)
                {
                    this._params.push(new HangarParamVO(_loc3_));
                }
            }
            return false;
        }
        
        public function get params() : Array
        {
            return this._params;
        }
        
        public function set params(param1:Array) : void
        {
            this._params = param1;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:HangarParamVO = null;
            for each(_loc1_ in this._params)
            {
                _loc1_.dispose();
            }
            this._params.splice(0,this._params.length);
            this._params = null;
            super.onDispose();
        }
    }
}
