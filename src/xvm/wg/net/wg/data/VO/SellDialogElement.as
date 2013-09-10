package net.wg.data.VO 
{
    public class SellDialogElement extends Object
    {
        public function SellDialogElement()
        {
            super();
            return;
        }

        public function get removePrice():Number
        {
            return this._removePrice;
        }

        public function set removePrice(arg1:Number):void
        {
            this._removePrice = arg1;
            return;
        }

        public function get moneyValue():Number
        {
            return this._moneyValue;
        }

        public function set moneyValue(arg1:Number):void
        {
            this._moneyValue = arg1;
            return;
        }

        public function get inInventory():Boolean
        {
            return this._inInventory;
        }

        public function set inInventory(arg1:Boolean):void
        {
            this._inInventory = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public function get isRemovable():Boolean
        {
            return this._isRemovable;
        }

        public function set isRemovable(arg1:Boolean):void
        {
            this._isRemovable = arg1;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        internal var _id:String;

        internal var _isRemovable:Boolean;

        internal var _data:Object;

        internal var _type:String;

        internal var _inInventory:Boolean;

        internal var _moneyValue:Number;

        internal var _removePrice:Number;
    }
}
