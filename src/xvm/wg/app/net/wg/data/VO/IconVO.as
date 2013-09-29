package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class IconVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function IconVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get big():String
        {
            return this._big;
        }

        public function set big(arg1:String):void
        {
            this._big = arg1;
            return;
        }

        public function get small():String
        {
            return this._small;
        }

        public function set small(arg1:String):void
        {
            this._small = arg1;
            return;
        }

        internal var _big:String="";

        internal var _small:String="";
    }
}
