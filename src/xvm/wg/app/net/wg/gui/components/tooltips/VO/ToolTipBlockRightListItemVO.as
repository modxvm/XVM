package net.wg.gui.components.tooltips.VO
{


   public class ToolTipBlockRightListItemVO extends Object
   {
          
      public function ToolTipBlockRightListItemVO(param1:String=undefined, param2:String=null, param3:Number=undefined, param4:Number=undefined) {
         super();
         this.text = param1;
         this.icon = param2;
         this.textYOffset = param3;
         this.textXOffset = param4;
      }

      public var text:String = null;

      public var icon:String = null;

      public var textYOffset:Number = NaN;

      public var textXOffset:Number = NaN;
   }

}