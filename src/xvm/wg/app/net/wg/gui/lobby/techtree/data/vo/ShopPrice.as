package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class ShopPrice extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function ShopPrice(arg1:Number=0, arg2:Number=0)
        {
            super();
            this._credits = arg1;
            if (this._credits > 0) 
            {
                this._creditsLabel = App.utils.locale.integer(this._credits);
            }
            else 
            {
                this._creditsLabel = "0";
            }
            this._gold = arg2;
            if (this._gold > 0) 
            {
                this._goldLabel = App.utils.locale.integer(this._gold);
            }
            else 
            {
                this._goldLabel = "0";
            }
            return;
        }

        public function get credits():Number
        {
            return this._credits;
        }

        public function get creditsLabel():String
        {
            return this._creditsLabel;
        }

        public function get gold():Number
        {
            return this._gold;
        }

        public function get goldLabel():String
        {
            return this._goldLabel;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 1) 
            {
                this._credits = isNaN(arg1[0]) ? 0 : arg1[0];
                this._creditsLabel = arg2.integer(this._credits);
                this._gold = isNaN(arg1[1]) ? 0 : arg1[1];
                this._goldLabel = arg2.gold(this._gold);
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.credits != null) 
            {
                this._credits = arg1.credits;
                this._creditsLabel = arg2.integer(this._credits);
            }
            if (arg1.gold != null) 
            {
                this._gold = arg1.gold;
                this._goldLabel = arg2.gold(this._gold);
            }
            return;
        }

        public function toString():String
        {
            return "[ShopPrice: credits = " + this._credits + ", gold = " + this._gold + "]";
        }

        internal var _credits:Number;

        internal var _gold:Number;

        internal var _creditsLabel:String;

        internal var _goldLabel:String;
    }
}
