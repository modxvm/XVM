package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class ShopVehicleFilterElementData extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ShopVehicleFilterElementData(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get nation():int
        {
            return this._nation;
        }

        public function set nation(arg1:int):void
        {
            this._nation = arg1;
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

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        internal var _id:String="";

        internal var _nation:int=-1;

        internal var _name:String="";
    }
}
