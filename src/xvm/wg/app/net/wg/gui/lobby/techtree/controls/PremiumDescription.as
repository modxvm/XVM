package net.wg.gui.lobby.techtree.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
   import flash.text.TextFormat;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;


   public class PremiumDescription extends UIComponent
   {
          
      public function PremiumDescription() {
         super();
         this.textFormat = new TextFormat();
         this.textFormat.align = TextFormatAlign.LEFT;
         this.textFormat.leading = -3;
      }

      public static const ELITE_SUFFIX:String = "_elite";

      public static const TITLE_PADDING:Number = 5;

      private var _data:ExtraInformation;

      private var textFormat:TextFormat;

      public var titleField:TextField;

      public var benefitField:TextField;

      public var contentField:TextField;

      public var typeIcon:MovieClip;

      public function setData(param1:ExtraInformation) : void {
         if(param1 == null)
         {
            return;
         }
         this._data = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         if(!(this._data == null) && (isInvalid(InvalidationType.DATA)))
         {
            if(this.titleField != null)
            {
               this.titleField.autoSize = TextFieldAutoSize.LEFT;
               this.titleField.htmlText = this._data.title != null?this._data.title:"";
               this.titleField.setTextFormat(this.textFormat);
               this.titleField.width = this.titleField.textWidth + TITLE_PADDING;
            }
            if(this.benefitField != null)
            {
               this.benefitField.text = this._data.benefitsHead != null?this._data.benefitsHead:"";
            }
            if(this.contentField != null)
            {
               this.contentField.multiline = true;
               this.contentField.wordWrap = true;
               this.contentField.autoSize = TextFieldAutoSize.LEFT;
               this.contentField.htmlText = this._data.benefitsList != null?this._data.benefitsList:"";
            }
            if(this.typeIcon != null)
            {
               this.typeIcon.gotoAndStop(this._data.type + ELITE_SUFFIX);
            }
         }
         super.draw();
      }
   }

}