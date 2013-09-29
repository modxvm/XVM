package net.wg.gui.lobby.confirmModuleWindow 
{
    import net.wg.data.daapi.base.*;
    
    public class ModuleInfoVo extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ModuleInfoVo(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get isActionNow():Boolean
        {
            return this._isActionNow;
        }

        public function set isActionNow(arg1:Boolean):void
        {
            this._isActionNow = arg1;
            return;
        }

        public function get maxAvailableCount():Array
        {
            return this._maxAvailableCount;
        }

        public function set maxAvailableCount(arg1:Array):void
        {
            this._maxAvailableCount = arg1;
            return;
        }

        public function get id():int
        {
            return this._id;
        }

        public function set id(arg1:int):void
        {
            this._id = arg1;
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

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get descr():String
        {
            return this._descr;
        }

        public function set descr(arg1:String):void
        {
            this._descr = arg1;
            return;
        }

        public function get currency():String
        {
            return this._currency;
        }

        public function set currency(arg1:String):void
        {
            this._currency = arg1;
            return;
        }

        public function get price():Array
        {
            return this._price;
        }

        public function set price(arg1:Array):void
        {
            this._price = arg1;
            return;
        }

        public function get defaultValue():Number
        {
            return this._defaultValue;
        }

        public function set defaultValue(arg1:Number):void
        {
            this._defaultValue = arg1;
            return;
        }

        internal var _id:int;

        internal var _type:String="";

        internal var _icon:String="";

        internal var _name:String="";

        internal var _descr:String="";

        internal var _currency:String="";

        internal var _price:Array;

        internal var _maxAvailableCount:Array;

        internal var _isActionNow:Boolean;

        internal var _defaultValue:Number=-1;

        public var extraModuleInfo:String="";
    }
}
