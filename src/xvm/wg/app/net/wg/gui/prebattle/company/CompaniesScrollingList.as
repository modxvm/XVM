package net.wg.gui.prebattle.company
{
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.events.ListEventEx;
    import scaleform.gfx.MouseEventEx;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.ScrollBar;
    import scaleform.clik.data.ListData;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.WrappingMode;
    import scaleform.clik.constants.NavigationCode;
    
    public class CompaniesScrollingList extends ScrollingListEx
    {
        
        public function CompaniesScrollingList()
        {
            super();
            tabEnabled = true;
            focusable = true;
            this.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandler);
            this.addEventListener(CompanyEvent.SELECTED_ITEM,this.selectedItemHandler);
            this.addEventListener(MouseEvent.CLICK,this.buttonClickHandler);
            this.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.buttonDoubleClickHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.clickHandler);
        }
        
        private var _setIndexCompany:int = -1;
        
        private var showPlayersList:Boolean = false;
        
        private var isItemSelected:Boolean = false;
        
        private function buttonDoubleClickHandler(param1:ListEventEx) : void
        {
            var _loc2_:CompanyEvent = null;
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                _loc2_ = new CompanyEvent(CompanyEvent.DROP_LIST_CLICK,true);
                _loc2_.prbID = param1.itemData.prbID;
                dispatchEvent(_loc2_);
            }
        }
        
        public function get isOpenedState() : Boolean
        {
            var _loc3_:CompanyListItemRenderer = null;
            var _loc1_:int = _renderers.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = getRendererAt(_loc2_) as CompanyListItemRenderer;
                if(_loc3_.selected)
                {
                    return true;
                }
                _loc2_++;
            }
            return false;
        }
        
        public function updateRenderer() : void
        {
            refreshData();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            App.utils.scheduler.cancelTask(this.updateRenderer);
            this.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandler);
            this.removeEventListener(CompanyEvent.SELECTED_ITEM,this.selectedItemHandler);
            this.removeEventListener(MouseEvent.CLICK,this.buttonClickHandler);
            this.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.buttonDoubleClickHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickHandler);
        }
        
        private function clickHandler(param1:MouseEvent) : void
        {
            var _loc2_:ScrollBar = null;
            if((scrollBar) && (scrollBar.hitTestPoint(param1.stageX,param1.stageY)))
            {
                _loc2_ = ScrollBar(scrollBar);
                if((_loc2_.upArrowWg.hitTestPoint(param1.stageX,param1.stageY)) && !_loc2_.upArrowWg.enabled)
                {
                    this.unselectedRenderers();
                }
                if((_loc2_.downArrowWg.hitTestPoint(param1.stageX,param1.stageY)) && !_loc2_.downArrowWg.enabled)
                {
                    this.unselectedRenderers();
                }
            }
        }
        
        public function unselectedRenderers() : void
        {
            var _loc3_:CompanyListItemRenderer = null;
            this.isItemSelected = false;
            var _loc1_:int = _renderers.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = getRendererAt(_loc2_) as CompanyListItemRenderer;
                _loc3_.selected = false;
                _loc2_++;
            }
        }
        
        private function buttonClickHandler(param1:MouseEvent) : void
        {
            if(param1.target is CompaniesScrollingList)
            {
                this.isItemSelected = false;
                App.utils.scheduler.scheduleTask(this.updateRenderer,110);
            }
        }
        
        private function selectedItemHandler(param1:CompanyEvent) : void
        {
            this.isItemSelected = param1.isSelected;
        }
        
        public function set setIndexCompany(param1:uint) : void
        {
            this._setIndexCompany = int(param1);
        }
        
        private function isShowPlayersList() : Boolean
        {
            return !(this._setIndexCompany == -1) && this._setIndexCompany >= _scrollPosition && this._setIndexCompany <= _scrollPosition + _totalRenderers;
        }
        
        private function focusOutHandler(param1:FocusEvent) : void
        {
            this.isItemSelected = false;
            App.utils.scheduler.scheduleTask(this.updateRenderer,110);
        }
        
        override protected function populateData(param1:Array) : void
        {
            var _loc5_:CompanyListItemRenderer = null;
            var _loc6_:* = 0;
            var _loc7_:* = false;
            var _loc8_:ListData = null;
            var _loc9_:* = false;
            this.showPlayersList = this.isShowPlayersList();
            var _loc2_:int = param1.length;
            var _loc3_:int = _renderers.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = getRendererAt(_loc4_) as CompanyListItemRenderer;
                if(_loc5_)
                {
                    _loc6_ = _scrollPosition + _loc4_;
                    _loc7_ = this.isItemSelected?_selectedIndex == _loc6_:false;
                    if(!_loc7_ && (_loc5_.dd.isOpen()))
                    {
                        _loc5_.dd.close();
                    }
                    _loc8_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_loc7_);
                    _loc5_.enabled = _loc4_ >= _loc2_?false:true;
                    _loc5_.setListData(_loc8_);
                    _loc9_ = (this.showPlayersList) && _loc6_ == this._setIndexCompany && (this.isItemSelected);
                    CompanyListItemRenderer(_loc5_).showPlayersList(_loc9_);
                    _loc5_.setData(param1[_loc4_]);
                    _loc5_.refreshPopulateData(this.updateRenderer);
                    _loc5_.validateNow();
                }
                _loc4_++;
            }
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
                            scrollPosition = scrollPosition + _totalRenderers - 1;
                        }
                    }
                    else if(_selectedIndex > 0)
                    {
                        if(_loc4_)
                        {
                            scrollPosition--;
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if(_loc4_)
                            {
                                scrollPosition = _dataProvider.length - 1;
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
                            scrollPosition = _scrollPosition;
                        }
                    }
                    else if(_selectedIndex < _dataProvider.length - 1)
                    {
                        if(_loc4_)
                        {
                            scrollPosition++;
                        }
                    }
                    else if(wrapping != WrappingMode.STICK)
                    {
                        if(wrapping == WrappingMode.WRAP)
                        {
                            if(_loc4_)
                            {
                                scrollPosition = 0;
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
                        scrollPosition = _dataProvider.length - 1;
                    }
                    break;
                case NavigationCode.HOME:
                    if(!_loc4_)
                    {
                        scrollPosition = 0;
                    }
                    break;
                case NavigationCode.PAGE_UP:
                    if(_loc4_)
                    {
                        scrollList(_totalRenderers);
                    }
                    break;
                case NavigationCode.PAGE_DOWN:
                    if(_loc4_)
                    {
                        scrollList(-_totalRenderers);
                    }
                    break;
                default:
                    return;
            }
            param1.handled = true;
        }
    }
}
