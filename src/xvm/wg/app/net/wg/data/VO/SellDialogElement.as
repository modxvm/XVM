package net.wg.data.VO
{
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class SellDialogElement extends Object
    {
        
        public function SellDialogElement()
        {
            super();
        }
        
        private var _id:String;
        
        private var _isRemovable:Boolean;
        
        private var _intCD:Number;
        
        private var _count:Number = 1;
        
        private var _toInventory:Boolean;
        
        private var _fromInventory:Boolean = false;
        
        private var _kind:String = "";
        
        private var _type:String;
        
        private var _moneyValue:Number;
        
        private var _removePrice:Number;
        
        private var _removeActionPriceVo:ActionPriceVO = null;
        
        private var _sellActionPriceVo:ActionPriceVO = null;
        
        public var _sellExternalData:Array = null;
        
        public function get removePrice() : Number
        {
            return this._removePrice;
        }
        
        public function set removePrice(param1:Number) : void
        {
            this._removePrice = param1;
        }
        
        public function get sellActionPriceVo() : ActionPriceVO
        {
            return this._sellActionPriceVo;
        }
        
        public function set sellActionPriceVo(param1:ActionPriceVO) : void
        {
            this._sellActionPriceVo = param1;
        }
        
        public function get removeActionPriceVo() : ActionPriceVO
        {
            return this._removeActionPriceVo;
        }
        
        public function set removeActionPriceVo(param1:ActionPriceVO) : void
        {
            this._removeActionPriceVo = param1;
        }
        
        public function get moneyValue() : Number
        {
            return this._moneyValue;
        }
        
        public function set moneyValue(param1:Number) : void
        {
            this._moneyValue = param1;
        }
        
        public function get type() : String
        {
            return this._type;
        }
        
        public function set type(param1:String) : void
        {
            this._type = param1;
        }
        
        public function get intCD() : Number
        {
            return this._intCD;
        }
        
        public function set intCD(param1:Number) : void
        {
            this._intCD = param1;
        }
        
        public function get count() : Number
        {
            return this._count;
        }
        
        public function set count(param1:Number) : void
        {
            this._count = param1;
        }
        
        public function get toInventory() : Boolean
        {
            return this._toInventory;
        }
        
        public function set toInventory(param1:Boolean) : void
        {
            this._toInventory = param1;
        }
        
        public function get fromInventory() : Boolean
        {
            return this._fromInventory;
        }
        
        public function set fromInventory(param1:Boolean) : void
        {
            this._fromInventory = param1;
        }
        
        public function get isRemovable() : Boolean
        {
            return this._isRemovable;
        }
        
        public function set isRemovable(param1:Boolean) : void
        {
            this._isRemovable = param1;
        }
        
        public function get id() : String
        {
            return this._id;
        }
        
        public function set id(param1:String) : void
        {
            this._id = param1;
        }
        
        public function get kind() : String
        {
            return this._kind;
        }
        
        public function set kind(param1:String) : void
        {
            this._kind = param1;
        }
        
        public function get sellExternalData() : Array
        {
            return this._sellExternalData;
        }
        
        public function set sellExternalData(param1:Array) : void
        {
            this._sellExternalData = param1;
        }
    }
}
