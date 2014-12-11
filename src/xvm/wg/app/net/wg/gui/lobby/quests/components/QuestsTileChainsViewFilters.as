package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropDownImageText;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewFiltersVO;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.quests.events.QuestsTileChainViewFiltersEvent;
    import flash.events.Event;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    
    public class QuestsTileChainsViewFilters extends UIComponent implements IFocusChainContainer
    {
        
        public function QuestsTileChainsViewFilters()
        {
            super();
            this.vehicleTypeFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChange);
            this.taskTypeFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChange);
            this.hideCompletedTasks.addEventListener(Event.SELECT,this.onHideCompletedTasksSelect);
        }
        
        private static var LEFT_MARGIN:Number = 19;
        
        private static var LABEL_FILTERS_GAP:Number = 9;
        
        private static var FILTERS_GAP:Number = 5;
        
        private static var FILTERS_CHECKBOX_GAP:Number = 14;
        
        public var filtersLabelTf:TextField;
        
        public var vehicleTypeFilter:DropDownImageText;
        
        public var taskTypeFilter:DropdownMenu;
        
        public var hideCompletedTasks:CheckBox;
        
        private var _data:QuestsTileChainsViewFiltersVO;
        
        private var _blockFiltersChangedEvent:Boolean = false;
        
        private function onDropDownIndexChange(param1:ListEvent) : void
        {
            if(!this._blockFiltersChangedEvent)
            {
                dispatchEvent(new QuestsTileChainViewFiltersEvent(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED));
            }
        }
        
        private function onHideCompletedTasksSelect(param1:Event) : void
        {
            if(!this._blockFiltersChangedEvent)
            {
                dispatchEvent(new QuestsTileChainViewFiltersEvent(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED));
            }
        }
        
        public function setData(param1:QuestsTileChainsViewFiltersVO) : void
        {
            var _loc3_:* = 0;
            this._blockFiltersChangedEvent = true;
            this._data = param1;
            this.hideCompletedTasks.label = param1.hideCompletedTaskText;
            this.vehicleTypeFilter.dataProvider = new DataProvider(param1.vehicleTypeFilterData);
            this.taskTypeFilter.dataProvider = new DataProvider(param1.taskTypeFilterData);
            var _loc2_:int = this.indexOfObjectByProp(param1.vehicleTypeFilterData,"data",param1.defVehicleType);
            if(_loc2_ >= 0)
            {
                this.vehicleTypeFilter.selectedIndex = _loc2_;
            }
            if(!(param1.defTaskType == null) && param1.defTaskType.length > 0)
            {
                _loc3_ = this.indexOfObjectByProp(param1.taskTypeFilterData,"data",param1.defTaskType);
                if(_loc3_ >= 0)
                {
                    this.taskTypeFilter.selectedIndex = _loc3_;
                }
            }
            this.hideCompletedTasks.selected = param1.hideCompleted;
            invalidateData();
            this._blockFiltersChangedEvent = false;
        }
        
        private function indexOfObjectByProp(param1:Array, param2:String, param3:*) : int
        {
            var _loc5_:Object = null;
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc5_ = param1[_loc4_];
                if(_loc5_[param2] == param3)
                {
                    return _loc4_;
                }
                _loc4_++;
            }
            return -1;
        }
        
        public function get selectedVehicleType() : int
        {
            var _loc1_:Object = null;
            if(this.vehicleTypeFilter.selectedIndex >= 0)
            {
                _loc1_ = this.vehicleTypeFilter.dataProvider.requestItemAt(this.vehicleTypeFilter.selectedIndex);
            }
            return _loc1_ != null?_loc1_.data:-1;
        }
        
        public function get selectedTaskType() : String
        {
            var _loc1_:Object = null;
            if(this.taskTypeFilter.selectedIndex >= 0)
            {
                _loc1_ = this.taskTypeFilter.dataProvider.requestItemAt(this.taskTypeFilter.selectedIndex);
            }
            return _loc1_ != null?_loc1_.data as String:null;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && !(this._data == null))
            {
                this.filtersLabelTf.htmlText = this._data.filtersLabel;
                this.layoutComponents();
            }
        }
        
        private function layoutComponents() : void
        {
            var _loc1_:* = NaN;
            _loc1_ = LEFT_MARGIN;
            this.filtersLabelTf.x = Math.round(_loc1_);
            _loc1_ = _loc1_ + (this.filtersLabelTf.textWidth + LABEL_FILTERS_GAP);
            this.vehicleTypeFilter.x = Math.round(_loc1_);
            _loc1_ = _loc1_ + (this.vehicleTypeFilter.width + FILTERS_GAP);
            this.taskTypeFilter.x = Math.round(_loc1_);
            _loc1_ = _loc1_ + (this.taskTypeFilter.width + FILTERS_CHECKBOX_GAP);
            this.hideCompletedTasks.x = Math.round(_loc1_);
        }
        
        override protected function onDispose() : void
        {
            this.vehicleTypeFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChange);
            this.taskTypeFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownIndexChange);
            this.hideCompletedTasks.removeEventListener(Event.SELECT,this.onHideCompletedTasksSelect);
            this.vehicleTypeFilter.dispose();
            this.taskTypeFilter.dispose();
            this.hideCompletedTasks.dispose();
            this.vehicleTypeFilter = null;
            this.taskTypeFilter = null;
            this.hideCompletedTasks = null;
            this.filtersLabelTf = null;
            this._data = null;
            super.onDispose();
        }
        
        public function getFocusChain() : Array
        {
            return [this.vehicleTypeFilter,this.taskTypeFilter,this.hideCompletedTasks];
        }
    }
}
