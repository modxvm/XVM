package net.wg.gui.lobby.vehicleBuyWindow
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.gui.utils.VO.PriceVO;
    
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
        
        public var isRentable:Boolean = false;
        
        public var isRentAvailable:Boolean = false;
        
        private var _rentDataDD:Object = null;
        
        private var _rentDataProviderDD:Array = null;
        
        public var isStudyDisabled:Boolean = false;
        
        public var isNoAmmo:Boolean = false;
        
        private var _defSelectedRentIndex:Number = NaN;
        
        private var _rentDataSelectedId:int = -1;
        
        public var isElite:Boolean;
        
        public var isPremium:Boolean;
        
        public var tankmenCount:uint;
        
        public var studyPriceCredits:Number;
        
        public var _studyPriceCreditsActionDataVo:ActionPriceVO;
        
        public var studyPriceGold:Number;
        
        public var _studyPriceGoldActionDataVo:ActionPriceVO;
        
        private var _vehiclePrices:Array;
        
        private var _vehiclePrice:PriceVO = null;
        
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
        
        private function updateVehicleActionPrice() : void
        {
            if(this._vehiclePricesActionDataVo)
            {
                this._vehiclePricesActionDataVo.forCredits = !this.vehiclePrice.isGold;
            }
        }
        
        public function get vehiclePrices() : Array
        {
            return this._vehiclePrices;
        }
        
        public function set vehiclePrices(param1:Array) : void
        {
            this._vehiclePrices = param1;
            this.vehiclePrice = new PriceVO(this._vehiclePrices);
            this.isPremium = this.vehiclePrice.isGold;
        }
        
        public function get actualActionPriceDataVo() : ActionPriceVO
        {
            return this._vehiclePricesActionDataVo;
        }
        
        public function set actualActionPriceDataVo(param1:ActionPriceVO) : void
        {
            this._vehiclePricesActionDataVo = param1;
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
        
        public function get rentDataDD() : Object
        {
            return this._rentDataDD;
        }
        
        public function set rentDataDD(param1:Object) : void
        {
            this._rentDataDD = param1;
            this._rentDataSelectedId = (this._rentDataDD.hasOwnProperty("selectedId")) && !(this._rentDataDD.selectedId == undefined) && !(this._rentDataDD.selectedId == null)?this._rentDataDD.selectedId:VehicleBuyRentItemVO.DEF_ITEM_ID;
            this._rentDataProviderDD = [];
            this.updateRentData(this._rentDataDD.data as Array);
        }
        
        private function updateRentData(param1:Array) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:VehicleBuyRentItemVO = null;
            if(param1)
            {
                _loc2_ = 0;
                while(_loc2_ < param1.length)
                {
                    _loc3_ = new VehicleBuyRentItemVO(param1[_loc2_]);
                    if(_loc3_.itemId == this._rentDataSelectedId)
                    {
                        this.defSelectedRentIndex = _loc2_;
                    }
                    this._rentDataProviderDD.push({"label":_loc3_.label,
                    "data":_loc3_,
                    "enabled":_loc3_.enabled
                });
                _loc2_++;
            }
        }
    }
    
    override protected function onDispose() : void
    {
        var _loc1_:VehicleBuyRentItemVO = null;
        if(this._rentDataProviderDD)
        {
            while(this._rentDataProviderDD.length)
            {
                _loc1_ = VehicleBuyRentItemVO(this._rentDataProviderDD.pop().data);
                _loc1_.dispose();
            }
        }
        super.onDispose();
    }
    
    public function get vehiclePrice() : PriceVO
    {
        return this._vehiclePrice;
    }
    
    public function set vehiclePrice(param1:PriceVO) : void
    {
        this._vehiclePrice = param1;
        this.updateVehicleActionPrice();
    }
    
    public function get defSelectedRentIndex() : Number
    {
        return this._defSelectedRentIndex;
    }
    
    public function set defSelectedRentIndex(param1:Number) : void
    {
        this._defSelectedRentIndex = param1;
    }
    
    public function get rentDataProviderDD() : Array
    {
        return this._rentDataProviderDD;
    }
    
    public function set rentDataProviderDD(param1:Array) : void
    {
        this._rentDataProviderDD = param1;
    }
}
}
