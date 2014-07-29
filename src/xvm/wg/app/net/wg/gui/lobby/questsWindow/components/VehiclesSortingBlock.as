package net.wg.gui.lobby.questsWindow.components
{
    import net.wg.infrastructure.interfaces.ISortable;
    import net.wg.gui.components.controls.DropDownImageText;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
    import net.wg.gui.lobby.questsWindow.data.SortedBtnVO;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.advanced.SortableHeaderButtonBar;
    import net.wg.gui.lobby.questsWindow.data.VehiclesSortingBlockVO;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.lobby.profile.pages.technique.ProfileSortingButton;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ListEvent;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.ResizableBlockEvent;
    
    public class VehiclesSortingBlock extends AbstractResizableContent implements ISortable
    {
        
        public function VehiclesSortingBlock()
        {
            super();
        }
        
        private static var FILTERS_PADDING:int = 42;
        
        private static var VEHICLE_RENDERER_HEIGHT:int = 35;
        
        private static var MAX_VEHICLE_RENDERERS:int = 6;
        
        private static var DEFAULT_WIDTH:int = 375;
        
        private static var BOTTOM_PADDING:int = 10;
        
        private static function updateSelectedIndex(param1:DropDownImageText, param2:Object) : void
        {
            var _loc3_:int = param1.dataProvider.length;
            param1.selectedIndex = 0;
            var _loc4_:Number = 0;
            while(_loc4_ < _loc3_)
            {
                if(param1.dataProvider[_loc4_].data == param2)
                {
                    param1.selectedIndex = _loc4_;
                    return;
                }
                _loc4_++;
            }
        }
        
        private static function setupDataProvider(param1:Array) : IDataProvider
        {
            var _loc3_:Object = null;
            var _loc2_:DataProvider = new DataProvider();
            for each(_loc3_ in param1)
            {
                _loc2_.push(new QuestVehicleRendererVO(_loc3_));
            }
            return _loc2_;
        }
        
        private static var INV_AVAILABLE_WIDTH:String = "invAvailableWidth";
        
        private static function getHeadersProvider(param1:Array) : DataProvider
        {
            var _loc7_:SortedBtnVO = null;
            var _loc8_:NormalSortingBtnInfo = null;
            var _loc2_:* = "../maps/icons/buttons/tab_sort_button/ascProfileSortArrow.png";
            var _loc3_:* = "../maps/icons/buttons/tab_sort_button/descProfileSortArrow.png";
            var _loc4_:Number = 40;
            var _loc5_:Array = [];
            var _loc6_:* = 0;
            while(_loc6_ < param1.length)
            {
                _loc7_ = new SortedBtnVO(param1[_loc6_]);
                _loc8_ = new NormalSortingBtnInfo();
                _loc8_.iconId = _loc7_.id;
                _loc8_.label = _loc7_.label;
                _loc8_.iconSource = _loc7_.iconSource;
                _loc8_.buttonWidth = _loc7_.buttonWidth;
                _loc8_.toolTip = _loc7_.toolTip;
                _loc8_.ascendingIconSource = _loc2_;
                _loc8_.descendingIconSource = _loc3_;
                _loc8_.buttonHeight = _loc4_;
                _loc8_.enabled = true;
                _loc8_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
                if(_loc6_ == param1.length - 1)
                {
                    _loc8_.showSeparator = false;
                }
                _loc5_.push(_loc8_);
                _loc6_++;
            }
            return new DataProvider(_loc5_);
        }
        
        public var sortCheckBox:CheckBox;
        
        public var nationFilter:DropDownImageText;
        
        public var tankFilter:DropDownImageText;
        
        public var levelFilter:DropDownImageText;
        
        public var vehiclesList:ScrollingListEx;
        
        public var buttonBar:SortableHeaderButtonBar;
        
        public var data:VehiclesSortingBlockVO = null;
        
        private var _tableID:String = "";
        
        private var _sortingFunction:Function = null;
        
        override public function setData(param1:Object) : void
        {
            if(this.data)
            {
                this.data.dispose();
            }
            this.data = new VehiclesSortingBlockVO(param1);
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.sortCheckBox.label = QUESTS.QUESTS_TABLE_INHANGAR;
            this.vehiclesList.sbPadding = new Padding(5,4,5,1);
        }
        
        override protected function onDispose() : void
        {
            this.removeListeners();
            this.sortCheckBox.dispose();
            this.sortCheckBox = null;
            this.nationFilter.dispose();
            this.nationFilter = null;
            this.tankFilter.dispose();
            this.tankFilter = null;
            this.levelFilter.dispose();
            this.levelFilter = null;
            this.vehiclesList.dispose();
            this.vehiclesList = null;
            this.buttonBar.dispose();
            this.buttonBar = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:Array = null;
            var _loc3_:* = 0;
            var _loc4_:* = NaN;
            var _loc5_:ProfileSortingButton = null;
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                this.buttonBar.dataProvider = getHeadersProvider(this.data.headerElements);
                if(this.data.hasHeader)
                {
                    this.nationFilter.visible = this.tankFilter.visible = this.levelFilter.visible = true;
                    this.buttonBar.y = FILTERS_PADDING;
                }
                else
                {
                    this.nationFilter.visible = this.tankFilter.visible = this.levelFilter.visible = false;
                    this.buttonBar.y = this.nationFilter.y;
                }
                this.nationFilter.dataProvider = new DataProvider(this.data.nationFilterData);
                this.tankFilter.dataProvider = new DataProvider(this.data.tankFilterData);
                this.levelFilter.dataProvider = new DataProvider(this.data.levelFilterData);
                updateSelectedIndex(this.nationFilter,this.data.selectedNation);
                updateSelectedIndex(this.tankFilter,this.data.selectedVehType);
                updateSelectedIndex(this.levelFilter,this.data.selectedLvl);
                _loc1_ = 0;
                while(_loc1_ < this.buttonBar.renderersCount)
                {
                    _loc5_ = this.buttonBar.getButtonAt(_loc1_) as ProfileSortingButton;
                    if(_loc5_.id == this.data.selectedBtnID)
                    {
                        this.buttonBar.selectedIndex = _loc1_;
                        _loc5_.sortDirection = this.data.sortDirection;
                    }
                    _loc1_++;
                }
                this._tableID = this.data.tableID;
                if(this.data.showNotInHangarCB)
                {
                    this.sortCheckBox.label = QUESTS.QUESTS_TABLE_NOTINHANGAR;
                }
                this.sortCheckBox.visible = (this.data.hasHeader) && ((this.data.showInHangarCB) || (this.data.showNotInHangarCB));
                this.sortCheckBox.selected = this.data.cbSelected;
                this.vehiclesList.y = this.buttonBar.y + this.buttonBar.height;
                _loc2_ = this._sortingFunction(this.getSortingObject());
                _loc3_ = _loc2_.length > 0?_loc2_.length:1;
                this.vehiclesList.height = VEHICLE_RENDERER_HEIGHT * Math.min(MAX_VEHICLE_RENDERERS,_loc3_);
                this.vehiclesList.dataProvider = setupDataProvider(_loc2_);
                this.isReadyForLayout = true;
                _loc4_ = Math.round(this.vehiclesList.y + this.vehiclesList.height);
                setSize(this.width,_loc4_ + BOTTOM_PADDING);
            }
            if(isInvalid(INV_AVAILABLE_WIDTH))
            {
                this.x = availableWidth - DEFAULT_WIDTH;
            }
        }
        
        private function addListeners() : void
        {
            this.nationFilter.addEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.tankFilter.addEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.levelFilter.addEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.sortCheckBox.addEventListener(Event.SELECT,this.updateSortedData);
            this.buttonBar.addEventListener(ButtonEvent.CLICK,this.updateSortedData);
        }
        
        private function removeListeners() : void
        {
            this.nationFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.tankFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.levelFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.updateSortedData);
            this.sortCheckBox.removeEventListener(Event.SELECT,this.updateSortedData);
            this.buttonBar.removeEventListener(ButtonEvent.CLICK,this.updateSortedData);
        }
        
        override public function set availableWidth(param1:Number) : void
        {
            super.availableWidth = param1;
            invalidate(INV_AVAILABLE_WIDTH);
        }
        
        override public function set isReadyForLayout(param1:Boolean) : void
        {
            super.isReadyForLayout = param1;
            if(param1)
            {
                this.addListeners();
            }
            else
            {
                this.removeListeners();
            }
        }
        
        private function updateSortedData(param1:Event) : void
        {
            var _loc2_:Object = this.getSortingObject();
            var _loc3_:Array = this._sortingFunction(_loc2_);
            this.setSortedData(_loc3_);
        }
        
        private function getSortingObject() : Object
        {
            var _loc1_:Number = this.nationFilter.dataProvider[this.nationFilter.selectedIndex].data;
            var _loc2_:String = String(this.tankFilter.dataProvider[this.tankFilter.selectedIndex].data);
            var _loc3_:Number = this.levelFilter.dataProvider[this.levelFilter.selectedIndex].data;
            var _loc4_:Boolean = this.sortCheckBox.selected;
            var _loc5_:ProfileSortingButton = this.buttonBar.getButtonAt(this.buttonBar.selectedIndex) as ProfileSortingButton;
            var _loc6_:String = _loc5_?_loc5_.sortDirection:SortingInfo.WITHOUT_SORT;
            var _loc7_:String = _loc5_?_loc5_.id:"";
            var _loc8_:Object = {"nation":_loc1_,
            "vehType":_loc2_,
            "level":_loc3_,
            "cbSelected":_loc4_,
            "sortingDirection":_loc6_,
            "buttonID":_loc7_,
            "isAction":this.data.showNotInHangarCB,
            "tableID":this._tableID
        };
        return _loc8_;
    }
    
    private function setSortedData(param1:Array) : void
    {
        var _loc2_:int = param1.length > 0?param1.length:1;
        var _loc3_:Number = VEHICLE_RENDERER_HEIGHT * Math.min(MAX_VEHICLE_RENDERERS,_loc2_);
        var _loc4_:Number = _loc3_ - this.vehiclesList.height;
        this.vehiclesList.dataProvider = setupDataProvider(param1);
        this.vehiclesList.height = _loc3_;
        this.setSize(this.width,this.vehiclesList.y + this.vehiclesList.height + BOTTOM_PADDING);
        dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED,true));
    }
    
    public function get sortingFunction() : Function
    {
        return this._sortingFunction;
    }
    
    public function set sortingFunction(param1:Function) : void
    {
        this._sortingFunction = param1;
    }
}
}
