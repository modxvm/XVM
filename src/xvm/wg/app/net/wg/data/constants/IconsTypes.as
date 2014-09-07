package net.wg.data.constants
{
    public class IconsTypes extends Object
    {
        
        public function IconsTypes()
        {
            super();
        }
        
        public static var EMPTY:String = "empty";
        
        public static var CREDITS:String = "credits";
        
        public static var GOLD:String = "gold";
        
        public static var GOLD_DISCOUNT:String = "goldDiscount";
        
        public static var XP:String = "xp";
        
        public static var ELITE_XP:String = "eliteXp";
        
        public static var ELITE:String = "elite";
        
        public static var ARROW_DOWN:String = "arrowDown";
        
        public static var ARROW_UP:String = "arrowUp";
        
        public static var ARROW_DOWN_DISABLED:String = "arrowDownDisabled";
        
        public static var ELITE_TANK_XP:String = "elite_tank_xp";
        
        public static var FREE_XP:String = "freeXp";
        
        public static var TANK_DAILYXPFACTOR:String = "tank_dailyXPFactor";
        
        public static var TANK_UNLOCK_PRICE:String = "tank_unlock_price";
        
        public static var DOUBLE_XP_FACTOR:String = "doubleXPFactor";
        
        public static var ACTION_XP_FACTOR:String = "actionXPFactor";
        
        public static var VCOIN:String = "vcoin";
        
        public static var CLASS1:String = "class1";
        
        public static var CLASS2:String = "class2";
        
        public static var CLASS3:String = "class3";
        
        public static var CLASS4:String = "class4";
        
        public static var XP_PRICE:String = "xp_price";
        
        public static var DEFRES:String = "defRes";
        
        public static var ALLOW_ICONS:Array = [EMPTY,CREDITS,GOLD,GOLD_DISCOUNT,XP,ELITE_XP,ELITE,ARROW_DOWN,ARROW_UP,ARROW_DOWN_DISABLED,ELITE_TANK_XP,FREE_XP,TANK_DAILYXPFACTOR,TANK_UNLOCK_PRICE,DOUBLE_XP_FACTOR,ACTION_XP_FACTOR,VCOIN,CLASS1,CLASS2,CLASS3,CLASS4,XP_PRICE,DEFRES];
        
        public static function getTextColor(param1:String) : Number
        {
            var _loc2_:Number = -1;
            switch(param1)
            {
                case CREDITS:
                    _loc2_ = 13556185;
                    break;
                case GOLD:
                    _loc2_ = 16761699;
                    break;
                case FREE_XP:
                    _loc2_ = 13224374;
                    break;
            }
            return _loc2_;
        }
    }
}
