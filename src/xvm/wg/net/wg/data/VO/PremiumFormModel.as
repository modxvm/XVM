package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class PremiumFormModel extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function PremiumFormModel(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get days():int
        {
            return this._days;
        }

        public function set days(arg1:int):void
        {
            this._days = arg1;
            return;
        }

        public function get price():int
        {
            return this._price;
        }

        public function set price(arg1:int):void
        {
            this._price = arg1;
            return;
        }

        public function get discountPrice():int
        {
            return this._discountPrice;
        }

        public function set discountPrice(arg1:int):void
        {
            this._discountPrice = arg1;
            return;
        }

        public function get isDiscountPackage():Boolean
        {
            return this._isDiscountPackage;
        }

        public function set isDiscountPackage(arg1:Boolean):void
        {
            this._isDiscountPackage = arg1;
            return;
        }

        public function get userGold():Number
        {
            return this._userGold;
        }

        public function set userGold(arg1:Number):void
        {
            this._userGold = arg1;
            return;
        }

        public function get isUserSelected():Boolean
        {
            return this._isUserSelected;
        }

        public function set isUserSelected(arg1:Boolean):void
        {
            this._isUserSelected = arg1;
            return;
        }

        internal var _days:int=-1;

        internal var _price:int=0;

        internal var _discountPrice:int=0;

        internal var _isDiscountPackage:Boolean=false;

        internal var _userGold:Number=0;

        internal var _isUserSelected:Boolean=false;
    }
}
