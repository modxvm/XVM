package net.wg.gui.lobby.vehicleBuyWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class BuyingVehicleVO extends DAAPIDataClass
   {
          
      public function BuyingVehicleVO(param1:Object) {
         super(param1);
      }

      public var name:String = "";

      public var longName:String = "";

      public var type:String = "";

      public var icon:String = "";

      public var description:String = "";

      public var nation:uint;

      public var level:uint;

      private var _isPremium:Boolean;

      public var isElite:Boolean;

      public var tankmenCount:uint;

      public var studyPriceCredits:Number;

      public var defStudyPriceCredits:Number;

      public var actionPrcStudyCredits:Number;

      public var studyPriceGold:Number;

      public var defStudyPriceGold:Number;

      public var actionPrcStudyGold:Number;

      private var _vehiclePrices:Array;

      private var _defVehiclePrices:Array;

      private var _actualPrice:uint;

      private var _defActualPrice:uint;

      public var actionPrc:Number;

      public var ammoPrice:Number;

      public var defAmmoPrice:Number;

      public var ammoActionPrc:Number;

      public var slotPrice:uint;

      public var defSlotPrice:uint;

      public var slotActionPrc:Number;

      public function get isPremium() : Boolean {
         return this._isPremium;
      }

      public function get actualPrice() : uint {
         return this._actualPrice;
      }

      public function get defActualPrice() : uint {
         return this._defActualPrice;
      }

      public function get vehiclePrices() : Array {
         return this._vehiclePrices;
      }

      public function set vehiclePrices(param1:Array) : void {
         this._vehiclePrices = param1;
         if(this._vehiclePrices[1] != 0)
         {
            this._actualPrice = this._vehiclePrices[1];
            this._isPremium = true;
         }
         else
         {
            this._actualPrice = this._vehiclePrices[0];
            this._isPremium = false;
         }
      }

      public function get defVehiclePrices() : Array {
         return this._defVehiclePrices;
      }

      public function set defVehiclePrices(param1:Array) : void {
         this._defVehiclePrices = param1;
         if(this.defVehiclePrices[1] != 0)
         {
            this._defActualPrice = this._defVehiclePrices[1];
         }
         else
         {
            this._defActualPrice = this._defVehiclePrices[0];
         }
      }
   }

}