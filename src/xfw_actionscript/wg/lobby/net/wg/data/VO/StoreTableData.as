package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.gui.data.VehCompareEntrypointVO;

    public class StoreTableData extends DAAPIDataClass
    {

        private static const VEH_COMPARE_DATA_FIELD_NAME:String = "vehCompareData";

        public var highlightType:String = "";

        public var showActionGoldAndCredits:Boolean = false;

        public var notForSaleText:String = "";

        public var crystal:int = 0;

        public var actionPercent:Array = null;

        private var _extraModuleInfo:String = "";

        private var _id:String = "";

        private var _requestType:String = "";

        private var _name:String = "";

        private var _desc:String = "";

        private var _restoreInfo:String = "";

        private var _inventoryId:Number = 0;

        private var _inventoryCount:int = 0;

        private var _vehicleCount:int = 0;

        private var _credits:int = 0;

        private var _gold:int = 0;

        private var _price:Array = null;

        private var _actionPriceDataVo:ActionPriceVO = null;

        private var _alternativePriceDataVo:ActionPriceVO = null;

        private var _actionPriceData:Object = null;

        private var _currency:String = "";

        private var _level:int = 0;

        private var _moduleLabel:String = "";

        private var _nation:int = 0;

        private var _type:String = "";

        private var _disabled:Boolean = false;

        private var _statusMessage:String = "";

        private var _isCritLvl:Boolean = false;

        private var _statusImgSrc:String = "";

        private var _removable:Boolean = false;

        private var _tankType:String = "";

        private var _isPremium:Boolean = false;

        private var _isElite:Boolean = false;

        private var _itemTypeName:String = "";

        private var _goldShellsForCredits:Boolean = false;

        private var _goldEqsForCredits:Boolean = false;

        private var _canTradeIn:Boolean = false;

        private var _isInTradeIn:Boolean = false;

        private var _rentLeft:String = "";

        private var _exchangeRate:Number = -1;

        private var _warnMessage:String = "";

        private var _tradeInPrice:String = "";

        private var _vehCompareVO:VehCompareEntrypointVO = null;

        public function StoreTableData(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            this._actionPriceData = null;
            this.clearActionPriceDataVO();
            this.clearAlternativePriceDataVO();
            this.clearVehCompareVO();
            this.actionPercent.splice(0,this.actionPercent.length);
            this.actionPercent = null;
            this._price.splice(0,this._price.length);
            this._price = null;
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == VEH_COMPARE_DATA_FIELD_NAME)
            {
                this.clearVehCompareVO();
                this.vehCompareVO = new VehCompareEntrypointVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        private function clearVehCompareVO() : void
        {
            if(this._vehCompareVO != null)
            {
                this._vehCompareVO.dispose();
                this._vehCompareVO = null;
            }
        }

        private function clearActionPriceDataVO() : void
        {
            if(this._actionPriceDataVo != null)
            {
                this._actionPriceDataVo.dispose();
                this._actionPriceDataVo = null;
            }
        }

        private function clearAlternativePriceDataVO() : void
        {
            if(this._alternativePriceDataVo != null)
            {
                this._alternativePriceDataVo.dispose();
                this._alternativePriceDataVo = null;
            }
        }

        public function get goldEqsForCredits() : Boolean
        {
            return this._goldEqsForCredits;
        }

        public function set goldEqsForCredits(param1:Boolean) : void
        {
            this._goldEqsForCredits = param1;
        }

        public function get id() : String
        {
            return this._id;
        }

        public function set id(param1:String) : void
        {
            this._id = param1;
        }

        public function get requestType() : String
        {
            return this._requestType;
        }

        public function set requestType(param1:String) : void
        {
            this._requestType = param1;
        }

        public function get name() : String
        {
            return this._name;
        }

        public function set name(param1:String) : void
        {
            this._name = param1;
        }

        public function get desc() : String
        {
            return this._desc;
        }

        public function set desc(param1:String) : void
        {
            this._desc = param1;
        }

        public function get inventoryId() : Number
        {
            return this._inventoryId;
        }

        public function set inventoryId(param1:Number) : void
        {
            this._inventoryId = param1;
        }

        public function get inventoryCount() : int
        {
            return this._inventoryCount;
        }

        public function set inventoryCount(param1:int) : void
        {
            this._inventoryCount = param1;
        }

        public function get vehicleCount() : int
        {
            return this._vehicleCount;
        }

        public function set vehicleCount(param1:int) : void
        {
            this._vehicleCount = param1;
        }

        public function get credits() : int
        {
            return this._credits;
        }

        public function set credits(param1:int) : void
        {
            this._credits = param1;
        }

        public function get gold() : int
        {
            return this._gold;
        }

        public function set gold(param1:int) : void
        {
            this._gold = param1;
        }

        public function get price() : Array
        {
            return this._price;
        }

        public function set price(param1:Array) : void
        {
            this._price = param1;
        }

        public function get actionPriceData() : Object
        {
            return this._actionPriceData;
        }

        public function set actionPriceData(param1:Object) : void
        {
            this._actionPriceData = param1;
            if(param1)
            {
                this.clearActionPriceDataVO();
                this.actionPriceDataVo = new ActionPriceVO(param1);
                this.clearAlternativePriceDataVO();
                this.alternativePriceDataVo = new ActionPriceVO(param1);
            }
        }

        public function get actionPriceDataVo() : ActionPriceVO
        {
            return this._actionPriceDataVo;
        }

        public function set actionPriceDataVo(param1:ActionPriceVO) : void
        {
            this._actionPriceDataVo = param1;
        }

        public function get alternativePriceDataVo() : ActionPriceVO
        {
            return this._alternativePriceDataVo;
        }

        public function set alternativePriceDataVo(param1:ActionPriceVO) : void
        {
            this._alternativePriceDataVo = param1;
        }

        public function get currency() : String
        {
            return this._currency;
        }

        public function set currency(param1:String) : void
        {
            this._currency = param1;
        }

        public function get level() : int
        {
            return this._level;
        }

        public function set level(param1:int) : void
        {
            this._level = param1;
        }

        public function get moduleLabel() : String
        {
            return this._moduleLabel;
        }

        public function set moduleLabel(param1:String) : void
        {
            this._moduleLabel = param1;
        }

        public function get nation() : int
        {
            return this._nation;
        }

        public function set nation(param1:int) : void
        {
            this._nation = param1;
        }

        public function get type() : String
        {
            return this._type;
        }

        public function set type(param1:String) : void
        {
            this._type = param1;
        }

        public function get disabled() : Boolean
        {
            return this._disabled;
        }

        public function set disabled(param1:Boolean) : void
        {
            this._disabled = param1;
        }

        public function get isCritLvl() : Boolean
        {
            return this._isCritLvl;
        }

        public function set isCritLvl(param1:Boolean) : void
        {
            this._isCritLvl = param1;
        }

        public function get removable() : Boolean
        {
            return this._removable;
        }

        public function set removable(param1:Boolean) : void
        {
            this._removable = param1;
        }

        public function get tankType() : String
        {
            return this._tankType;
        }

        public function set tankType(param1:String) : void
        {
            this._tankType = param1;
        }

        public function get isPremium() : Boolean
        {
            return this._isPremium;
        }

        public function set isPremium(param1:Boolean) : void
        {
            this._isPremium = param1;
        }

        public function get isElite() : Boolean
        {
            return this._isElite;
        }

        public function set isElite(param1:Boolean) : void
        {
            this._isElite = param1;
        }

        public function get itemTypeName() : String
        {
            return this._itemTypeName;
        }

        public function set itemTypeName(param1:String) : void
        {
            this._itemTypeName = param1;
        }

        public function get goldShellsForCredits() : Boolean
        {
            return this._goldShellsForCredits;
        }

        public function set goldShellsForCredits(param1:Boolean) : void
        {
            this._goldShellsForCredits = param1;
        }

        public function get extraModuleInfo() : String
        {
            return this._extraModuleInfo;
        }

        public function set extraModuleInfo(param1:String) : void
        {
            this._extraModuleInfo = param1;
        }

        public function get rentLeft() : String
        {
            return this._rentLeft;
        }

        public function set rentLeft(param1:String) : void
        {
            this._rentLeft = param1;
        }

        public function get statusMessage() : String
        {
            return this._statusMessage;
        }

        public function set statusMessage(param1:String) : void
        {
            this._statusMessage = param1;
        }

        public function get exchangeRate() : Number
        {
            return this._exchangeRate;
        }

        public function set exchangeRate(param1:Number) : void
        {
            this._exchangeRate = param1;
        }

        public function get warnMessage() : String
        {
            return this._warnMessage;
        }

        public function set warnMessage(param1:String) : void
        {
            this._warnMessage = param1;
        }

        public function get vehCompareVO() : VehCompareEntrypointVO
        {
            return this._vehCompareVO;
        }

        public function set vehCompareVO(param1:VehCompareEntrypointVO) : void
        {
            this._vehCompareVO = param1;
        }

        public function get restoreInfo() : String
        {
            return this._restoreInfo;
        }

        public function set restoreInfo(param1:String) : void
        {
            this._restoreInfo = param1;
        }

        public function get tradeInPrice() : String
        {
            return this._tradeInPrice;
        }

        public function set tradeInPrice(param1:String) : void
        {
            this._tradeInPrice = param1;
        }

        public function get canTradeIn() : Boolean
        {
            return this._canTradeIn;
        }

        public function set canTradeIn(param1:Boolean) : void
        {
            this._canTradeIn = param1;
        }

        public function get isInTradeIn() : Boolean
        {
            return this._isInTradeIn;
        }

        public function set isInTradeIn(param1:Boolean) : void
        {
            this._isInTradeIn = param1;
        }

        public function get statusImgSrc() : String
        {
            return this._statusImgSrc;
        }

        public function set statusImgSrc(param1:String) : void
        {
            this._statusImgSrc = param1;
        }
    }
}
