package net.wg.gui.lobby.hangar.tcarousel.data
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class VehicleCarouselVO extends Object
   {
      
      public function VehicleCarouselVO() {
         super();
      }
      
      public var data:Number = -1;
      
      public var id:Number = 0;
      
      public var inventoryId:Number = -1;
      
      public var label:String = "";
      
      public var image:String = "";
      
      public var nation:Number = 0;
      
      public var level:Number = 0;
      
      public var stat:String = "";
      
      public var stateLevel:String = "";
      
      public var type:String = "";
      
      public var exp:Number = 0;
      
      public var doubleXPReceived:Number = 0;
      
      public var compactDescr:Number = 0;
      
      public var favorite:Boolean = false;
      
      public var canSell:Boolean = false;
      
      public var elite:Boolean = false;
      
      public var premium:Boolean = false;
      
      public var clanLock:Number = -1;
      
      public var current:Number = 0;
      
      public var enabled:Boolean = false;
      
      public var empty:Boolean = false;
      
      public var buyTank:Boolean = false;
      
      public var buySlot:Boolean = false;
      
      public var slotPriceActionData:ActionPriceVO = null;
      
      public var slotPrice:Number = 0;
      
      public var availableSlots:Number = 0;
      
      public function parsObj(param1:Object) : Number {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!(this[_loc2_] == undefined) && typeof this[_loc2_] == typeof param1[_loc2_])
            {
               if(_loc2_ == "slotPriceActionData" && (param1[_loc2_]))
               {
                  this.slotPriceActionData = new ActionPriceVO(param1[_loc2_]);
               }
               else
               {
                  this[_loc2_] = param1[_loc2_];
               }
            }
            else if(_loc2_ == "tankType")
            {
               this["type"] = param1[_loc2_];
            }
            else
            {
               DebugUtils.LOG_WARNING("CarouselVehicleVO parsObj(data): VO has\'t property " + _loc2_ + " or properties have different types");
            }
            
         }
         return this.compactDescr;
      }
   }
}
