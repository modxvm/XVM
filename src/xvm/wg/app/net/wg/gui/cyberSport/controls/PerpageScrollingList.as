package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.cyberSport.interfaces.IPerpageScrollList;
   import net.wg.utils.IAssertable;
   import net.wg.gui.cyberSport.controls.events.NavigationEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import net.wg.infrastructure.exceptions.IndexOutOfBoundsException;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.data.constants.Errors;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;


   public class PerpageScrollingList extends ScrollingListEx implements IPerpageScrollList
   {
          
      public function PerpageScrollingList() {
         super();
         this._asserter = App.utils.asserter;
      }

      private static const DATA_ARG_NAME:String = "dataArray";

      private var _maximumOfPages:uint = 3;

      private var _currentPageIndex:uint = 0;

      private var _asserter:IAssertable = null;

      private var _totalCommands:int = 0;

      public function setNavInCoolDown(param1:Boolean) : void {
         dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATION_IN_COOL_DOWN,param1));
      }

      override public function dispose() : void {
         this._asserter = null;
         this.cleanupData();
         super.dispose();
      }

      public function setData(param1:Array) : void {
         this.assertArray(param1,DATA_ARG_NAME);
         this.cleanupData();
         if(this.totalCommands > param1.length)
         {
            param1.push({"locked":true});
         }
         dataProvider = new DataProvider(this.convertArrayToVOs(param1));
         this._currentPageIndex = 0;
      }

      public function appendData(param1:Array) : void {
         var _loc2_:String = null;
         var _loc3_:CSCommandVO = null;
         this.assertArray(param1,DATA_ARG_NAME);
         if(dataProvider)
         {
            if(dataProvider.length > 0)
            {
               _loc3_ = CSCommandVO(dataProvider[dataProvider.length-1]);
               if(_loc3_.isLoadMoreState)
               {
                  (dataProvider as Array).pop();
               }
            }
            (dataProvider as Array).push.apply(dataProvider,this.convertArrayToVOs(param1));
            this._currentPageIndex++;
            if(this.totalCommands > dataProvider.length && this._currentPageIndex < this._maximumOfPages)
            {
               (dataProvider as Array).push(new CSCommandVO({"locked":true}));
            }
            _loc2_ = "curent page index (" + this._currentPageIndex + ") out of bounds(" + this._maximumOfPages + ")!";
            this._asserter.assert(this._maximumOfPages >= this._currentPageIndex,_loc2_,IndexOutOfBoundsException);
            invalidateData();
            validateNow();
         }
      }

      public function setPagesMaximum(param1:uint) : void {
         var _loc2_:String = null;
         if(param1 != this._maximumOfPages)
         {
            _loc2_ = "maximumOfPages can`t be greater then currentPageIndex";
            this._asserter.assert(param1 < this._currentPageIndex,_loc2_,ArgumentException);
            this._maximumOfPages = param1;
         }
      }

      private function cleanupData() : void {
         dataProvider.cleanUp();
      }

      private function assertArray(param1:Array, param2:String) : void {
         this._asserter.assertNotNull(param1,param2 + Errors.CANT_NULL);
      }

      private function convertArrayToVOs(param1:Array) : Array {
         var _loc3_:Object = null;
         var _loc2_:Array = [];
         for each (_loc3_ in param1)
         {
            _loc2_.push(new CSCommandVO(_loc3_));
         }
         return _loc2_;
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

      public function get totalCommands() : int {
         return this._totalCommands;
      }

      public function set totalCommands(param1:int) : void {
         this._totalCommands = param1;
      }
   }

}