package net.wg.gui.lobby.techtree.constants
{
    public class NodeState extends Object
    {
        
        public function NodeState()
        {
            super();
        }
        
        public static var LOCKED:uint = 1;
        
        public static var NEXT_2_UNLOCK:uint = 2;
        
        public static var UNLOCKED:uint = 4;
        
        public static var ENOUGH_XP:uint = 8;
        
        public static var ENOUGH_MONEY:uint = 16;
        
        public static var IN_INVENTORY:uint = 32;
        
        public static var WAS_IN_BATTLE:uint = 64;
        
        public static var ELITE:uint = 128;
        
        public static var PREMIUM:uint = 256;
        
        public static var SELECTED:uint = 512;
        
        public static var AUTO_UNLOCKED:uint = 1024;
        
        public static var INSTALLED:uint = 2048;
        
        public static var SHOP_ACTION:uint = 4096;
        
        public static var CAN_SELL:uint = 8192;
        
        public static var VEHICLE_CAN_BE_CHANGED:uint = 16384;
    }
}
