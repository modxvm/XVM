package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.components.controls.SortableScrollingList;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.Event;
   import scaleform.clik.interfaces.IDataProvider;
   import __AS3__.vec.Vector;
   import flash.utils.getQualifiedClassName;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;


   public class TechniqueList extends SortableScrollingList
   {
          
      public function TechniqueList() {
         super();
      }

      private static const NATION_INDEX:String = "nationIndex";

      private static const TYPE_INDEX:String = "typeIndex";

      private static const SHORT_USER_NAME:String = "shortUserName";

      private static const BATTLES_COUNT:String = "battlesCount";

      private static const WINS_EFFICIENCY:String = "winsEfficiency";

      private static const AVG_EXPERIENCE:String = "avgExperience";

      private static const MARK_OF_MASTERY:String = "markOfMastery";

      private static const LEVEL:String = "level";

      public static const SELECTED_DATA_CHANGED:String = "selDataChanged";

      private var isValidationChecked:Boolean;

      private var oldSelectedItemId:int = -1;

      private var isSortingTheLastActivity:Boolean;

      private var isDataProviderReceived:Boolean;

      override protected function configUI() : void {
         super.configUI();
         this.addEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler,false,0,true);
      }

      override protected function handleItemClick(param1:ButtonEvent) : void {
         super.handleItemClick(param1);
         this.isSortingTheLastActivity = false;
      }

      private function indexChangedHandler(param1:ListEvent) : void {
         if(!this.isSortingTheLastActivity)
         {
            dispatchEvent(new Event(SELECTED_DATA_CHANGED));
         }
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         var _loc2_:Vector.<String> = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         this.isSortingTheLastActivity = false;
         this.isDataProviderReceived = true;
         this.invalidateSorting(sortPropName);
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
               for each (_loc4_ in _loc2_)
               {
                  App.utils.asserter.assert(_loc3_.hasOwnProperty(_loc4_),"There is no property \'" + _loc4_ + "\' in the " + getQualifiedClassName(_loc3_) + " to apply sort operation! " + getQualifiedClassName(this));
               }
            }
         }
      }

      override protected function sortWithMask(param1:String, param2:uint) : void {
         var _loc5_:TechniqueListVehicleVO = null;
         super.sortWithMask(param1,param2);
         var _loc3_:* = -1;
         var _loc4_:uint = dataProvider.length;
         if(_loc4_ > 0)
         {
            _loc3_ = 0;
         }
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = dataProvider[_loc6_];
            if(this.oldSelectedItemId == _loc5_.id)
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         _newSelectedIndex = _loc3_;
         invalidateSelectedIndex();
      }

      override public function set selectedIndex(param1:int) : void {
         this.updateOldSelected();
         super.selectedIndex = param1;
      }

      override protected function draw() : void {
         super.draw();
         this.isSortingTheLastActivity = false;
         if(this.isDataProviderReceived)
         {
            this.isDataProviderReceived = false;
            dispatchEvent(new Event(SELECTED_DATA_CHANGED));
         }
      }

      public function get selectedItem() : Object {
         if((dataProvider) && dataProvider.length > 0)
         {
            return dataProvider[selectedIndex];
         }
         return null;
      }

      private function invalidateSorting(param1:String) : void {
         this.updateOldSelected();
         sortPropName = param1;
         this.isSortingTheLastActivity = true;
         invalidate(SORTING_INVALID);
      }

      private function updateOldSelected() : void {
         var _loc2_:TechniqueListVehicleVO = null;
         var _loc1_:IListItemRenderer = getRendererAt(selectedIndex);
         if(_loc1_)
         {
            _loc2_ = TechniqueListVehicleVO(_dataProvider[selectedIndex]);
            this.oldSelectedItemId = _loc2_.id;
         }
      }

      public function sortByNation(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(NATION_INDEX);
         }
      }

      public function sortByType(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.CASEINSENSITIVE;
            setSortMask(param1);
            this.invalidateSorting(TYPE_INDEX);
         }
      }

      public function sortByLevel(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(LEVEL);
         }
      }

      public function sortByVehicleName(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.CASEINSENSITIVE;
            if(!param1)
            {
               sortMask = sortMask | Array.DESCENDING;
            }
            this.invalidateSorting(SHORT_USER_NAME);
         }
      }

      public function sortByBattlesCount(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(BATTLES_COUNT);
         }
      }

      public function sortByWins(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(WINS_EFFICIENCY);
         }
      }

      public function sortByAvgExp(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(AVG_EXPERIENCE);
         }
      }

      public function sortByMarkOfMastery(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            this.invalidateSorting(MARK_OF_MASTERY);
         }
      }

      override protected function drawLayout() : void {
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

      override public function dispose() : void {
         this.removeEventListener(ListEvent.INDEX_CHANGE,this.indexChangedHandler);
         super.dispose();
      }
   }

}