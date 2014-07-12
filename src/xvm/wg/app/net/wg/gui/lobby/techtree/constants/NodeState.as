package net.wg.gui.lobby.techtree.constants
{
   public class NodeState extends Object
   {
      
      public function NodeState() {
         super();
      }
      
      public static const LOCKED:uint = 1;
      
      public static const NEXT_2_UNLOCK:uint = 2;
      
      public static const UNLOCKED:uint = 4;
      
      public static const ENOUGH_XP:uint = 8;
      
      public static const ENOUGH_MONEY:uint = 16;
      
      public static const IN_INVENTORY:uint = 32;
      
      public static const WAS_IN_BATTLE:uint = 64;
      
      public static const ELITE:uint = 128;
      
      public static const PREMIUM:uint = 256;
      
      public static const SELECTED:uint = 512;
      
      public static const AUTO_UNLOCKED:uint = 1024;
      
      public static const INSTALLED:uint = 2048;
      
      public static const SHOP_ACTION:uint = 4096;
      
      public static const CAN_SELL:uint = 8192;
      
      public static const VEHICLE_CAN_BE_CHANGED:uint = 16384;
   }
}
