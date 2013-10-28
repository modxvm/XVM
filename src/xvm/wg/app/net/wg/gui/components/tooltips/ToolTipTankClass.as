package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.utils.ILocale;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;


   public class ToolTipTankClass extends ToolTipSpecial
   {
          
      public function ToolTipTankClass() {
         super();
         this.initControls();
      }

      private var headerTF:TextField;

      private var descriptionTF:TextField;

      private var whiteBg:Sprite;

      private var separator:Separator;

      public function get utils() : Utils {
         return Utils.instance;
      }

      override protected function redraw() : void {
         var _loc1_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         contentMargin.left = 19;
         topPosition = bgShadowMargin.top + contentMargin.top;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         separators = new Vector.<Separator>();
         _loc1_ = _data.value;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.leading = -2;
         _loc2_.align = TextFormatAlign.LEFT;
         var _loc3_:String = "<img src=\"img://gui/maps/icons/library/proficiency/class_icons_" + _loc1_ + ".png\" WIDTH=\"32\" HEIGHT=\"32\" VSPACE=\"-10\"/>&nbsp;&nbsp;" + this.utils.htmlWrapper(_data.name,this.utils.COLOR_HEADER,18,"$TitleFont",false);
         this.headerTF.htmlText = _loc3_;
         this.headerTF.setTextFormat(_loc2_);
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition = topPosition + (this.headerTF.textHeight + 12);
         this.separator = this.utils.createSeparate(content);
         this.separator.y = topPosition;
         this.whiteBg.y = topPosition;
         topPosition = topPosition + this.utils.MARGIN_AFTER_BLOCK;
         var _loc4_:ILocale = App.utils.locale;
         var _loc5_:* = "<font face=\"$TextFont\" size=\"11\" color=\"" + this.utils.COLOR_NUMBER + "\">" + _loc4_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + _loc1_) + "%</font>";
         var _loc6_:* = "<font face=\"$TextFont\" size=\"11\" color=\"" + this.utils.COLOR_NORMAL + "\">" + _loc4_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT,{"val":_loc5_}) + "</font>";
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.htmlText = _loc6_;
         this.descriptionTF.width = this.descriptionTF.textWidth + 5;
         this.descriptionTF.height = this.descriptionTF.textHeight + 5;
         this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
         this.descriptionTF.y = topPosition;
         topPosition = topPosition + (this.descriptionTF.height + 5);
         var _loc7_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc7_.contener = content;
         _loc7_.startYPos = topPosition;
         _loc7_.leftTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NUMBER);
         _loc7_.leftText = "";
         _loc7_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         _loc7_.rightTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NORMAL);
         var _loc8_:* = 4;
         while(_loc8_ > 0)
         {
            _loc10_ = _loc4_.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + _loc8_) + "%";
            _loc7_.leftText = _loc7_.leftText + (this.utils.htmlWrapper(_loc10_,this.utils.COLOR_NUMBER,11,"$TextFont",false) + "<br>");
            _loc11_ = ACHIEVEMENTS.achievement("master" + _loc8_);
            _loc12_ = "class" + _loc8_;
            _loc7_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc11_,_loc12_,-1,4));
            _loc8_--;
         }
         var _loc9_:ToolTipBlockResultVO = Utils.instance.createBlock(_loc7_,contentMargin.left + bgShadowMargin.left);
         blockResults.push(_loc9_);
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