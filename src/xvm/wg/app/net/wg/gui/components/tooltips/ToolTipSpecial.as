package net.wg.gui.components.tooltips
{
   import __AS3__.vec.Vector;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;


   public class ToolTipSpecial extends ToolTipBase
   {
          
      public function ToolTipSpecial() {
         super();
      }

      protected var blockResults:Vector.<ToolTipBlockResultVO> = null;

      protected function updatePositions() : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:* = NaN;
         var _loc6_:Separator = null;
         var _loc1_:uint = 0;
         if(this.blockResults)
         {
            _loc1_ = this.blockResults.length;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               this.blockResults[_loc3_].leftTextField.width = leftPartMaxW;
               _loc2_ = this.blockResults[_loc3_].elRightList.length;
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  this.blockResults[_loc3_].elRightList[_loc4_].x = this.blockResults[_loc3_].leftTextField.x + leftPartMaxW + Utils.instance.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS | 0;
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         if(separators)
         {
            _loc1_ = separators.length;
            _loc5_ = content.width + contentMargin.right + bgShadowMargin.right;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc6_ = separators[_loc3_];
               _loc6_.x = _loc5_ - _loc6_.width >> 1;
               _loc3_++;
            }
         }
      }

      override public function dispose() : void {
         var _loc1_:ToolTipBlockResultVO = null;
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         var _loc4_:Vector.<IconText> = null;
         var _loc5_:IconText = null;
         if(this.blockResults)
         {
            while(this.blockResults.length > 0)
            {
               _loc1_ = this.blockResults.pop();
               _loc2_ = _loc1_.headerTextField;
               if(_loc2_ != null)
               {
                  content.removeChild(_loc2_);
                  _loc1_.headerTextField = null;
                  _loc2_ = null;
               }
               _loc3_ = _loc1_.leftTextField;
               if(_loc3_ != null)
               {
                  content.removeChild(_loc3_);
                  _loc1_.leftTextField = null;
                  _loc3_ = null;
               }
               _loc4_ = _loc1_.elRightList;
               while(_loc4_.length > 0)
               {
                  _loc5_ = _loc4_.pop();
                  content.removeChild(_loc5_);
                  _loc5_ = null;
               }
               _loc1_ = null;
            }
            this.blockResults = null;
         }
         super.dispose();
      }

      override protected function updateSize() : void {
         if(contentWidth == 0)
         {
            contentWidth = content.width;
         }
         background.width = contentWidth + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
      }
   }

}