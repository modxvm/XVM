package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.geom.Point;
    import net.wg.data.constants.Linkages;
    import net.wg.utils.IEventCollector;
    import flash.events.Event;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.controls.CoreList;
    import scaleform.clik.events.ListEvent;
    import net.wg.data.constants.SoundTypes;
    
    public class FittingSelect extends DropdownMenu
    {
        
        public function FittingSelect()
        {
            this._availableSize = new Point();
            super();
            soundType = SoundTypes.FITTING_BUTTON;
            handleScroll = false;
        }
        
        private static var SIZE_INVALID:String = "sizeInv";
        
        public var closeOnlyClickItem:Boolean = false;
        
        private var itemClicked:Boolean = false;
        
        private var _availableSize:Point;
        
        override protected function configUI() : void
        {
            super.configUI();
            scrollBar = Linkages.SCROLL_BAR;
        }
        
        override public function close() : void
        {
            if(!selected || (this.closeOnlyClickItem) && !this.itemClicked)
            {
                return;
            }
            super.close();
            focused = 0;
            App.soundMgr.playControlsSnd("close",soundType,soundId);
            setState("up");
        }
        
        override protected function showDropdown() : void
        {
            var _loc1_:IEventCollector = null;
            super.showDropdown();
            if(_dropdownRef)
            {
                _loc1_ = App.utils.events;
                _loc1_.disableDisposingForObj(_dropdownRef);
                parent.parent.parent.addChild(_dropdownRef);
                _loc1_.enableDisposingForObj(_dropdownRef);
                this.updateDDPosition(null);
                invalidate(SIZE_INVALID);
            }
        }
        
        override protected function updateDDPosition(param1:Event) : void
        {
            super.updateDDPosition(param1);
            var _loc2_:Point = parent.parent.parent.globalToLocal(new Point(_dropdownRef.x,_dropdownRef.y));
            _dropdownRef.x = _loc2_.x;
            _dropdownRef.y = _loc2_.y;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:IListItemRenderer = null;
            if(_baseDisposed)
            {
                return;
            }
            super.draw();
            if(isInvalid(SIZE_INVALID,InvalidationType.DATA))
            {
                _loc1_ = 58;
                if((_dropdownRef) && (_dropdownRef as CoreList))
                {
                    _loc4_ = (_dropdownRef as CoreList).getRendererAt(0);
                    if(_loc4_)
                    {
                        _loc1_ = _loc4_.height;
                    }
                }
                _loc2_ = menuPadding?menuPadding.top + menuPadding.bottom:0;
                _loc3_ = 15;
                rowCount = Math.floor((this._availableSize.y - _loc2_ - _loc3_) / _loc1_);
            }
        }
        
        override protected function handleMenuItemClick(param1:ListEvent) : void
        {
            selectedIndex = param1.index;
            this.itemClicked = true;
            this.close();
            this.itemClicked = false;
        }
        
        override protected function hideDropdown() : void
        {
            App.toolTipMgr.hide();
            super.hideDropdown();
        }
        
        public function updateAvailableSize(param1:Number, param2:Number) : void
        {
            this._availableSize.x = param1;
            this._availableSize.y = param2;
            invalidate(SIZE_INVALID);
        }
    }
}
