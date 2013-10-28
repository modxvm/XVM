package net.wg.data.gui_items
{


   public class ItemsUtils extends Object
   {
          
      public function ItemsUtils() {
         super();
      }

      public static function formatFloatStr(param1:Number) : String {
         if(App.utils)
         {
            return App.utils.locale.numberWithoutZeros(param1);
         }
         return param1.toString();
      }

      public static function formatIntegerStr(param1:Number) : String {
         if(App.utils)
         {
            return App.utils.locale.integer(param1);
         }
         return param1.toString();
      }

      public static function floatToPercent(param1:Number) : String {
         var param1:Number = param1 * 100;
         if(App.utils)
         {
            return App.utils.locale.numberWithoutZeros(param1);
         }
         return param1.toString();
      }
   }

}