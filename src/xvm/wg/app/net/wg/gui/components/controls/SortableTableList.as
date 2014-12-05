package net.wg.gui.components.controls
{
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.interfaces.IListItemRenderer;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.SortingEvent;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.IDAAPISortable;
    import scaleform.clik.data.ListData;
    import flash.display.Sprite;
    
    public class SortableTableList extends SortableScrollingList
    {
        
        public function SortableTableList()
        {
            super();
        }
        
        public static var INV_SElECTED_RENDERER:String = "invSelRend";
        
        private var oldSelectedItem:Object = null;
        
        private var isSortingTheLastActivity:Boolean;
        
        private var isDataProviderReceived:Boolean;
        
        private var _uniqKeyForAutoSelect:String = "";
        
        private var _lastSelectedUniqValue:Object = null;
        
        private var _isSelectable:Boolean = true;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.addEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler,false,0,true);
        }
        
        override protected function updateSelectedIndex() : void
        {
            super.updateSelectedIndex();
            invalidate(INV_SElECTED_RENDERER);
        }
        
        private function layoutSelectedRenderers() : void
        {
            var _loc1_:IListItemRenderer = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(_renderers)
            {
                _loc1_ = null;
                _loc2_ = 0;
                while(_loc2_ < _renderers.length)
                {
                    container.setChildIndex(_renderers[_loc2_] as DisplayObject,_loc2_);
                    if(_renderers[_loc2_].selected)
                    {
                        _loc1_ = _renderers[_loc2_];
                    }
                    _loc2_++;
                }
                if(_loc1_)
                {
                    _loc3_ = container.numChildren - 1;
                    container.setChildIndex(_loc1_ as DisplayObject,_loc3_);
                }
            }
        }
        
        override protected function handleItemClick(param1:ButtonEvent) : void
        {
            super.handleItemClick(param1);
            this.isSortingTheLastActivity = false;
        }
        
        private function indexChangedHandler(param1:ListEvent) : void
        {
            if(this._isSelectable)
            {
                if(!this.isSortingTheLastActivity)
                {
                    dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
                }
            }
            else
            {
                param1.stopImmediatePropagation();
                this.resetSelectedItem();
                validateNow();
            }
        }
        
        override public function set dataProvider(param1:IDataProvider) : void
        {
            this.isSortingTheLastActivity = false;
            this.isDataProviderReceived = true;
            this.invalidateSorting(_sortProps);
            if(_dataProvider == param1)
            {
                return;
            }
            if(_dataProvider != null)
            {
                _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
            }
            _dataProvider = param1;
            if(_dataProvider == null)
            {
                return;
            }
            _dataProvider.addEventListener(Event.CHANGE,handleDataChange,false,0,true);
            invalidateData();
        }
        
        public function resetSelectedItem() : void
        {
            this.oldSelectedItem = null;
            this._lastSelectedUniqValue = null;
            selectedIndex = -1;
        }
        
        override protected function applySorting(param1:Array) : void
        {
            super.applySorting(param1);
            var _loc2_:* = -1;
            if(this._isSelectable)
            {
                if((_dataProvider) && _dataProvider is IDAAPISortable)
                {
                    _newSelectedIndex = IDAAPISortable(_dataProvider).getDAAPIselectedIdx();
                    invalidateSelectedIndex();
                }
                else
                {
                    _newSelectedIndex = this.checkSelectedItem(_loc2_);
                    invalidateSelectedIndex();
                }
            }
            else
            {
                _newSelectedIndex = _loc2_;
                invalidateSelectedIndex();
            }
        }
        
        private function checkSelectedItem(param1:int) : int
        {
            var _loc4_:Object = null;
            var _loc2_:uint = dataProvider.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = dataProvider[_loc3_];
                if((this.oldSelectedItem) && (_loc4_) && this.oldSelectedItem == _loc4_)
                {
                    param1 = _loc3_;
                    break;
                }
                if((this._uniqKeyForAutoSelect) && (_loc4_) && (_loc4_.hasOwnProperty(this._uniqKeyForAutoSelect)))
                {
                    if(this._lastSelectedUniqValue == _loc4_[this._uniqKeyForAutoSelect])
                    {
                        param1 = _loc3_;
                        break;
                    }
                }
                _loc3_++;
            }
            return param1;
        }
        
        override protected function draw() : void
        {
            this.isSortingTheLastActivity = false;
            if((this.isDataProviderReceived) && (this._isSelectable))
            {
                this.isDataProviderReceived = false;
                dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
            }
            if(isInvalid(INV_SElECTED_RENDERER))
            {
                this.layoutSelectedRenderers();
            }
            super.draw();
        }
        
        public function get selectedItem() : Object
        {
            if((dataProvider) && dataProvider.length > 0)
            {
                return dataProvider.requestItemAt(selectedIndex);
            }
            return null;
        }
        
        override protected function invalidateSorting(param1:Object) : void
        {
            this.updateOldSelected(_selectedIndex);
            super.invalidateSorting(param1);
            this.isSortingTheLastActivity = true;
            invalidate(SORTING_INVALID);
        }
        
        private function updateOldSelected(param1:int) : void
        {
            var _loc2_:IListItemRenderer = getRendererAt(param1);
            if(_loc2_)
            {
                this.oldSelectedItem = _dataProvider[param1];
                if((this._uniqKeyForAutoSelect) && (this.oldSelectedItem) && (this.oldSelectedItem.hasOwnProperty(this._uniqKeyForAutoSelect)))
                {
                    this._lastSelectedUniqValue = this.oldSelectedItem[this._uniqKeyForAutoSelect];
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this._lastSelectedUniqValue = null;
            this.oldSelectedItem = null;
            this.removeEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler);
            super.onDispose();
        }
        
        public function selectedItemByUniqKey(param1:String, param2:Object) : void
        {
            var _loc3_:int = this.findItemIndex(param2,param1);
            if(_loc3_ > -1)
            {
                _newSelectedIndex = _loc3_;
                scrollToIndex(_newSelectedIndex);
                invalidateSelectedIndex();
            }
        }
        
        public function scrollToItemByUniqKey(param1:String, param2:Object) : void
        {
            var _loc3_:int = this.findItemIndex(param2,param1);
            if(_loc3_ > -1)
            {
                scrollToIndex(_loc3_);
            }
        }
        
        private function findItemIndex(param1:Object, param2:String) : int
        {
            var _loc3_:* = -1;
            var _loc4_:uint = dataProvider.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                if(param1 == dataProvider[_loc5_][param2])
                {
                    _loc3_ = _loc5_;
                    break;
                }
                _loc5_++;
            }
            return _loc3_;
        }
        
        override protected function populateData(param1:Array) : void
        {
            var _loc5_:IListItemRenderer = null;
            var _loc6_:* = 0;
            var _loc7_:ListData = null;
            var _loc8_:ITableRenderer = null;
            var _loc9_:Sprite = null;
            var _loc2_:int = param1.length;
            var _loc3_:int = _renderers.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = getRendererAt(_loc4_);
                _loc6_ = _scrollPosition + _loc4_;
                _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
                _loc5_.enabled = !(_loc4_ >= _loc2_);
                _loc5_.setListData(_loc7_);
                _loc8_ = _loc5_ as ITableRenderer;
                if(_loc8_)
                {
                    _loc8_.isPassive = !this._isSelectable;
                }
                _loc5_.setData(param1[_loc4_]);
                _loc5_.validateNow();
                _loc9_ = _loc5_ as Sprite;
                _loc9_.buttonMode = (_buttonModeEnabled) && (_loc5_.enabled);
                _loc4_++;
            }
        }
        
        override protected function drawScrollBar() : void
        {
            super.drawScrollBar();
            _scrollBar.x = _width - _scrollBar.width - margin - sbPadding.right;
        }
        
        public function get uniqKeyForAutoSelect() : String
        {
            return this._uniqKeyForAutoSelect;
        }
        
        public function set uniqKeyForAutoSelect(param1:String) : void
        {
            this._uniqKeyForAutoSelect = param1;
        }
        
        public function get isSelectable() : Boolean
        {
            return this._isSelectable;
        }
        
        public function set isSelectable(param1:Boolean) : void
        {
            this._isSelectable = param1;
        }
        
        override public function toString() : String
        {
            return "[WG SortableTableList " + name + "]";
        }
    }
}
