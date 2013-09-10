package net.wg.gui.lobby.demonstration.data 
{
    import net.wg.data.daapi.base.*;
    
    public class MapItemVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function MapItemVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get id():Number
        {
            return this._id;
        }

        public function set id(arg1:Number):void
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

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        internal var _id:Number=NaN;

        internal var _name:String="";

        internal var _type:String="";
    }
}
