package net.wg.gui.lobby.profile.pages.technique
{
    import net.wg.gui.components.controls.SortableScrollingList;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.utils.getQualifiedClassName;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.constants.InvalidationType;
    
    public class TechniqueList extends SortableScrollingList
    {
        
        public function TechniqueList()
        {
            super();
        }
        
        public static var NATION_INDEX:String = "nationIndex";
        
        public static var TYPE_INDEX:String = "typeIndex";
        
        public static var SHORT_USER_NAME:String = "shortUserName";
        
        public static var BATTLES_COUNT:String = "battlesCount";
        
        public static var WINS_EFFICIENCY:String = "winsEfficiency";
        
        public static var AVG_EXPERIENCE:String = "avgExperience";
        
        public static var MARK_OF_MASTERY:String = "markOfMastery";
        
        public static var LEVEL:String = "level";
        
        public static var SELECTED_DATA_CHANGED:String = "selDataChanged";
        
        private var isValidationChecked:Boolean;
        
        private var oldSelectedItemId:int = -1;
        
        private var isSortingTheLastActivity:Boolean;
        
        private var isDataProviderReceived:Boolean;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.addEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler,false,0,true);
        }
        
        override protected function handleItemClick(param1:ButtonEvent) : void
        {
            super.handleItemClick(param1);
            this.isSortingTheLastActivity = false;
        }
        
        private function indexChangedHandler(param1:ListEvent) : void
        {
            if(!this.isSortingTheLastActivity)
            {
                dispatchEvent(new Event(SELECTED_DATA_CHANGED));
            }
        }
        
        override public function set dataProvider(param1:IDataProvider) : void
        {
            var _loc2_:Vector.<String> = null;
            var _loc3_:Object = null;
            var _loc4_:String = null;
            this.isSortingTheLastActivity = false;
            this.isDataProviderReceived = true;
            super.dataProvider = param1;
            if(!this.isValidationChecked)
            {
                if((param1) && param1.length > 0)
                {
                    this.isValidationChecked = true;
                    _loc2_ = new Vector.<String>();
                    _loc2_.push(NATION_INDEX);
                    _loc2_.push(TYPE_INDEX);
                    _loc2_.push(SHORT_USER_NAME);
                    _loc2_.push(BATTLES_COUNT);
                    _loc2_.push(WINS_EFFICIENCY);
                    _loc2_.push(AVG_EXPERIENCE);
                    _loc2_.push(MARK_OF_MASTERY);
                    _loc2_.push(LEVEL);
                    _loc3_ = param1[0];
                    for each(_loc4_ in _loc2_)
                    {
                        App.utils.asserter.assert(_loc3_.hasOwnProperty(_loc4_),"There is no property \'" + _loc4_ + "\' in the " + getQualifiedClassName(_loc3_) + " to apply sort operation! " + getQualifiedClassName(this));
                    }
                }
            }
        }
        
        override protected function applySorting(param1:Array) : void
        {
            var _loc4_:TechniqueListVehicleVO = null;
            super.applySorting(param1);
            var _loc2_:* = -1;
            var _loc3_:uint = dataProvider.length;
            if(_loc3_ > 0)
            {
                _loc2_ = 0;
            }
            var _loc5_:* = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = dataProvider[_loc5_];
                if(this.oldSelectedItemId == _loc4_.id)
                {
                    _loc2_ = _loc5_;
                    break;
                }
                _loc5_++;
            }
            _newSelectedIndex = _loc2_;
            invalidateSelectedIndex();
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.isSortingTheLastActivity = false;
            if(this.isDataProviderReceived)
            {
                this.isDataProviderReceived = false;
                dispatchEvent(new Event(SELECTED_DATA_CHANGED));
            }
        }
        
        public function get selectedItem() : Object
        {
            if((dataProvider) && dataProvider.length > 0)
            {
                return dataProvider[selectedIndex];
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
            var _loc3_:TechniqueListVehicleVO = null;
            var _loc2_:IListItemRenderer = getRendererAt(param1);
            if(_loc2_)
            {
                _loc3_ = TechniqueListVehicleVO(_dataProvider[param1]);
                if(_loc3_)
                {
                    this.oldSelectedItemId = _loc3_.id;
                }
                else
                {
                    this.oldSelectedItemId = -100;
                }
            }
        }
        
        override protected function drawLayout() : void
        {
            var _loc8_:IListItemRenderer = null;
            var _loc1_:uint = _renderers.length;
            var _loc2_:Number = rowHeight;
            var _loc3_:Number = availableWidth - padding.horizontal;
            var _loc4_:Number = margin + padding.left;
            var _loc5_:Number = margin + padding.top;
            var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
            var _loc7_:uint = 0;
            while(_loc7_ < _loc1_)
            {
                _loc8_ = getRendererAt(_loc7_);
                _loc8_.x = Math.round(_loc4_);
                _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
                _loc8_.width = _loc3_;
                if(!_loc6_)
                {
                    _loc8_.validateNow();
                }
                _loc7_++;
            }
            drawScrollBar();
        }
        
        override protected function onDispose() : void
        {
            this.removeEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler);
            super.onDispose();
        }
        
        public function set selectedVehIntCD(param1:int) : void
        {
            var _loc4_:TechniqueListVehicleVO = null;
            this.oldSelectedItemId = param1;
            var _loc2_:* = -1;
            var _loc3_:uint = dataProvider.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = dataProvider[_loc5_];
                if(param1 == _loc4_.id)
                {
                    _loc2_ = _loc5_;
                    break;
                }
                _loc5_++;
            }
            _selectedIndex = _newSelectedIndex = _loc2_;
            scrollToIndex(_selectedIndex);
            invalidateSelectedIndex();
        }
    }
}
