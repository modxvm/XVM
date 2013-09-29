package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class PointVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function PointVO(arg1:Object)
        {
            super(arg1);
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

        public function get color():String
        {
            return this._color;
        }

        public function set color(arg1:String):void
        {
            this._color = arg1;
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

        public function get y():Number
        {
            return this._y;
        }

        public function set y(arg1:Number):void
        {
            this._y = arg1;
            return;
        }

        public function get x():Number
        {
            return this._x;
        }

        public function set x(arg1:Number):void
        {
            this._x = arg1;
            return;
        }

        internal var _x:Number=0;

        internal var _y:Number=0;

        internal var _type:String="";

        internal var _color:String="";

        internal var _id:String="";
    }
}
