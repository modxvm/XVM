package net.wg.gui.lobby.techtree.constants
{


   public class NavIndicator extends Object
   {
          
      public function NavIndicator() {
         super();
      }

      public static const TOP_NAV_INDICATOR_SOURCE:String = "TopNavIndicator";

      public static const NEXT_NAV_INDICATOR_SOURCE:String = "NextNavIndicator";

      public static function isDraw(param1:uint) : Boolean {
         return param1 == NodeEntityType.TOP_VEHICLE || param1 == NodeEntityType.NEXT_VEHICLE;
      }

      public static function getSource(param1:uint) : String {
         var _loc2_:String = NEXT_NAV_INDICATOR_SOURCE;
         if(param1 == NodeEntityType.TOP_VEHICLE)
         {
            _loc2_ = TOP_NAV_INDICATOR_SOURCE;
         }
         return _loc2_;
      }
   }

}