package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class OrderPopoverVO extends DAAPIDataClass
    {
        
        public function OrderPopoverVO(param1:Object)
        {
            super(param1);
        }
        
        private var _title:String = "";
        
        private var _levelStr:String = "";
        
        private var _description:String = "";
        
        private var _effectTimeStr:String = "";
        
        private var _productionTime:String = "";
        
        private var _buildingStr:String = "";
        
        private var _productionCost:String = "";
        
        private var _producedAmount:String = "";
        
        private var _leftTimeStr:String = "";
        
        private var _icon:String = "";
        
        private var _canUseOrder:Boolean = false;
        
        private var _canCreateOrder:Boolean = true;
        
        private var _hasBuilding:Boolean = false;
        
        private var _inCooldown:Boolean = false;
        
        private var _effectTime:Number = -1;
        
        private var _leftTime:Number = -1;
        
        private var _useBtnTooltip:String = "";
        
        private var _questID:String = "";
        
        private var _showLinkBtn:Boolean = false;
        
        private var _isPermanent:Boolean = false;
        
        private var _showAlertIcon:Boolean = false;
        
        public function get title() : String
        {
            return this._title;
        }
        
        public function set title(param1:String) : void
        {
            this._title = param1;
        }
        
        public function get description() : String
        {
            return this._description;
        }
        
        public function set description(param1:String) : void
        {
            this._description = param1;
        }
        
        public function get effectTimeStr() : String
        {
            return this._effectTimeStr;
        }
        
        public function set effectTimeStr(param1:String) : void
        {
            this._effectTimeStr = param1;
        }
        
        public function get productionTime() : String
        {
            return this._productionTime;
        }
        
        public function set productionTime(param1:String) : void
        {
            this._productionTime = param1;
        }
        
        public function get buildingStr() : String
        {
            return this._buildingStr;
        }
        
        public function set buildingStr(param1:String) : void
        {
            this._buildingStr = param1;
        }
        
        public function get productionCost() : String
        {
            return this._productionCost;
        }
        
        public function set productionCost(param1:String) : void
        {
            this._productionCost = param1;
        }
        
        public function get producedAmount() : String
        {
            return this._producedAmount;
        }
        
        public function set producedAmount(param1:String) : void
        {
            this._producedAmount = param1;
        }
        
        public function get canCreateOrder() : Boolean
        {
            return this._canCreateOrder;
        }
        
        public function set canCreateOrder(param1:Boolean) : void
        {
            this._canCreateOrder = param1;
        }
        
        public function get canUseOrder() : Boolean
        {
            return this._canUseOrder;
        }
        
        public function set canUseOrder(param1:Boolean) : void
        {
            this._canUseOrder = param1;
        }
        
        public function get leftTimeStr() : String
        {
            return this._leftTimeStr;
        }
        
        public function set leftTimeStr(param1:String) : void
        {
            this._leftTimeStr = param1;
        }
        
        public function get effectTime() : Number
        {
            return this._effectTime;
        }
        
        public function set effectTime(param1:Number) : void
        {
            this._effectTime = param1;
        }
        
        public function get leftTime() : Number
        {
            return this._leftTime;
        }
        
        public function set leftTime(param1:Number) : void
        {
            this._leftTime = param1;
        }
        
        public function get levelStr() : String
        {
            return this._levelStr;
        }
        
        public function set levelStr(param1:String) : void
        {
            this._levelStr = param1;
        }
        
        public function get inCooldown() : Boolean
        {
            return this._inCooldown;
        }
        
        public function set inCooldown(param1:Boolean) : void
        {
            this._inCooldown = param1;
        }
        
        public function get useBtnTooltip() : String
        {
            return this._useBtnTooltip;
        }
        
        public function set useBtnTooltip(param1:String) : void
        {
            this._useBtnTooltip = param1;
        }
        
        public function get hasBuilding() : Boolean
        {
            return this._hasBuilding;
        }
        
        public function set hasBuilding(param1:Boolean) : void
        {
            this._hasBuilding = param1;
        }
        
        public function get isPermanent() : Boolean
        {
            return this._isPermanent;
        }
        
        public function set isPermanent(param1:Boolean) : void
        {
            this._isPermanent = param1;
        }
        
        public function get icon() : String
        {
            return this._icon;
        }
        
        public function set icon(param1:String) : void
        {
            this._icon = param1;
        }
        
        public function get questID() : String
        {
            return this._questID;
        }
        
        public function set questID(param1:String) : void
        {
            this._questID = param1;
        }
        
        public function get showLinkBtn() : Boolean
        {
            return this._showLinkBtn;
        }
        
        public function set showLinkBtn(param1:Boolean) : void
        {
            this._showLinkBtn = param1;
        }
        
        public function get showAlertIcon() : Boolean
        {
            return this._showAlertIcon;
        }
        
        public function set showAlertIcon(param1:Boolean) : void
        {
            this._showAlertIcon = param1;
        }
    }
}
