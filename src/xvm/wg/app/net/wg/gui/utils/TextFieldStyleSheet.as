package net.wg.gui.utils
{
   import flash.text.TextField;
   import flash.text.StyleSheet;
   
   public class TextFieldStyleSheet extends Object
   {
      
      public function TextFieldStyleSheet() {
         super();
      }
      
      public static const LINK_COLOR_NORMAL:String = "#8C8C7E";
      
      public static const LINK_COLOR_HOVER:String = "#FF0000";
      
      public static function setLinkStyle(param1:TextField) : void {
         var _loc2_:StyleSheet = param1.styleSheet;
         if(_loc2_ == null)
         {
            _loc2_ = new StyleSheet();
         }
         _loc2_.setStyle("a:link",
            {
               "color":LINK_COLOR_NORMAL,
               "textDecoration":"underline"
            });
         _loc2_.setStyle("a:hover",
            {
               "color":LINK_COLOR_HOVER,
               "textDecoration":"underline"
            });
         param1.styleSheet = _loc2_;
      }
   }
}
