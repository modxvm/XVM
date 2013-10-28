package net.wg.gui.components.controls
{
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.DisplayObject;


   public class ScrollingListAutoScroll extends ScrollingList
   {
          
      public function ScrollingListAutoScroll() {
         super();
      }

      override protected function drawLayout() : void {
         var _loc8_:IListItemRenderer = null;
         this.drawScrollBar();
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = this.availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_ + _loc7_ * _loc2_;
            _loc8_.width = _loc3_;
            _loc8_.height = _loc2_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
      }

      override protected function drawScrollBar() : void {
         super.drawScrollBar();
         if(_scrollBar)
         {
            (_scrollBar as DisplayObject).visible = (dataProvider) && dataProvider.length > rowCount;
         }
      }

      override public function get availableWidth() : Number {
         return Math.round(_width) - margin * 2 - ((_autoScrollBar) && ((_scrollBar as DisplayObject).visible)?Math.round(_scrollBar.width):0);
      }
   }

}