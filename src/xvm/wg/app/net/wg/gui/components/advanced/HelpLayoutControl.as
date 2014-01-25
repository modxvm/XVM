package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IDynamicContent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.data.constants.Directions;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;


   public class HelpLayoutControl extends UIComponent implements IDynamicContent
   {
          
      public function HelpLayoutControl() {
         super();
      }

      public var textField:TextField;

      public var connector:MovieClip;

      public var border:MovieClip;

      private var _text:String = "";

      private var _direction:String = "T";

      private var _borderWidth:Number = 256;

      private var _borderHeight:Number = 256;

      private var _connectorLength:Number = 12;

      override protected function onDispose() : void {
         this.textField = null;
         this.connector = null;
         this.border = null;
         super.onDispose();
      }

      public function get connectorLength() : Number {
         return this._connectorLength;
      }

      public function set connectorLength(param1:Number) : void {
         this._connectorLength = param1;
      }

      public function set borderWidth(param1:Number) : void {
         this._borderWidth = param1;
      }

      public function set borderHeight(param1:Number) : void {
         this._borderHeight = param1;
      }

      public function set direction(param1:String) : void {
         App.utils.asserter.assert(!(Directions.LAYOUT_DIRECTIONS.indexOf(param1) == -1),"invalid direction: " + param1);
         this._direction = param1;
      }

      public function set text(param1:String) : void {
         this._text = param1;
      }

      override protected function draw() : void {
         super.draw();
         scaleX = scaleY = 1;
         this.border.width = this._borderWidth;
         this.border.height = this._borderHeight;
         this.setConnectorPosition();
         this.setTextFieldPosition();
         super.draw();
      }

      private function setConnectorPosition() : void {
         if(this.connector == null)
         {
            return;
         }
         this.connector.height = this._connectorLength;
         switch(this._direction)
         {
            case "T":
               this.connector.rotation = 180;
               this.connector.x = this._borderWidth >> 1;
               this.connector.y = 0;
               break;
            case "R":
               this.connector.rotation = -90;
               this.connector.x = this._borderWidth;
               this.connector.y = (this._borderHeight >> 1) - (this.connector.height >> 1);
               break;
            case "B":
               this.connector.x = this._borderWidth >> 1;
               this.connector.y = this._borderHeight;
               break;
            case "L":
               this.connector.rotation = 90;
               this.connector.x = 0;
               this.connector.y = (this._borderHeight >> 1) - (this.connector.height >> 1);
               break;
         }
      }

      private function setTextFieldPosition() : void {
         if(this.textField == null)
         {
            return;
         }
         this.textField.wordWrap = true;
         var _loc1_:TextFormat = new TextFormat();
         switch(this._direction)
         {
            case "T":
               this.textField.autoSize = TextFieldAutoSize.CENTER;
               _loc1_.align = TextFormatAlign.CENTER;
               this.textField.text = this._text;
               this.textField.x = (this._borderWidth >> 1) - (this.textField.width >> 1);
               this.textField.y = -(this.connector.height + this.textField.textHeight + 2);
               break;
            case "R":
               this.textField.autoSize = TextFieldAutoSize.LEFT;
               _loc1_.align = TextFormatAlign.LEFT;
               this.textField.text = this._text;
               this.textField.x = this._borderWidth + this.connector.width;
               this.textField.y = (this._borderHeight >> 1) - (this.textField.textHeight >> 1) - 4;
               break;
            case "B":
               this.textField.autoSize = TextFieldAutoSize.CENTER;
               _loc1_.align = TextFormatAlign.CENTER;
               this.textField.text = this._text;
               this.textField.x = (this._borderWidth >> 1) - (this.textField.width >> 1);
               this.textField.y = this._borderHeight + this.connector.height + 2;
               break;
            case "L":
               this.textField.autoSize = TextFieldAutoSize.RIGHT;
               _loc1_.align = TextFormatAlign.RIGHT;
               this.textField.text = this._text;
               this.textField.x = -(this.connector.width + this.textField.width);
               this.textField.y = (this._borderHeight >> 1) - (this.textField.textHeight >> 1) - 4;
               break;
         }
         this.textField.setTextFormat(_loc1_);
      }
   }

}