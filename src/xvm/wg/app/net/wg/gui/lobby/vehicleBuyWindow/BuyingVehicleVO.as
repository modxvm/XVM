package net.wg.gui.lobby.vehicleBuyWindow
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class BuyingVehicleVO extends DAAPIDataClass
    {
        
        public function BuyingVehicleVO(param1:Object)
        {
            super(param1);
        }
        
        public var name:String = "";
        
        public var longName:String = "";
        
        public var type:String = "";
        
        public var icon:String = "";
        
        public var description:String = "";
        
        public var nation:uint;
        
        public var level:uint;
        
        private var _isPremium:Boolean;
        
        public var isElite:Boolean;
        
        public var tankmenCount:uint;
        
        public var studyPriceCredits:Number;
        
        public var _studyPriceCreditsActionDataVo:ActionPriceVO;
        
        public var studyPriceGold:Number;
        
        public var _studyPriceGoldActionDataVo:ActionPriceVO;
        
        private var _vehiclePrices:Array;
        
        private var _actualPrice:uint;
        
        private var _vehiclePricesActionDataVo:ActionPriceVO;
        
        public var ammoPrice:Number;
        
        public var _ammoActionPriceDataVo:ActionPriceVO;
        
        public var slotPrice:uint;
        
        public var _slotActionPriceDataVo:ActionPriceVO;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "studyPriceCreditsActionData")
            {
                if(param2)
                {
                    this._studyPriceCreditsActionDataVo = new ActionPriceVO(param2);
                    this._studyPriceCreditsActionDataVo.forCredits = true;
                }
                return false;
            }
            if(param1 == "studyPriceGoldActionData")
            {
                if(param2)
                {
                    this._studyPriceGoldActionDataVo = new ActionPriceVO(param2);
                    this._studyPriceGoldActionDataVo.forCredits = false;
                }
                return false;
            }
            if(param1 == "vehiclePricesActionData")
            {
                if(param2)
                {
                    this._vehiclePricesActionDataVo = new ActionPriceVO(param2);
                    this.updateVehicleActionPrice();
                }
                return false;
            }
            if(param1 == "ammoActionPriceData")
            {
                if(param2)
                {
                    this._ammoActionPriceDataVo = new ActionPriceVO(param2);
                    this._ammoActionPriceDataVo.forCredits = true;
                }
                return false;
            }
            if(param1 == "slotActionPriceData")
            {
                if(param2)
                {
                    this._slotActionPriceDataVo = new ActionPriceVO(param2);
                    this._slotActionPriceDataVo.forCredits = false;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        public function get isPremium() : Boolean
        {
            return this._isPremium;
        }
        
        public function set isPremium(param1:Boolean) : void
        {
            this._isPremium = param1;
            this.updateVehicleActionPrice();
        }
        
        private function updateVehicleActionPrice() : void
        {
            if(this._vehiclePricesActionDataVo)
            {
                this._vehiclePricesActionDataVo.forCredits = !this._isPremium;
            }
        }
        
        public function get actualPrice() : uint
        {
            return this._actualPrice;
        }
        
        public function get vehiclePrices() : Array
        {
            return this._vehiclePrices;
        }
        
        public function set vehiclePrices(param1:Array) : void
        {
            this._vehiclePrices = param1;
            if(this._vehiclePrices[1] != 0)
            {
                this._actualPrice = this._vehiclePrices[1];
                this.isPremium = true;
            }
            else
            {
                this._actualPrice = this._vehiclePrices[0];
                this.isPremium = false;
            }
        }
        
        public function get actualActionPriceDataVo() : ActionPriceVO
        {
            return this._vehiclePricesActionDataVo;
        }
        
        public function set actualActionPriceData(param1:Object) : void
        {
            this._vehiclePricesActionDataVo = new ActionPriceVO(param1);
        }
        
        public function get studyPriceCreditsActionDataVo() : ActionPriceVO
        {
            return this._studyPriceCreditsActionDataVo;
        }
        
        public function set studyPriceCreditsActionData(param1:Object) : void
        {
            this._studyPriceCreditsActionDataVo = new ActionPriceVO(param1);
        }
        
        public function get studyPriceGoldActionDataVo() : ActionPriceVO
        {
            return this._studyPriceGoldActionDataVo;
        }
        
        public function set studyPriceGoldActionData(param1:Object) : void
        {
            this._studyPriceGoldActionDataVo = new ActionPriceVO(param1);
        }
        
        public function get ammoActionPriceDataVo() : ActionPriceVO
        {
            return this._ammoActionPriceDataVo;
        }
        
        public function set ammoActionPriceData(param1:Object) : void
        {
            this._ammoActionPriceDataVo = new ActionPriceVO(param1);
        }
        
        public function get slotActionPriceDataVo() : ActionPriceVO
        {
            return this._slotActionPriceDataVo;
        }
        
        public function set slotActionPriceData(param1:Object) : void
        {
            this._slotActionPriceDataVo = new ActionPriceVO(param1);
        }
    }
}
