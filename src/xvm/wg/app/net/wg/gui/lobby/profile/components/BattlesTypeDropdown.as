package net.wg.gui.lobby.profile.components
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.data.DataProvider;
    import flash.events.MouseEvent;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class BattlesTypeDropdown extends UIComponent
    {
        
        public function BattlesTypeDropdown() {
            super();
        }
        
        private static function hideToolTip() : void {
            App.toolTipMgr.hide();
        }
        
        public var txtLabel:TextField;
        
        public var dropdownMenu:DropdownMenu;
        
        private var _selectedItem:String;
        
        private var _tooltip:String = null;
        
        private var _isToolTipShowing:Boolean;
        
        override protected function configUI() : void {
            super.configUI();
            if(App.utils)
            {
                this.txtLabel.autoSize = TextFieldAutoSize.RIGHT;
                this.txtLabel.text = App.utils.locale.makeString(PROFILE.PROFILE_DROPDOWN_BATTLESTYPE);
            }
            this.tooltip = PROFILE.TOOLTIP_DROPDOWN_BATTLETYPE;
        }
        
        public function set menuProvider(param1:Array) : void {
            var _loc4_:String = null;
            var _loc2_:Array = [];
            var _loc3_:uint = param1.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = param1[_loc5_];
                _loc2_.push({
                    "label":App.utils.locale.makeString(_loc4_),
                    "key":_loc4_
                });
            _loc5_++;
        }
        this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.menuIndexChangeHandler,false,0,true);
        this.dropdownMenu.dataProvider = new DataProvider(_loc2_);
        this.dropdownMenu.validateNow();
    }
    
    public function get tooltip() : String {
        return this._tooltip;
    }
    
    public function set tooltip(param1:String) : void {
        this._tooltip = param1;
        this.disposeHandlers();
        if(this._isToolTipShowing)
        {
            hideToolTip();
            this.showToolTip();
        }
        if(this._tooltip)
        {
            this.dropdownMenu.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            this.dropdownMenu.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
        }
    }
    
    override protected function draw() : void {
        var _loc1_:IDataProvider = null;
        var _loc2_:uint = 0;
        var _loc3_:Object = null;
        var _loc4_:* = 0;
        var _loc5_:* = 0;
        super.draw();
        if(isInvalid(InvalidationType.DATA))
        {
            if(this._selectedItem)
            {
                _loc1_ = this.dropdownMenu.dataProvider;
                _loc2_ = _loc1_.length;
                _loc4_ = -1;
                _loc5_ = 0;
                while(_loc5_ < _loc2_)
                {
                    _loc3_ = _loc1_[_loc5_];
                    if(_loc3_.key == this._selectedItem)
                    {
                        _loc4_ = _loc5_;
                        break;
                    }
                    _loc5_++;
                }
                this.dropdownMenu.selectedIndex = _loc4_;
            }
        }
    }
    
    private function disposeHandlers() : void {
        this.dropdownMenu.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
        this.dropdownMenu.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
    }
    
    protected function mouseRollOverHandler(param1:MouseEvent) : void {
        this._isToolTipShowing = true;
        this.showToolTip();
    }
    
    protected function mouseRollOutHandler(param1:MouseEvent) : void {
        this._isToolTipShowing = false;
        hideToolTip();
    }
    
    private function showToolTip() : void {
        if(this._tooltip)
        {
            App.toolTipMgr.showComplex(this._tooltip);
        }
    }
    
    private function menuIndexChangeHandler(param1:ListEvent = null) : void {
        param1.stopImmediatePropagation();
        this._selectedItem = param1.itemData.key;
        dispatchEvent(new Event(Event.CHANGE));
    }
    
    public function get selectedItem() : String {
        return this._selectedItem;
    }
    
    public function set selectedItem(param1:String) : void {
        this._selectedItem = param1;
        invalidateData();
    }
    
    override protected function onDispose() : void {
        this.disposeHandlers();
        this.dropdownMenu.dispose();
        this.dropdownMenu = null;
        this.txtLabel = null;
        super.onDispose();
    }
}
}
