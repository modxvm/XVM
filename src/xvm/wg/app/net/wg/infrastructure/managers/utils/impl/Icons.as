package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IIcons;


   public class Icons extends Object implements IIcons
   {
          
      public function Icons() {
         super();
      }

      public static const EMPTY:String = "empty";

      public static const CREDITS:String = "credits";

      public static const GOLD:String = "gold";

      public static const GOLD_DISCOUNT:String = "goldDiscount";

      public static const XP:String = "xp";

      public static const ELITE_XP:String = "eliteXp";

      public static const elite:String = "elite";

      public static const ARROW_DOWN:String = "arrowDown";

      public static const ARROW_UP:String = "arrowUp";

      public static const ARROW_DOWN_DISABLED:String = "arrowDownDisabled";

      public static const ELITE_TANK_XP:String = "elite_tank_xp";

      public static const FREE_XP:String = "freeXp";

      public static const TANK_DAILYXPFACTOR:String = "tank_dailyXPFactor";

      public static const TANK_UNLOCK_PRICE:String = "tank_unlock_price";

      public static const DOUBLE_XP_FACTOR:String = "doubleXPFactor";

      public static const ACTION_XP_FACTOR:String = "actionXPFactor";

      public static const VCOIN:String = "vcoin";

      public static const CLASS1:String = "class1";

      public static const CLASS2:String = "class2";

      public static const CLASS3:String = "class3";

      public static const CLASS4:String = "class4";

      public static const XP_PRICE:String = "xp_price";

      public function getIcon16StrPath(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:uint = 16;
         var _loc4_:uint = 16;
         switch(param1)
         {
            case GOLD:
               _loc2_ = "GoldIcon-2.png";
               break;
            case CREDITS:
               _loc2_ = "CreditsIcon-2.png";
               break;
            case ELITE_XP:
               _loc2_ = "EliteXpIcon-2.png";
               break;
            case FREE_XP:
               _loc2_ = "FreeXpIcon-2.png";
               _loc3_ = _loc4_ = 18;
               break;
         }
         if(_loc2_ == "")
         {
            DebugUtils.LOG_WARNING("Can\'t find icon constant name for ID: " + param1);
         }
         else
         {
            _loc2_ = "<IMG SRC=\"img://gui/maps/icons/library/" + _loc2_ + "\" width=\"" + _loc3_ + "\" height=\"" + _loc4_ + "\" vspace=\"-4\"/>";
         }
         return _loc2_;
      }
   }

}