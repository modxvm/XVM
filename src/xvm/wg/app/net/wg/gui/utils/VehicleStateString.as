package net.wg.gui.utils
{
   import flash.text.TextField;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import net.wg.data.constants.VehicleState;
   
   public class VehicleStateString extends Object
   {
      
      public function VehicleStateString() {
         super();
      }
      
      public static function getI18nKey(param1:String) : String {
         return param1.length > 0?MENU.tankcarousel_vehiclestates(param1):"";
      }
      
      public static function appendText(param1:TextField, param2:String) : void {
         var _loc3_:Array = [];
         var _loc4_:Number = 0;
         var _loc5_:* = null;
         switch(param2)
         {
            case VehicleState.IN_BATTLE:
            case VehicleState.IN_PREBATTLE:
               _loc4_ = 13617064;
               _loc5_ = new DropShadowFilter();
               _loc5_.distance = 0;
               _loc5_.angle = 90;
               _loc5_.color = 0;
               _loc5_.alpha = 0.25;
               _loc5_.blurX = 8;
               _loc5_.blurY = 8;
               _loc5_.strength = 16;
               _loc5_.quality = 2;
               _loc5_.inner = false;
               _loc5_.knockout = false;
               _loc5_.hideObject = false;
               _loc3_.push(_loc5_);
               break;
            case VehicleState.BUY_VEHICLE:
            case VehicleState.BUY_SLOT:
               _loc4_ = 15329754;
               _loc5_ = new GlowFilter();
               _loc5_.color = 16777150;
               _loc5_.alpha = 0.2;
               _loc5_.blurX = 15;
               _loc5_.blurY = 15;
               _loc5_.strength = 4;
               _loc5_.quality = 2;
               _loc5_.inner = false;
               _loc5_.knockout = false;
               _loc3_.push(_loc5_);
               break;
            case VehicleState.AMMO_NOT_FULL:
            case VehicleState.CREW_NOT_FULL:
            case VehicleState.EXPLODED:
            case VehicleState.DESTROYED:
            case VehicleState.DAMAGED:
               _loc4_ = 15400960;
               _loc5_ = new DropShadowFilter();
               _loc5_.distance = 0;
               _loc5_.angle = 90;
               _loc5_.color = 0;
               _loc5_.alpha = 0.25;
               _loc5_.blurX = 8;
               _loc5_.blurY = 8;
               _loc5_.strength = 16;
               _loc5_.quality = 2;
               _loc5_.inner = false;
               _loc5_.knockout = false;
               _loc5_.hideObject = false;
               _loc3_.push(_loc5_);
               break;
         }
         param1.text = getI18nKey(param2);
         param1.textColor = _loc4_;
         param1.filters = _loc3_;
      }
   }
}
