package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;


   public class SortingButton extends ScalableIconButton
   {
          
      public function SortingButton() {
         super();
      }

      public static const ASCENDING_SORT:String = "ascending";

      public static const DESCENDING_SORT:String = "descending";

      public static const WITHOUT_SORT:String = "none";

      public static const SORT_DIRECTION_CHANGED:String = "sortDirectionChanged";

      private static const ASCENDING_ICON_INVALID:String = "ascIcon";

      private static const DESCENDING_ICON_INVALID:String = "descIcon";

      private static const SORT_DIRECTION_INVALID:String = "checkSortDirection";

      public var defaultSortDirection:String = "none";

      public var bg:MovieClip;

      public var upperBg:MovieClip;

      public var mcAscendingIcon:UILoaderAlt;

      public var mcDescendingIcon:UILoaderAlt;

      protected var isSortIconLoadingCompete:Boolean;

      private var _ascendingIconSource:String;

      private var _descendingIconSource:String;

      private var _sortDirection:String;

      private var _id:String;

      override protected function onDispose() : void {
         this.bg = null;
         this.upperBg = null;
         this.mcAscendingIcon.removeEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         this.mcAscendingIcon.dispose();
         this.mcAscendingIcon = null;
         this.mcDescendingIcon.dispose();
         this.mcDescendingIcon = null;
         super.onDispose();
      }

      override public function set data(param1:Object) : void {
         var _loc2_:SortingButtonInfo = null;
         super.data = param1;
         if(param1  is  SortingButtonInfo)
         {
            _loc2_ = SortingButtonInfo(param1);
            if(!isNaN(_loc2_.buttonWidth))
            {
               width = _loc2_.buttonWidth;
            }
            if(!isNaN(_loc2_.buttonHeight))
            {
               height = _loc2_.buttonHeight;
            }
            if(_loc2_.defaultSortDirection)
            {
               this.defaultSortDirection = _loc2_.defaultSortDirection;
            }
            if(_loc2_.toolTip)
            {
               tooltip = _loc2_.toolTip;
            }
            enabled = _loc2_.enabled;
            this._id = _loc2_.iconId;
            this.ascendingIconSource = _loc2_.ascendingIconSource;
            this.descendingIconSource = _loc2_.descendingIconSource;
            iconSource = _loc2_.iconSource;
         }
      }

      public function get sortDirection() : String {
         return this._sortDirection;
      }

      public function set sortDirection(param1:String) : void {
         var value:String = param1;
         if(!(value == ASCENDING_SORT) && !(value == DESCENDING_SORT) && !(value == WITHOUT_SORT))
         {
            try
            {
               DebugUtils.LOG_WARNING("Flash :: Unknown sorting button state: ",value);
            }
            catch(e:Error)
            {
               trace("Flash :: Unknown sorting button state:",value);
            }
            value = WITHOUT_SORT;
         }
         if(this._sortDirection != value)
         {
            this._sortDirection = value;
            dispatchEvent(new Event(SORT_DIRECTION_CHANGED,true));
            invalidate(SORT_DIRECTION_INVALID);
         }
      }

      public function get ascendingIconSource() : String {
         return this._ascendingIconSource;
      }

      public function set ascendingIconSource(param1:String) : void {
         this._ascendingIconSource = param1;
         invalidate(ASCENDING_ICON_INVALID);
      }

      public function get descendingIconSource() : String {
         return this._descendingIconSource;
      }

      public function set descendingIconSource(param1:String) : void {
         this._descendingIconSource = param1;
         invalidate(DESCENDING_ICON_INVALID);
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         this.tabEnabled = false;
         this.mcAscendingIcon.addEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         this.visible = false;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(ASCENDING_ICON_INVALID))
         {
            this.mcAscendingIcon.source = this._ascendingIconSource;
         }
         if(isInvalid(DESCENDING_ICON_INVALID))
         {
            this.mcDescendingIcon.source = this._descendingIconSource;
         }
         if(this.isSortIconLoadingCompete)
         {
            this.isSortIconLoadingCompete = false;
            this.visible = true;
            invalidate(SORT_DIRECTION_INVALID,InvalidationType.SIZE);
            invalidate();
         }
         if(isInvalid(SORT_DIRECTION_INVALID))
         {
            this.applySortDirection();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = _width;
            this.bg.height = _height;
            if(this.upperBg)
            {
               this.upperBg.width = _width - 2;
               this.upperBg.height = _height;
            }
         }
      }

      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         this.bg.width = _width;
         this.bg.height = _height;
         if(this.upperBg)
         {
            this.upperBg.width = _width - 2;
            this.upperBg.height = _height;
         }
      }

      protected function applySortDirection() : void {
         if(this._sortDirection == ASCENDING_SORT)
         {
            if(this.mcAscendingIcon)
            {
               this.mcAscendingIcon.visible = true;
            }
            if(this.mcDescendingIcon)
            {
               this.mcDescendingIcon.visible = false;
            }
         }
         else
         {
            if(this._sortDirection == DESCENDING_SORT)
            {
               if(this.mcAscendingIcon)
               {
                  this.mcAscendingIcon.visible = false;
               }
               if(this.mcDescendingIcon)
               {
                  this.mcDescendingIcon.visible = true;
               }
            }
            else
            {
               if(this.mcAscendingIcon)
               {
                  this.mcAscendingIcon.visible = false;
               }
               if(this.mcDescendingIcon)
               {
                  this.mcDescendingIcon.visible = false;
               }
            }
         }
      }

      protected function sortingIconLoadingCompleteHandler(param1:UILoaderEvent) : void {
         this.mcAscendingIcon.y = Math.round(_height - this.mcAscendingIcon.height);
         this.isSortIconLoadingCompete = true;
         invalidate();
      }
   }

}