package net.wg.gui.lobby.sellDialog
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleShellVo;
    import net.wg.data.VO.SellDialogElement;
    import net.wg.data.VO.SellDialogItem;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.FittingTypes;
    import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleEquipmentVo;
    import net.wg.gui.lobby.sellDialog.VO.SellInInventoryModuleVo;
    import net.wg.gui.lobby.sellDialog.VO.SellInInventoryShellVo;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.events.VehicleSellDialogEvent;
    import flash.geom.Rectangle;
    
    public class SellSlidingComponent extends UIComponent
    {
        
        public function SellSlidingComponent() {
            this.sellData = [];
            super();
            scrollRect = new Rectangle(0,0,480,270);
        }
        
        private static var PADDING_FOR_NEXT_ELEMENT:uint = 10;
        
        public var settingsBtn:SettingsButton;
        
        public var mask_mc:MovieClip;
        
        public var slidingScrList:SlidingScrollingList;
        
        public var expandBg:MovieClip;
        
        public var sellData:Array;
        
        public var resultExpand:int = 0;
        
        private var _isOpened:Boolean = false;
        
        private var listHeight:int = 0;
        
        public function getNextPosition() : int {
            return this.expandBg.y + this.expandBg.height + PADDING_FOR_NEXT_ELEMENT;
        }
        
        public function setShells(param1:Vector.<SellOnVehicleShellVo>) : void {
            var _loc7_:SellDialogElement = null;
            var _loc2_:SellDialogItem = new SellDialogItem();
            var _loc3_:ILocale = App.utils.locale;
            var _loc4_:Number = param1.length;
            var _loc5_:SellOnVehicleShellVo = null;
            var _loc6_:uint = 0;
            while(_loc6_ < _loc4_)
            {
                _loc5_ = param1[_loc6_];
                if(_loc5_.count != 0)
                {
                    _loc7_ = new SellDialogElement();
                    _loc7_.id = _loc5_.userName + " (" + _loc5_.count + " " + _loc3_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                    _loc7_.isRemovable = true;
                    _loc7_.type = FittingTypes.SHELL;
                    _loc7_.kind = _loc5_.kind;
                    _loc7_.intCD = _loc5_.intCD;
                    _loc7_.moneyValue = _loc5_.sellPrice[0] * _loc5_.count;
                    _loc7_.fromInventory = false;
                    _loc7_.count = _loc5_.count;
                    _loc7_.sellActionPriceVo = _loc5_.actionVo;
                    _loc7_.toInventory = _loc5_.toInventory;
                    _loc2_.elements.push(_loc7_);
                }
                _loc6_++;
            }
            if(_loc2_.elements.length != 0)
            {
                _loc2_.header = DIALOGS.VEHICLESELLDIALOG_AMMO_LABEL;
                this.sellData.push(_loc2_);
            }
        }
        
        public function setEquipment(param1:Vector.<SellOnVehicleEquipmentVo>) : void {
            var _loc6_:SellDialogElement = null;
            var _loc2_:SellDialogItem = new SellDialogItem();
            var _loc3_:Number = param1.length;
            var _loc4_:SellOnVehicleEquipmentVo = null;
            var _loc5_:uint = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = param1[_loc5_];
                _loc6_ = new SellDialogElement();
                _loc6_.id = _loc4_.userName;
                _loc6_.type = FittingTypes.EQUIPMENT;
                _loc6_.moneyValue = _loc4_.sellPrice[0] != 0?_loc4_.sellPrice[0]:_loc4_.sellPrice[1];
                _loc6_.sellActionPriceVo = _loc4_.actionVo;
                _loc6_.toInventory = _loc4_.toInventory;
                _loc6_.intCD = _loc4_.intCD;
                _loc6_.isRemovable = true;
                _loc6_.count = _loc4_.count;
                _loc2_.elements.push(_loc6_);
                _loc5_++;
            }
            if(_loc2_.elements.length != 0)
            {
                _loc2_.header = DIALOGS.VEHICLESELLDIALOG_EQUIPMENT;
                this.sellData.push(_loc2_);
            }
        }
        
        public function calculateOpenedState() : void {
            this.settingsBtn.y = 0;
            this.slidingScrList.y = this.settingsBtn.y + this.settingsBtn.height;
            this.slidingScrList.height = this.listHeight;
            this.expandBg.height = this.slidingScrList.y + this.listHeight - 1;
            this.mask_mc.y = this.slidingScrList.y;
            this.mask_mc.height = this.listHeight;
        }
        
        public function calculateClosedState() : void {
            this.settingsBtn.y = 0;
            this.slidingScrList.height = this.listHeight;
            this.slidingScrList.y = this.slidingScrList.height * -1 + this.settingsBtn.y + this.settingsBtn.height;
            this.mask_mc.y = this.settingsBtn.y + this.settingsBtn.height;
            this.mask_mc.height = 0;
        }
        
        public function setInventory(param1:Vector.<SellInInventoryModuleVo>, param2:Vector.<SellInInventoryShellVo>) : void {
            var _loc14_:SellDialogElement = null;
            var _loc3_:SellDialogItem = new SellDialogItem();
            var _loc4_:Number = 0;
            var _loc5_:SellDialogElement = new SellDialogElement();
            _loc5_.toInventory = true;
            var _loc6_:Number = 0;
            var _loc7_:Number = param1.length;
            var _loc8_:SellInInventoryModuleVo = null;
            var _loc9_:Array = new Array();
            var _loc10_:uint = 0;
            while(_loc10_ < _loc7_)
            {
                _loc8_ = param1[_loc10_];
                _loc4_ = _loc4_ + _loc8_.sellPrice[0] * _loc8_.count;
                _loc6_ = _loc6_ + _loc8_.count;
                _loc5_.toInventory = _loc5_.toInventory;
                _loc9_.push({
                    "intCD":_loc8_.intCD,
                    "count":_loc8_.count
                });
            _loc10_++;
        }
        var _loc11_:ILocale = App.utils.locale;
        if(_loc7_ > 0)
        {
            _loc5_.moneyValue = _loc4_;
            _loc5_.id = _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_NOTINSTALLED_MODULES) + " (" + _loc6_ + " " + _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
            _loc5_.isRemovable = true;
            _loc5_.type = FittingTypes.MODULE;
            _loc5_.count = _loc6_;
            _loc5_.sellExternalData = _loc9_;
            _loc3_.elements.push(_loc5_);
        }
        var _loc12_:SellInInventoryShellVo = null;
        _loc7_ = param2.length;
        var _loc13_:uint = 0;
        while(_loc13_ < _loc7_)
        {
            _loc12_ = param2[_loc13_];
            if(_loc12_.count != 0)
            {
                _loc14_ = new SellDialogElement();
                _loc14_.id = _loc12_.userName + " (" + _loc12_.count + " " + _loc11_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                _loc14_.isRemovable = true;
                _loc14_.kind = _loc12_.kind;
                _loc14_.type = FittingTypes.SHELL;
                _loc14_.toInventory = _loc12_.toInventory;
                _loc14_.fromInventory = true;
                _loc14_.intCD = _loc12_.intCD;
                _loc14_.count = _loc12_.count;
                _loc14_.moneyValue = _loc12_.sellPrice[0] * _loc12_.count;
                if(_loc12_.actionVo)
                {
                    _loc14_.sellActionPriceVo = _loc12_.actionVo;
                }
                _loc3_.elements.push(_loc14_);
            }
            _loc13_++;
        }
        if(_loc3_.elements.length != 0)
        {
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_INVENTORY;
            this.sellData.push(_loc3_);
        }
        this.slidingScrList.dataProvider = new DataProvider(this.sellData);
    }
    
    public function preInitStates() : void {
        this.resultExpand = this.settingsBtn.height + this.listHeight - 1 - this.expandBg.height;
    }
    
    public function get isOpened() : Boolean {
        return this._isOpened;
    }
    
    public function set isOpened(param1:Boolean) : void {
        this._isOpened = param1;
        this.settingsBtn.setingsDropBtn.selected = this.isOpened;
    }
    
    override protected function configUI() : void {
        super.configUI();
        this.settingsBtn.visible = false;
        this.expandBg.visible = false;
        this.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler,false,5);
    }
    
    private function updateElements() : void {
        this.preInitStates();
        if(this.isOpened)
        {
            this.calculateOpenedState();
            this.mask_mc.visible = true;
            this.slidingScrList.visible = true;
            this.settingsBtn.creditsIT.alpha = 0;
            this.settingsBtn.ddLine.alpha = 1;
        }
        else
        {
            this.calculateClosedState();
            this.mask_mc.visible = false;
            this.slidingScrList.visible = false;
            this.settingsBtn.creditsIT.alpha = 1;
            this.settingsBtn.ddLine.alpha = 0;
        }
    }
    
    private function wasDrawnHandler(param1:VehicleSellDialogEvent) : void {
        this.listHeight = param1.listVisibleHight;
        this.updateElements();
    }
}
}
