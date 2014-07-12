package net.wg.gui.components.common.markers.data
{
    public class VehicleMarkerFlags extends Object
    {
        
        public function VehicleMarkerFlags() {
            super();
        }
        
        public static var DAMAGE_ATTACK:String = "attack";
        
        public static var DAMAGE_FIRE:String = "fire";
        
        public static var DAMAGE_RAMMING:String = "ramming";
        
        public static var DAMAGE_WORLD_COLLISION:String = "world_collision";
        
        public static var DAMAGE_DEATH_ZONE:String = "death_zone";
        
        public static var DAMAGE_DROWNING:String = "drowning";
        
        public static var DAMAGE_EXPLOSION:String = "explosion";
        
        public static var DAMAGE_FROM:Array;
        
        public static var DAMAGE_COLOR:Object;
        
        public static var ALL_DAMAGE_TYPES:Array;
        
        public static var ALLOWED_DAMAGE_TYPES:Array;
        
        public static function checkAllowedDamages(param1:String) : Boolean {
            return param1 == ""?true:!(ALLOWED_DAMAGE_TYPES.indexOf(param1) == -1);
        }
    }
}
