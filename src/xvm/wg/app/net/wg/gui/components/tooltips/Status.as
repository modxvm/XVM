package net.wg.gui.components.tooltips
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;


   public class Status extends UIComponent
   {
          
      public function Status() {
         super();
         this.init();
      }

      public static var ICO_NEWSKILL:String = "newskill";

      public var textFieldHeader:TextField = null;

      public var textField:TextField = null;

      public var icon:MovieClip = null;

      private var _statusColors:ToolTipStatusColorsVO;

      private var _header:String;

      private var _text:String;

      private var _textColor:uint = 0;

      private const ICO_DEF:String = "none";

      private var _ico:String = "none";

      private var textFormat:TextFormat = null;

      private function init() : void {
         this.textFieldHeader.multiline = true;
         this.textFieldHeader.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldHeader.wordWrap = true;
         this.textField.multiline = true;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.wordWrap = true;
         this.textFormat = new TextFormat();
      }

      public function setData(param1:String=null, param2:String=null, param3:ToolTipStatusColorsVO=null, param4:String="none") : Number {
         var _loc5_:Number = 0;
         this._header = param1;
         this._text = param2;
         this._statusColors = param3;
         this._textColor = param3.textColor?param3.textColor:16777215;
         this._ico = param4;
         this.icon.gotoAndStop(this._ico);
         if(this._ico != this.ICO_DEF)
         {
            this.textFieldHeader.x = this.icon.width;
            this.textField.x = this.icon.width;
         }
         this.textFieldHeader.text = this._header;
         this.textField.text = this._text;
         this.textFormat.color = this._textColor;
         if(param2)
         {
            this.textFormat.align = TextFormatAlign.LEFT;
            this.textField.y = param1?this.textFieldHeader.textHeight + 4 | 0:0;
         }
         else
         {
            this.textField.visible = false;
         }
         this.textFieldHeader.setTextFormat(this.textFormat);
         this.textField.setTextFormat(this.textFormat);
         this.filters = param3.filters;
         _loc5_ = Math.max(this.textFieldHeader.textWidth,this.textField.textWidth);
         invalidate();
         return _loc5_;
      }

      override protected function draw() : void {
         super.draw();
      }

      public function updateWidth(param1:Number) : void {
         if(this._ico != this.ICO_DEF)
         {
            param1 = param1 - this.icon.width;
            this.textFieldHeader.x = this.icon.width;
            this.textField.x = this.icon.width;
         }
         this.textFieldHeader.width = param1;
         this.textField.width = param1;
         if(this._text)
         {
            this.textField.y = this._header?this.textFieldHeader.textHeight + 4 | 0:0;
         }
      }

      override public function get height() : Number {
         return _originalHeight;
      }
   }

}