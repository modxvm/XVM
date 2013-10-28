package net.wg.gui.components.controls
{


   public class RegionDropdownMenu extends DropdownMenu
   {
          
      public function RegionDropdownMenu() {
         super();
      }

      private static function makeHtmlText(param1:String, param2:Number=16761699) : String {
         return "<font color=\'#" + param2.toString(16) + "\'>" + param1 + "</font>";
      }

      private var _textColor:Number = 16761699;

      public function get textColor() : Number {
         return this._textColor;
      }

      public function set textColor(param1:Number) : void {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidateData();
      }

      override protected function updateText() : void {
         if(!(_label == null) && !(textField == null))
         {
            textField.htmlText = _label?App.utils.locale.makeString(MENU.HEADER_SERVERINFO) + " " + makeHtmlText("\"" + _label + "\"",this.textColor):"";
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.handleScroll = false;
      }
   }

}