package net.wg.gui.components.common.markers.data
{
   public class VehicleMarkerFlags extends Object
   {
      
      public function VehicleMarkerFlags() {
         super();
      }
      
      public static const DAMAGE_ATTACK:String = "attack";
      
      public static const DAMAGE_FIRE:String = "fire";
      
      public static const DAMAGE_RAMMING:String = "ramming";
      
      public static const DAMAGE_WORLD_COLLISION:String = "world_collision";
      
      public static const DAMAGE_DEATH_ZONE:String = "death_zone";
      
      public static const DAMAGE_DROWNING:String = "drowning";
      
      public static const DAMAGE_EXPLOSION:String = "explosion";
      
      public static const DAMAGE_FROM:Array;
      
      public static const DAMAGE_COLOR:Object;
      
      public static const ALL_DAMAGE_TYPES:Array;
      
      public static const ALLOWED_DAMAGE_TYPES:Array;
      
      public static function checkAllowedDamages(param1:String) : Boolean {
         return param1 == ""?true:!(ALLOWED_DAMAGE_TYPES.indexOf(param1) == -1);
      }
   }
}
