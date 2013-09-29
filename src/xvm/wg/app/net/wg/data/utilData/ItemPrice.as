package net.wg.data.utilData 
{
    public class ItemPrice extends Object
    {
        public function ItemPrice(arg1:int=0, arg2:int=0)
        {
            super();
            this._credits = arg1;
            this._gold = arg2;
            return;
        }

        public function get credits():int
        {
            return this._credits;
        }

        public function get gold():int
        {
            return this._gold;
        }

        internal var _credits:int;

        internal var _gold:int;
    }
}
