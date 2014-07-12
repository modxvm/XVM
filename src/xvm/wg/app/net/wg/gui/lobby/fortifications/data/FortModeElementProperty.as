package net.wg.gui.lobby.fortifications.data
{
   public class FortModeElementProperty extends Object
   {
      
      public function FortModeElementProperty(param1:uint) {
         super();
         this._value = param1;
      }
      
      private var _value:uint;
      
      public function get isAnimated() : Boolean {
         return this._value >> 1 == 0;
      }
      
      public function get isVisible() : Boolean {
         return this._value % 2 == 0;
      }
      
      public function toString() : String {
         return "visible:" + this.isVisible + " /animated: " + this.isAnimated;
      }
   }
}
