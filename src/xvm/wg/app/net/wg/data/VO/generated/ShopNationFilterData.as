package net.wg.data.VO.generated 
{
    import net.wg.data.daapi.base.*;
    
    public class ShopNationFilterData extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ShopNationFilterData(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get language():Number
        {
            return this._language;
        }

        public function set language(arg1:Number):void
        {
            this._language = arg1;
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

        internal var _language:Number=-1;

        internal var _type:String="";
    }
}
