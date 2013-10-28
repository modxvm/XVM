package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;


   public class ToolTipRSSNews extends ToolTipSpecial
   {
          
      public function ToolTipRSSNews() {
         super();
         contentMargin.top = 8;
         contentMargin.bottom = 17;
         contentMargin.left = 18;
         this.initControls();
      }

      private static const MAX_WIDTH:Number = 283;

      private static const GAP:Number = 13;

      private var headerTF:TextField;

      private var descriptionTF:TextField;

      private var whiteBg:Sprite;

      private var separator:Separator;

      public function get utils() : Utils {
         return Utils.instance;
      }

      override public function build(param1:Object, param2:ITooltipProps) : void {
         var _loc3_:Array = param1 as Array;
         var _loc4_:Object = {"data":
            {
               "header":_loc3_[0],
               "description":_loc3_[1]
            }
         };
         super.build(_loc4_,param2);
      }

      override protected function redraw() : void {
         var _loc2_:String = null;
         topPosition = bgShadowMargin.top + contentMargin.top;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         separators = new Vector.<Separator>();
         var _loc1_:String = _data.header;
         _loc2_ = _data.description;
         this.headerTF.htmlText = this.utils.htmlWrapper(_loc1_,this.utils.COLOR_HEADER,16,"$TitleFont",false);
         this.headerTF.width = MAX_WIDTH - contentMargin.left;
         this.headerTF.height = this.headerTF.textHeight + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition = topPosition + (this.headerTF.textHeight + GAP);
         this.separator = this.utils.createSeparate(content);
         this.separator.y = topPosition;
         this.whiteBg.y = topPosition;
         topPosition = topPosition + GAP;
         if(_loc2_)
         {
            this.descriptionTF.htmlText = this.utils.htmlWrapper(_loc2_,this.utils.COLOR_NORMAL,12,"$TextFont",false);
            this.descriptionTF.width = MAX_WIDTH - contentMargin.left;
            this.descriptionTF.height = this.descriptionTF.textHeight + 5;
            this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
            this.descriptionTF.y = topPosition;
         }
         else
         {
            this.descriptionTF.width = 0;
            this.descriptionTF.visible = false;
            this.separator.visible = false;
            this.whiteBg.y = 0;
            this.whiteBg.visible = false;
            contentMargin.bottom = 9;
         }
         super.redraw();
      }

      override protected function updateSize() : void {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
         this.whiteBg.height = content.height - this.whiteBg.y + contentMargin.bottom;
      }

      private function initControls() : void {
         this.headerTF = content.headerTF;
         this.descriptionTF = content.descriptionTF;
         this.whiteBg = content.whiteBg;
      }
   }

}