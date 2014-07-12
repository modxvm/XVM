package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class PremiumFormModel extends DAAPIDataClass
    {
        
        public function PremiumFormModel(param1:Object) {
            super(param1);
        }
        
        private var _days:int = -1;
        
        private var _price:int = 0;
        
        private var _discountPrice:int = 0;
        
        private var _isDiscountPackage:Boolean = false;
        
        private var _userGold:Number = 0;
        
        private var _isUserSelected:Boolean = false;
        
        public function get days() : int {
            return this._days;
        }
        
        public function set days(param1:int) : void {
            this._days = param1;
        }
        
        public function get price() : int {
            return this._price;
        }
        
        public function set price(param1:int) : void {
            this._price = param1;
        }
        
        public function get discountPrice() : int {
            return this._discountPrice;
        }
        
        public function set discountPrice(param1:int) : void {
            this._discountPrice = param1;
        }
        
        public function get isDiscountPackage() : Boolean {
            return this._isDiscountPackage;
        }
        
        public function set isDiscountPackage(param1:Boolean) : void {
            this._isDiscountPackage = param1;
        }
        
        public function get userGold() : Number {
            return this._userGold;
        }
        
        public function set userGold(param1:Number) : void {
            this._userGold = param1;
        }
        
        public function get isUserSelected() : Boolean {
            return this._isUserSelected;
        }
        
        public function set isUserSelected(param1:Boolean) : void {
            this._isUserSelected = param1;
        }
    }
}
