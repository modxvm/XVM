package net.wg.gui.utils.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class PriceVO extends DAAPIDataClass
    {
        
        public function PriceVO(param1:Object)
        {
            super(param1);
        }
        
        private var _priceFull:Array = null;
        
        public var price:uint = 0.0;
        
        public var isGold:Boolean = false;
        
        override public function fromHash(param1:Object) : void
        {
            if(param1 is Array)
            {
                this.priceFull = param1 as Array;
            }
            else
            {
                super.fromHash(param1);
            }
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "price")
            {
                this.priceFull = param2 as Array;
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get priceFull() : Array
        {
            return this._priceFull;
        }
        
        public function set priceFull(param1:Array) : void
        {
            this._priceFull = param1;
            this.isGold = this.priceFull[1] > 0;
            this.price = this.isGold?this.priceFull[1]:this.priceFull[0];
        }
    }
}
