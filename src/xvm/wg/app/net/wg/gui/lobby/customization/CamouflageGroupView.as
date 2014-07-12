package net.wg.gui.lobby.customization
{
    import flash.text.TextField;
    import scaleform.clik.events.ListEvent;
    import flash.events.Event;
    
    public class CamouflageGroupView extends BaseTimedCustomizationGroupView
    {
        
        public function CamouflageGroupView() {
            super();
        }
        
        public var hintLabel:TextField;
        
        private var defaultLbl:String = "";
        
        private var _isIgrPeriod:Boolean;
        
        private var _igrSelectedIndex:int = -1;
        
        private var _selectedIndex:int = -1;
        
        override public function get selectedItemIdx() : int {
            return this._isIgrPeriod?this._igrSelectedIndex:this._selectedIndex;
        }
        
        override public function set selectedItemIdx(param1:int) : void {
            if(this._isIgrPeriod)
            {
                this._igrSelectedIndex = param1;
            }
            else
            {
                this._selectedIndex = param1;
            }
        }
        
        public function setDefaultLabel(param1:String) : void {
            this.defaultLbl = param1;
            this.hintLabel.htmlText = this.defaultLbl;
        }
        
        override protected function handlePeriodDaysItemChange(param1:ListEvent) : void {
            var _loc2_:Object = rentalPackageDP.requestItemAt(param1.index);
            this._isIgrPeriod = (_loc2_) && (_loc2_.isIGR);
            super.handlePeriodDaysItemChange(param1);
            list.selectedIndex = this.selectedItemIdx;
        }
        
        override protected function handleItemDataChanged(param1:Event = null) : void {
            var _loc2_:Object = null;
            var _loc3_:CustomizationEvent = null;
            this.hintLabel.htmlText = this.defaultLbl;
            if(this.selectedItemIdx > -1)
            {
                _loc2_ = itemsDP.requestItemAt(this.selectedItemIdx);
                if((_loc2_) && (_loc2_.id) && selectedPriceIdx > -1)
                {
                    _loc3_ = new CustomizationEvent(CustomizationEvent.SELECT_NEW);
                    _loc3_.data = _loc2_;
                    _loc3_.index = this.selectedItemIdx;
                    dispatchEvent(_loc3_);
                    this.hintLabel.htmlText = _loc2_.invisibilityLbl;
                }
            }
        }
    }
}
