package net.wg.gui.lobby.profile.pages.technique
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.advanced.SortingButton;
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.utils.ExcludeTweenManager;
   import flash.events.Event;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.constants.InvalidationType;
   import fl.transitions.easing.Strong;
   import scaleform.clik.motion.Tween;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.gui.components.controls.SortableScrollingList;


   public class TechniqueListComponent extends UIComponent
   {
          
      public function TechniqueListComponent() {
         this.tweenManager = new ExcludeTweenManager();
         super();
         this.techniqueList.addEventListener(TechniqueList.SELECTED_DATA_CHANGED,this.selectedDataChangeHandler,false,0,true);
         this.techniqueList.addEventListener(SortableScrollingList.DATA_INVALIDATED,this.listDataInvalidateHandler,false,0,true);
      }

      private static const NATION:String = "nation";

      private static const LEVEL:String = "level";

      private static const TYPE:String = "type";

      private static const VEHICLE_NAME:String = "vName";

      private static const TOTAL_BATTLES:String = "totalBattles";

      private static const TOTAL_WINS:String = "totalWins";

      private static const AVG_EXP:String = "avgExperience";

      private static const MASTERY:String = "mastery";

      public static const DATA_CHANGED:String = "dataChanged";

      private static const LIST_DATA_INVALIDATED:String = "ldInv";

      private static const ANIM_SPEED:uint = 1000;

      private static function getHeadersProvider() : DataProvider {
         var _loc13_:ProfileSortingBtnInfo = null;
         var _loc1_:* = "../maps/icons/buttons/tab_sort_button/ascProfileSortArrow.png";
         var _loc2_:* = "../maps/icons/buttons/tab_sort_button/descProfileSortArrow.png";
         var _loc3_:Number = 40;
         var _loc4_:Array = [];
         var _loc5_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc5_.iconId = NATION;
         _loc5_.iconSource = "../maps/icons/filters/nations/all.png";
         _loc5_.buttonWidth = 36;
         _loc5_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NATION;
         _loc4_.push(_loc5_);
         var _loc6_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc6_.iconId = TYPE;
         _loc6_.iconSource = "../maps/icons/filters/tanks/all.png";
         _loc6_.buttonWidth = 34;
         _loc6_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_TECHNIQUE;
         _loc4_.push(_loc6_);
         var _loc7_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc7_.iconId = LEVEL;
         _loc7_.iconSource = "../maps/icons/buttons/tab_sort_button/level.png";
         _loc7_.buttonWidth = 28;
         _loc7_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_LVL;
         _loc4_.push(_loc7_);
         var _loc8_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc8_.iconId = VEHICLE_NAME;
         _loc8_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_VEHICLENAME;
         _loc8_.buttonWidth = 158;
         _loc8_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NAME;
         _loc4_.push(_loc8_);
         var _loc9_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc9_.iconId = TOTAL_BATTLES;
         _loc9_.buttonWidth = 74;
         _loc9_.label = PROFILE.SECTION_SUMMARY_SCORES_TOTALBATTLES;
         _loc9_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_BATTLESCOUNT;
         _loc4_.push(_loc9_);
         var _loc10_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc10_.iconId = TOTAL_WINS;
         _loc10_.buttonWidth = 74;
         _loc10_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_TOTALWINS;
         _loc10_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_WINS;
         _loc4_.push(_loc10_);
         var _loc11_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc11_.iconId = AVG_EXP;
         _loc11_.buttonWidth = 90;
         _loc11_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_AVGEXPERIENCE;
         _loc11_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_AVGEXP;
         _loc4_.push(_loc11_);
         var _loc12_:ProfileSortingBtnInfo = new ProfileSortingBtnInfo();
         _loc12_.iconId = MASTERY;
         _loc12_.buttonWidth = 80;
         _loc12_.showSeparator = false;
         _loc12_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_CLASSINESS;
         _loc12_.toolTip = PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_MARKSOFMASTERY;
         _loc4_.push(_loc12_);
         var _loc14_:* = 0;
         while(_loc14_ < _loc4_.length)
         {
            _loc13_ = _loc4_[_loc14_];
            _loc13_.ascendingIconSource = _loc1_;
            _loc13_.descendingIconSource = _loc2_;
            _loc13_.buttonHeight = _loc3_;
            _loc13_.enabled = true;
            _loc13_.defaultSortDirection = SortingButton.WITHOUT_SORT;
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

      private var _pendingDataProvider:Array;

      private var isMarkOfMasteryBtnEnabled:Boolean = true;

      private var tweenManager:ExcludeTweenManager;

      private function listDataInvalidateHandler(param1:Event) : void {
         invalidate(LIST_DATA_INVALIDATED);
      }

      override protected function configUI() : void {
         super.configUI();
         this.lowerShadow.mouseEnabled = this.upperShadow.mouseEnabled = false;
         this.sortableButtonBar.dataProvider = getHeadersProvider();
         this.sortableButtonBar.addEventListener(SortingButton.SORT_DIRECTION_CHANGED,this.sortingChangedHandler,false,0,true);
         this.sortableButtonBar.selectedIndex = 4;
         this.techniqueList.sortByBattlesCount(true);
      }

      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ScrollIndicator = null;
         var _loc5_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.techniqueList.dataProvider = new DataProvider(this._pendingDataProvider);
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
               this.tweenManager.registerAndLaunch(ANIM_SPEED,this.upperShadow,{"alpha":0},this.getAnimTweenSet());
               this.tweenManager.registerAndLaunch(ANIM_SPEED,this.lowerShadow,{"alpha":1},this.getAnimTweenSet());
            }
         }
      }

      public function enableMarkOfMasteryBtn(param1:Boolean) : void {
         if(this.isMarkOfMasteryBtnEnabled != param1)
         {
            this.isMarkOfMasteryBtnEnabled = param1;
            if(this.sortableButtonBar.getRenderers().length == 0 && !param1)
            {
               this.sortableButtonBar.validateNow();
            }
            this.sortableButtonBar.getButtonAt(this.sortableButtonBar.dataProvider.length-1).enabled = param1;
         }
      }

      private function getAnimTweenSet() : Object {
         return {
            "ease":Strong.easeOut,
            "onComplete":this.onTweenComplete
         }
         ;
      }

      private function onTweenComplete(param1:Tween) : void {
         if(this.tweenManager)
         {
            this.tweenManager.unregister(param1);
         }
      }

      private function selectedDataChangeHandler(param1:Event) : void {
         dispatchEvent(new Event(DATA_CHANGED));
      }

      private function sortingChangedHandler(param1:Event) : void {
         var _loc3_:Function = null;
         param1.stopImmediatePropagation();
         var _loc2_:SortingButton = SortingButton(param1.target);
         if(_loc2_.sortDirection != SortingButton.WITHOUT_SORT)
         {
            if(!this.sortFunctions)
            {
               this.sortFunctions = {};
               this.sortFunctions[NATION] = this.techniqueList.sortByNation;
               this.sortFunctions[LEVEL] = this.techniqueList.sortByLevel;
               this.sortFunctions[TYPE] = this.techniqueList.sortByType;
               this.sortFunctions[VEHICLE_NAME] = this.techniqueList.sortByVehicleName;
               this.sortFunctions[TOTAL_BATTLES] = this.techniqueList.sortByBattlesCount;
               this.sortFunctions[TOTAL_WINS] = this.techniqueList.sortByWins;
               this.sortFunctions[AVG_EXP] = this.techniqueList.sortByAvgExp;
               this.sortFunctions[MASTERY] = this.techniqueList.sortByMarkOfMastery;
            }
            _loc3_ = this.sortFunctions[_loc2_.id];
            _loc3_.apply(this,[_loc2_.sortDirection == SortingButton.ASCENDING_SORT]);
         }
      }

      public function get selectedItem() : TechniqueListVehicleVO {
         return TechniqueListVehicleVO(this.techniqueList.selectedItem);
      }

      override public function setSize(param1:Number, param2:Number) : void {
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

      public function set dataProvider(param1:Array) : void {
         this._pendingDataProvider = param1;
         invalidateData();
      }

      override public function dispose() : void {
         this.tweenManager.dispose();
         this.tweenManager = null;
         this._pendingDataProvider = null;
         this.sortableButtonBar.removeEventListener(SortingButton.SORT_DIRECTION_CHANGED,this.sortingChangedHandler);
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
         super.dispose();
      }
   }

}