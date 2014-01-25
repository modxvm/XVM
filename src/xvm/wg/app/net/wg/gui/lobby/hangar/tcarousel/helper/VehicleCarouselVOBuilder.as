package net.wg.gui.lobby.hangar.tcarousel.helper
{
   import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;


   public class VehicleCarouselVOBuilder extends Object
   {
          
      public function VehicleCarouselVOBuilder() {
         super();
      }

      private static var __instance:VehicleCarouselVOBuilder;

      private static var __allowInstantiation:Boolean = false;

      public static function get instance() : VehicleCarouselVOBuilder {
         if(!__instance)
         {
            __allowInstantiation = true;
            __instance = new VehicleCarouselVOBuilder();
            __allowInstantiation = false;
         }
         return __instance;
      }

      public function getDataVoForEmptySlot() : VehicleCarouselVO {
         var _loc1_:VehicleCarouselVO = new VehicleCarouselVO();
         _loc1_.empty = true;
         return _loc1_;
      }

      public function getDataVoForBuyVehicle(param1:Number) : VehicleCarouselVO {
         var _loc2_:VehicleCarouselVO = new VehicleCarouselVO();
         _loc2_.stat = "buyTank";
         _loc2_.buyTank = true;
         _loc2_.stateLevel = "buyState";
         _loc2_.availableSlots = param1;
         return _loc2_;
      }

      public function getDataVoForBuySlot(param1:Number, param2:Number, param3:Number) : VehicleCarouselVO {
         var _loc4_:VehicleCarouselVO = new VehicleCarouselVO();
         _loc4_.stat = "buySlot";
         _loc4_.buySlot = true;
         _loc4_.stateLevel = "buyState";
         _loc4_.slotPrice = param1;
         _loc4_.defSlotPrice = param2;
         _loc4_.slotPricePrc = param3;
         return _loc4_;
      }
   }

}