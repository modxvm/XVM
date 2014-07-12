package net.wg.gui.prebattle.constants
{
   public class PrebattleStateFlags extends Object
   {
      
      public function PrebattleStateFlags() {
         super();
      }
      
      public static var UNKNOWN:uint = 0;
      
      public static var NOT_READY:uint = 1;
      
      public static var AFK:uint;
      
      public static var READY:uint = 4;
      
      public static var IN_BATTLE:uint = 8;
      
      public static var OFFLINE:uint = 16;
   }
}
