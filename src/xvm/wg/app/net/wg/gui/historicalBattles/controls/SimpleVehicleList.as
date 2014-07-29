package net.wg.gui.historicalBattles.controls
{
    import net.wg.gui.components.controls.ScrollingListEx;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.WrappingMode;
    import scaleform.clik.constants.NavigationCode;
    
    public class SimpleVehicleList extends ScrollingListEx
    {
        
        public function SimpleVehicleList()
        {
            super();
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
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
            var _loc3_:InputDetails = param1.details;
            var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
            switch(_loc3_.navEquivalent)
            {
                case NavigationCode.UP:
                    if(selectedIndex == -1)
                    {
                        if(_loc4_)
                        {
                            selectedIndex = this.getFirstSelectablePosition(scrollPosition + _totalRenderers - 1,false);
                        }
                    }
                    else if(_selectedIndex > this.getFirstSelectablePosition(0,true))
                    {
                        if(_loc4_)
                        {
                            selectedIndex = this.getFirstSelectablePosition(selectedIndex - 1,false);
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if(_loc4_)
                            {
                                selectedIndex = this.getFirstSelectablePosition(_dataProvider.length - 1,false);
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
                        if(_loc4_)
                        {
                            selectedIndex = this.getFirstSelectablePosition(_scrollPosition,true);
                        }
                    }
                    else if(_selectedIndex < this.getFirstSelectablePosition(_dataProvider.length - 1,false))
                    {
                        if(_loc4_)
                        {
                            selectedIndex = this.getFirstSelectablePosition(selectedIndex + 1,true);
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if(_loc4_)
                            {
                                selectedIndex = this.getFirstSelectablePosition(0,true);
                            }
                        }
                        else
                        {
                            return;
                        }
                    }
                    
                    
                    break;
                case NavigationCode.END:
                    if(!_loc4_)
                    {
                        selectedIndex = this.getFirstSelectablePosition(_dataProvider.length - 1,false);
                    }
                    break;
                case NavigationCode.HOME:
                    if(!_loc4_)
                    {
                        selectedIndex = this.getFirstSelectablePosition(0,true);
                    }
                    break;
                case NavigationCode.PAGE_UP:
                    if(_loc4_)
                    {
                        selectedIndex = this.getFirstSelectablePosition(Math.max(0,_selectedIndex - _totalRenderers),true);
                    }
                    break;
                case NavigationCode.PAGE_DOWN:
                    if(_loc4_)
                    {
                        selectedIndex = this.getFirstSelectablePosition(Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers),false);
                    }
                    break;
                default:
                    return;
            }
            param1.handled = true;
        }
        
        public function getFirstSelectablePosition(param1:int, param2:Boolean = true) : int
        {
            var _loc3_:int = selectedIndex;
            var _loc4_:int = param1;
            var _loc5_:int = _dataProvider?_dataProvider.length:0;
            var _loc6_:int = param2?1:-1;
            while(_loc4_ >= 0 && _loc4_ < _loc5_)
            {
                if(!this.checkIsItemDisabled(_dataProvider.requestItemAt(_loc4_)))
                {
                    _loc3_ = _loc4_;
                    break;
                }
                _loc4_ = _loc4_ + _loc6_;
            }
            return _loc3_;
        }
        
        protected function checkIsItemDisabled(param1:Object) : Boolean
        {
            var _loc2_:* = false;
            if(!param1 || (param1.hasOwnProperty("enabled")) && !param1["enabled"])
            {
                _loc2_ = true;
            }
            return _loc2_;
        }
    }
}
