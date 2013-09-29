package net.wg.data.VO 
{
    public class StoreTableVO extends Object
    {
        public function StoreTableVO()
        {
            super();
            return;
        }

        public function get gold():Number
        {
            return this._gold;
        }

        public function set gold(arg1:Number):void
        {
            this._gold = arg1;
            return;
        }

        public function get credits():Number
        {
            return this._credits;
        }

        public function set credits(arg1:Number):void
        {
            this._credits = arg1;
            return;
        }

        internal var _gold:Number=0;

        internal var _credits:Number=0;
    }
}
