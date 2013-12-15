package net.wg.gui.lobby.techtree.data.vo
{


   public class ActionData extends Object
   {
          
      public function ActionData(param1:Number=undefined, param2:Number=undefined, param3:Number=undefined) {
         super();
         this.price = param1;
         this.defaultPrice = param2;
         this.actionPrice = param3;
      }

      public var price:Number;

      public var defaultPrice:Number;

      public var actionPrice:Number;

      public function toString() : String {
         return "[ActionData: price = " + this.price + ", defaultPrice = " + this.defaultPrice + " actionPrice = " + this.actionPrice + "]";
      }
   }

}