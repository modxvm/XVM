package net.wg.gui.lobby.vehicleBuyWindow 
{
    import net.wg.data.daapi.base.*;
    
    public class BuyingVehicleVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function BuyingVehicleVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get isPremium():Boolean
        {
            return this._isPremium;
        }

        public function get actualPrice():uint
        {
            return this._actualPrice;
        }

        public function get vehiclePrices():Array
        {
            return this._vehiclePrices;
        }

        public function set vehiclePrices(arg1:Array):void
        {
            this._vehiclePrices = arg1;
            if (this._vehiclePrices[1] == 0) 
            {
                this._actualPrice = this._vehiclePrices[0];
                this._isPremium = false;
            }
            else 
            {
                this._actualPrice = this._vehiclePrices[1];
                this._isPremium = true;
            }
            return;
        }

        public var name:String="";

        public var longName:String="";

        public var type:String="";

        public var icon:String="";

        public var description:String="";

        public var nation:uint;

        public var level:uint;

        internal var _isPremium:Boolean;

        public var isElite:Boolean;

        public var tankmenCount:uint;

        public var studyPriceCredits:uint;

        public var studyPriceGold:Number;

        internal var _vehiclePrices:Array;

        internal var _actualPrice:uint;

        public var ammoPrice:Number;

        public var slotPrice:uint;
    }
}
