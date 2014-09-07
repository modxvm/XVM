package net.wg.gui.components.controls
{
    import scaleform.clik.controls.ScrollingList;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.DisplayObject;
    import scaleform.clik.data.ListData;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.WrappingMode;
    import scaleform.clik.constants.NavigationCode;
    
    public class ScrollingListAutoScroll extends ScrollingList
    {
        
        public function ScrollingListAutoScroll()
        {
            super();
        }
        
        private var scrollBarNeeded:Boolean = false;
        
        override protected function drawLayout() : void
        {
            var _loc8_:IListItemRenderer = null;
            this.scrollBarNeeded = (dataProvider) && dataProvider.length > rowCount;
            var _loc1_:uint = _renderers.length;
            var _loc2_:Number = rowHeight;
            var _loc3_:Number = this.availableWidth - padding.horizontal;
            var _loc4_:Number = margin + padding.left;
            var _loc5_:Number = margin + padding.top;
            var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
            var _loc7_:uint = 0;
            while(_loc7_ < _loc1_)
            {
                _loc8_ = getRendererAt(_loc7_);
                _loc8_.x = _loc4_;
                _loc8_.y = _loc5_ + _loc7_ * _loc2_;
                _loc8_.width = _loc3_;
                _loc8_.height = _loc2_;
                if(!_loc6_)
                {
                    _loc8_.validateNow();
                }
                _loc7_++;
            }
            this.drawScrollBar();
        }
        
        override protected function drawScrollBar() : void
        {
            super.drawScrollBar();
            if(_scrollBar)
            {
                (_scrollBar as DisplayObject).visible = this.scrollBarNeeded;
                if(container.contains(_scrollBar as DisplayObject))
                {
                    container.addChild(_scrollBar as DisplayObject);
                }
            }
        }
        
        override public function get availableWidth() : Number
        {
            return Math.round(_width) - margin * 2 - (this.scrollBarNeeded?Math.round(_scrollBar.width):0);
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            var _loc4_:IListItemRenderer = null;
            super.enabled = param1;
            setState(super.enabled?"default":"disabled");
            if(_renderers != null)
            {
                _loc2_ = _renderers.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    _loc4_ = getRendererAt(_loc3_);
                    _loc4_.enabled = (enabled) && (_loc4_.getData()) && (_loc4_.getData().enabled);
                    _loc3_++;
                }
            }
        }
        
        override protected function populateData(param1:Array) : void
        {
            var _loc5_:IListItemRenderer = null;
            var _loc6_:uint = 0;
            var _loc7_:ListData = null;
            var _loc2_:uint = param1.length;
            var _loc3_:uint = _renderers.length;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = getRendererAt(_loc4_);
                _loc6_ = _scrollPosition + _loc4_;
                _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
                _loc5_.enabled = _loc4_ >= _loc2_?false:enabled;
                _loc5_.setListData(_loc7_);
                _loc5_.setData(param1[_loc4_]);
                _loc5_.validateNow();
                _loc4_++;
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            var _loc3_:* = 0;
            if(param1.handled)
            {
                return;
            }
            var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex,_scrollPosition);
            if(_loc2_ != null)
            {
                _loc2_.handleInput(param1);
                if(param1.handled)
                {
                    return;
                }
            }
            var _loc4_:InputDetails = param1.details;
            var _loc5_:Boolean = _loc4_.value == InputValue.KEY_DOWN || _loc4_.value == InputValue.KEY_HOLD;
            switch(_loc4_.navEquivalent)
            {
                case NavigationCode.UP:
                    if(selectedIndex == -1)
                    {
                        if((_loc5_) && (this.canMoveSelectionTo(scrollPosition + _totalRenderers - 1)))
                        {
                            selectedIndex = scrollPosition + _totalRenderers - 1;
                        }
                    }
                    else if(_selectedIndex > 0)
                    {
                        if((_loc5_) && (this.canMoveSelectionTo(selectedIndex - 1)))
                        {
                            selectedIndex--;
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if((_loc5_) && (this.canMoveSelectionTo(_dataProvider.length - 1)))
                            {
                                selectedIndex = _dataProvider.length - 1;
                            }
                        }
                        else
                        {
                            return;
                        }
                    }
                    
                    
                    break;
                case NavigationCode.DOWN:
                    if(_selectedIndex == -1)
                    {
                        if((_loc5_) && (this.canMoveSelectionTo(_scrollPosition)))
                        {
                            selectedIndex = _scrollPosition;
                        }
                    }
                    else if(_selectedIndex < _dataProvider.length - 1)
                    {
                        if((_loc5_) && (this.canMoveSelectionTo(selectedIndex + 1)))
                        {
                            selectedIndex++;
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if((_loc5_) && (this.canMoveSelectionTo(0)))
                            {
                                selectedIndex = 0;
                            }
                        }
                        else
                        {
                            return;
                        }
                    }
                    
                    
                    break;
                case NavigationCode.END:
                    if(!_loc5_)
                    {
                        _loc3_ = _dataProvider.length - 1;
                        while(_loc3_ > selectedIndex)
                        {
                            if(this.canMoveSelectionTo(_loc3_))
                            {
                                selectedIndex = _loc3_;
                                break;
                            }
                            _loc3_--;
                        }
                    }
                    break;
                case NavigationCode.HOME:
                    if(!_loc5_)
                    {
                        _loc3_ = 0;
                        while(_loc3_ < selectedIndex)
                        {
                            if(this.canMoveSelectionTo(_loc3_))
                            {
                                selectedIndex = _loc3_;
                                break;
                            }
                            _loc3_++;
                        }
                    }
                    break;
                case NavigationCode.PAGE_UP:
                    if(_loc5_)
                    {
                        _loc3_ = _totalRenderers;
                        while(_loc3_ > 0)
                        {
                            if(this.canMoveSelectionTo(Math.max(0,selectedIndex - _loc3_)))
                            {
                                selectedIndex = Math.max(0,selectedIndex - _loc3_);
                                break;
                            }
                            _loc3_--;
                        }
                    }
                    break;
                case NavigationCode.PAGE_DOWN:
                    if(_loc5_)
                    {
                        _loc3_ = _totalRenderers;
                        while(_loc3_ > 0)
                        {
                            if(this.canMoveSelectionTo(Math.min(_dataProvider.length - 1,selectedIndex + _loc3_)))
                            {
                                selectedIndex = Math.min(_dataProvider.length - 1,selectedIndex + _loc3_);
                                break;
                            }
                            _loc3_--;
                        }
                    }
                    break;
                default:
                    return;
            }
            param1.handled = true;
        }
        
        private function canMoveSelectionTo(param1:int) : Boolean
        {
            var _loc2_:Object = dataProvider.requestItemAt(param1);
            if((_loc2_) && (_loc2_.hasOwnProperty("enabled")))
            {
                return _loc2_.enabled;
            }
            return true;
        }
    }
}
