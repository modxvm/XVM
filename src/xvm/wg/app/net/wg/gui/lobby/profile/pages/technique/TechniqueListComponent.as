package net.wg.gui.lobby.profile.pages.technique
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.data.constants.SortingInfo;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.SortableHeaderButtonBar;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.utils.ExcludeTweenManager;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
    import net.wg.gui.events.SortingEvent;
    import scaleform.clik.controls.ScrollIndicator;
    import scaleform.clik.constants.InvalidationType;
    import fl.transitions.easing.Strong;
    import scaleform.clik.motion.Tween;
    import flash.events.Event;
    import net.wg.gui.components.advanced.SortingButton;
    import net.wg.gui.components.controls.SortableScrollingList;
    
    public class TechniqueListComponent extends UIComponent
    {
        
        public function TechniqueListComponent()
        {
            this.tweenManager = new ExcludeTweenManager();
            super();
            this.techniqueList.addEventListener(TechniqueList.SELECTED_DATA_CHANGED,this.selectedDataChangeHandler,false,0,true);
            this.techniqueList.addEventListener(SortableScrollingList.DATA_INVALIDATED,this.listDataInvalidateHandler,false,0,true);
        }
        
        public static var DATA_CHANGED:String = "dataChanged";
        
        private static var LIST_DATA_INVALIDATED:String = "ldInv";
        
        private static var ANIM_SPEED:uint = 1000;
        
        private static var MASTERY_TAB_ENABLING_CHANGED:String = "mTabEnablingChanged";
        
        private static function getHeadersProvider() : DataProvider
        {
            var _loc4_:Array = null;
            var _loc13_:NormalSortingBtnInfo = null;
            var _loc1_:* = "../maps/icons/buttons/tab_sort_button/ascProfileSortArrow.png";
            var _loc2_:* = "../maps/icons/buttons/tab_sort_button/descProfileSortArrow.png";
            var _loc3_:Number = 40;
            _loc4_ = [];
            var _loc5_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc5_.iconId = TechniqueList.NATION_INDEX;
            _loc5_.iconSource = "../maps/icons/filters/nations/all.png";
            _loc5_.buttonWidth = 36;
            _loc5_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NATION;
            _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc5_.sortOrder = 0;
            _loc5_.inverted = true;
            _loc4_.push(_loc5_);
            var _loc6_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc6_.iconId = TechniqueList.TYPE_INDEX;
            _loc6_.iconSource = "../maps/icons/filters/tanks/all.png";
            _loc6_.buttonWidth = 34;
            _loc6_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_TECHNIQUE;
            _loc6_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc6_.sortOrder = 1;
            _loc6_.inverted = true;
            _loc4_.push(_loc6_);
            var _loc7_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc7_.iconId = TechniqueList.LEVEL;
            _loc7_.iconSource = "../maps/icons/buttons/tab_sort_button/level.png";
            _loc7_.buttonWidth = 28;
            _loc7_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_LVL;
            _loc7_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            _loc7_.sortOrder = 2;
            _loc4_.push(_loc7_);
            var _loc8_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc8_.iconId = TechniqueList.SHORT_USER_NAME;
            _loc8_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_VEHICLENAME;
            _loc8_.buttonWidth = 158;
            _loc8_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NAME;
            _loc8_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc8_.sortOrder = 7;
            _loc8_.dataSortType = Array.CASEINSENSITIVE;
            _loc4_.push(_loc8_);
            var _loc9_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc9_.iconId = TechniqueList.BATTLES_COUNT;
            _loc9_.buttonWidth = 74;
            _loc9_.label = PROFILE.SECTION_SUMMARY_SCORES_TOTALBATTLES;
            _loc9_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_BATTLESCOUNT;
            _loc9_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            _loc9_.sortOrder = 3;
            _loc4_.push(_loc9_);
            var _loc10_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc10_.iconId = TechniqueList.WINS_EFFICIENCY;
            _loc10_.buttonWidth = 74;
            _loc10_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_TOTALWINS;
            _loc10_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_WINS;
            _loc10_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            _loc10_.sortOrder = 4;
            _loc4_.push(_loc10_);
            var _loc11_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc11_.iconId = TechniqueList.AVG_EXPERIENCE;
            _loc11_.buttonWidth = 90;
            _loc11_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_AVGEXPERIENCE;
            _loc11_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_AVGEXP;
            _loc11_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            _loc11_.sortOrder = 5;
            _loc4_.push(_loc11_);
            var _loc12_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc12_.iconId = TechniqueList.MARK_OF_MASTERY;
            _loc12_.buttonWidth = 80;
            _loc12_.showSeparator = false;
            _loc12_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_CLASSINESS;
            _loc12_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_MARKSOFMASTERY;
            _loc12_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            _loc12_.sortOrder = 6;
            _loc4_.push(_loc12_);
            var _loc14_:* = 0;
            while(_loc14_ < _loc4_.length)
            {
                _loc13_ = _loc4_[_loc14_];
                _loc13_.ascendingIconSource = _loc1_;
                _loc13_.descendingIconSource = _loc2_;
                _loc13_.buttonHeight = _loc3_;
                _loc13_.enabled = true;
                _loc14_++;
            }
            return new DataProvider(_loc4_);
        }
        
        public var lowerShadow:MovieClip;
        
        public var upperShadow:MovieClip;
        
        public var sortableButtonBar:SortableHeaderButtonBar;
        
        public var techniqueList:TechniqueList;
        
        public var scrollBar:ScrollBar;
        
        public var bg:MovieClip;
        
        private var sortFunctions:Object;
        
        private var isMarkOfMasteryBtnEnabled:Boolean = true;
        
        private var tweenManager:ExcludeTweenManager;
        
        private var _vehicles:Array;
        
        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            var _loc3_:Number = this.techniqueList.rowHeight;
            var _loc4_:int = int(_height / _loc3_);
            _loc4_ = _loc4_ != -1?_loc4_:0;
            this.techniqueList.rowCount = _loc4_;
            var _loc5_:uint = _loc3_ * _loc4_;
            this.techniqueList.setSize(this.techniqueList.width,_loc5_);
            this.techniqueList.validateNow();
            this.bg.height = _loc5_ - this.bg.y;
            this.scrollBar.setActualSize(this.scrollBar.width,_loc5_ - this.scrollBar.y);
            this.scrollBar.validateNow();
            this.lowerShadow.y = _loc5_ - this.lowerShadow.height;
        }
        
        public function set vehicles(param1:Array) : void
        {
            this._vehicles = param1;
            invalidateData();
        }
        
        public function enableMarkOfMasteryBtn(param1:Boolean) : void
        {
            if(this.isMarkOfMasteryBtnEnabled != param1)
            {
                this.isMarkOfMasteryBtnEnabled = param1;
                invalidate(MASTERY_TAB_ENABLING_CHANGED);
            }
        }
        
        public function get selectedItem() : TechniqueListVehicleVO
        {
            return TechniqueListVehicleVO(this.techniqueList.selectedItem);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.lowerShadow.mouseEnabled = this.upperShadow.mouseEnabled = false;
            this.sortableButtonBar.dataProvider = getHeadersProvider();
            this.sortableButtonBar.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.sortingChangedHandler,false,0,true);
            this.techniqueList.columnsData = this.sortableButtonBar.dataProvider;
            this.applyDefaultSorting();
        }
        
        private function applyDefaultSorting() : void
        {
            this.sortableButtonBar.selectedIndex = 4;
            this.techniqueList.sortByField(TechniqueList.BATTLES_COUNT,false);
        }
        
        override protected function draw() : void
        {
            var _loc1_:uint = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:ScrollIndicator = null;
            var _loc5_:* = NaN;
            var _loc6_:* = 0;
            var _loc7_:NormalSortingBtnInfo = null;
            var _loc8_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.techniqueList.dataProvider = new DataProvider(this._vehicles);
            }
            if(isInvalid(LIST_DATA_INVALIDATED))
            {
                _loc1_ = this.techniqueList.dataProvider.length;
                _loc2_ = this.techniqueList.renderersCount;
                if(_loc1_ <= _loc2_)
                {
                    this.tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":0},this.getAnimTweenSet());
                    this.tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":0},this.getAnimTweenSet());
                }
                else
                {
                    _loc3_ = _loc1_ - _loc2_;
                    _loc4_ = ScrollIndicator(this.techniqueList.scrollBar);
                    _loc5_ = _loc4_?_loc4_.position:0;
                    _loc5_;
                    this.tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":0},this.getAnimTweenSet());
                    this.tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":1},this.getAnimTweenSet());
                }
            }
            if(isInvalid(MASTERY_TAB_ENABLING_CHANGED))
            {
                _loc6_ = this.sortableButtonBar.dataProvider?this.sortableButtonBar.dataProvider.length:0;
                _loc8_ = _loc6_ - 1;
                while(_loc8_ >= 0)
                {
                    _loc7_ = NormalSortingBtnInfo(this.sortableButtonBar.dataProvider[_loc8_]);
                    if((_loc7_) && _loc7_.iconId == TechniqueList.MARK_OF_MASTERY)
                    {
                        this.sortableButtonBar.enableButtonAt(this.isMarkOfMasteryBtnEnabled,_loc8_);
                        if(_loc8_ == this.sortableButtonBar.selectedIndex && !this.isMarkOfMasteryBtnEnabled)
                        {
                            this.applyDefaultSorting();
                        }
                        break;
                    }
                    _loc8_--;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this.tweenManager.dispose();
            this.tweenManager = null;
            if(this._vehicles)
            {
                this._vehicles.splice(0,this._vehicles.length);
                this._vehicles = null;
            }
            this.sortableButtonBar.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.sortingChangedHandler);
            if(this.techniqueList)
            {
                this.techniqueList.removeEventListener(TechniqueList.SELECTED_DATA_CHANGED,this.selectedDataChangeHandler);
                this.techniqueList.dispose();
                this.techniqueList = null;
            }
            if(this.sortableButtonBar)
            {
                this.sortableButtonBar.dispose();
                this.sortableButtonBar = null;
            }
            if(this.scrollBar)
            {
                this.scrollBar.dispose();
                this.scrollBar = null;
            }
            this.sortFunctions = null;
            this.lowerShadow = null;
            super.onDispose();
        }
        
        private function getAnimTweenSet() : Object
        {
            return {"ease":Strong.easeOut,
            "onComplete":this.onTweenComplete
        };
    }
    
    private function onTweenComplete(param1:Tween) : void
    {
        if(this.tweenManager)
        {
            this.tweenManager.unregister(param1);
        }
    }
    
    private function listDataInvalidateHandler(param1:Event) : void
    {
        invalidate(LIST_DATA_INVALIDATED);
    }
    
    private function selectedDataChangeHandler(param1:Event) : void
    {
        dispatchEvent(new Event(DATA_CHANGED));
    }
    
    private function sortingChangedHandler(param1:Event) : void
    {
        param1.stopImmediatePropagation();
        var _loc2_:SortingButton = SortingButton(param1.target);
        if(_loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
        {
            this.techniqueList.sortByField(_loc2_.id,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
        }
    }
}
}
